unit Functions;


interface


{$REGION '--- IMPORTACIONS '}

uses
  Vcl.AxCtrls,
  System.Classes,
  System.SysUtils,
  Vcl.Forms,
  Winapi.Windows,
  StrUtils,
  INIFiles,
  IdUri,
  WinInet,
  DateUtils,
  IdBaseComponent,
  IdComponent,
  IdUDPBase,
  IdUDPServer,
  IdSocketHandle,
  Data.Win.ADODB,
  ActiveX,
  Vcl.OleServer,
  IdCustomTCPServer,
  IdTCPServer,
  IdCmdTCPServer,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdSSL,
  ESBDates,
  ShellAPI,
  IdSSLOpenSSL,
  Globals;

{$ENDREGION}


{$I ..\..\..\Common\products.inc}

type
  PLogTrace = ^TLogTrace;
  TLogTrace = record
    IdPreparacion: Integer;
    IdRecepcion: Integer;
    IdDevolucion: Integer;
    IdDevolucionP: Integer;
    IdAprovisionamiento: Integer;
    IdInventario: Integer;
    MovOrigen: String;
    Matricula: String;
  end;

{$REGION '--- DECLARACIÓ DE FUNCIONS EXTERNES'}

function LICENSE_GetLicenses ( sFile: AnsiString; var customer_code, customer_name: AnsiString; var lProductList, lLicenseList: TStringList): boolean; stdcall;
  external 'License.dll' name 'LICENSE_GetLicenses';

function LICENSE_GetInfo ( sLicense: AnsiString; var date_to: TDate;
  var num_terminals: WORD; var customer_id, product_id: AnsiString ): boolean; stdcall;
  external 'License.dll' name 'LICENSE_GetInfo';

{$ENDREGION}


{$REGION '--- FUNCIONS DE CONFIGURACIÓ'}

function  CONFIG_Read(): boolean;
function  CONFIG_Init(): boolean;
function  CONFIG_DeInit(): boolean;
function  CONFIG_ReadParams(Conn: TADOConnection): boolean;
procedure CONFIG_Server_Alive ();

{$ENDREGION}


{$REGION '--- FUNCIONS DEL SGA'}

procedure ARTEC_Sleep ( dwTime: DWORD; bCond: PBoolean );
function  WaitOperationDone ( Conn: TADOConnection; iLastID: Integer; var Status: Integer; var Mensaje: String ): Boolean;

{$ENDREGION}


{$REGION '--- FUNCIONS PER LOGS TRAÇABILITAT'}

function LOG_Clear(): TLogTrace;

procedure LOG_Add (
  Conn: TADOConnection;
  CodigoUsuario: Integer;
  UUID: String;
  IP: String;
  Accion: String;
  Observaciones: String;
  Params: PLogTrace = nil
);

{$ENDREGION}

function  IsDelphiRunning: Boolean;
function  IsOrWasUnderDebugger: Boolean;
function  StreamToString(Stream: TStream): string;
function  CanonicalizeUrl(const Url: string; dwFlags: integer): WideString;


implementation


uses
  Functions_SAGE,
  Functions_LogV2,
  Functions_PARAMS,
  Main,
  Functions_DB,
  Functions_Registry;


{$REGION '--- FUNCIONS DE CONFIGURACIÓ'}

procedure CONFIG_Server_Alive ();
var
  INIFile: TINIFile;
  ndt: TDateTime;
begin

  ndt := Now();
  if TimeApartInSecs(gdtLastLive, ndt)<30 then
    Exit;

  gdtLastLive := ndt;

  INIFile := TINIFile.Create ( gsPath + '\FS_LicenseServer.ini' );
  INIFile.WriteDateTime ( 'SGA', 'Live', gdtLastLive );
  INIFile.Free;

end;


// --------------------------------------------------------------------------
// Llegir arxiu de configuració .INI
// --------------------------------------------------------------------------
function CONFIG_Read(): Boolean;
var
  INIFile: TINIFile;
  sCustomer: String;
begin

  if not FileExists( gsPath + '\FS_LicenseServer.ini' ) then begin
    Result := FALSE;
    Exit;
  end;

  sCustomer := REGISTRY_HKLM_Read ( 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'FS_CUSTOMER' );
  if sCustomer<>'' then sCustomer := '.' + sCustomer;

  INIFile := TINIFile.Create( gsPath + '\FS_LicenseServer.ini' );

  // GENERAL
  gbMultiInstance      := INIFile.ReadBool ( 'GENERAL', 'MultiInstance', FALSE );
  gbRestartService     := INIFile.ReadBool ( 'GENERAL', 'RestartService', TRUE );
  gtRestartServiceTime := INIFile.ReadTime ( 'GENERAL', 'RestartServiceTime', StrToTime('03:00:00') );
  gbDebug              := INIFile.ReadBool ( 'GENERAL', 'Debug', False );
  gbDemo               := INIFile.ReadBool ( 'GENERAL', 'DEMO', False );
  gbUseSSL             := INIFile.ReadBool ( 'GENERAL', 'UseSSL', True );

  if not gbMultiInstance then
  begin
    sCustomer := '';
  end;

  gsProv               := INIFile.ReadString  ( 'DB' + sCustomer,  'Provider', '');
  gsHost               := INIFile.ReadString  ( 'DB' + sCustomer,  'Host',     '');
  gsBBDD               := INIFile.ReadString  ( 'DB' + sCustomer,  'BBDD' ,     '');
  gsUser               := INIFile.ReadString  ( 'DB' + sCustomer,  'User',     '');
  gsPass               := INIFile.ReadString  ( 'DB' + sCustomer,  'Password', '');
  giCodigoEmpresa      := INIFile.ReadInteger ( 'DB' + sCustomer,  'CodigoEmpresa', 1);
  gsCustomerCode       := INIFile.ReadString  ( 'DB' + sCustomer,  'CustomerCode', '');

  //[ALBARANCLIENTE]
  gsFormatoAlbaranCliente := INIFile.ReadString('ALBARANCLIENTE', 'Formato', 'Y/NS' );
  gsFormatoEjercicio      := INIFile.ReadString('ALBARANCLIENTE', 'FormatoEjercicio', '%0.4d' );
  gsFormatoSerie          := INIFile.ReadString('ALBARANCLIENTE', 'FormatoSerie', 'Y/NS' );
  gsFormatoNumero         := INIFile.ReadString('ALBARANCLIENTE', 'FormatoNumero', 'Y/NS' );

  // WEBSERVICE del SGA
  gbSGAWS_Active := INIFile.ReadBool('SGA','Active',FALSE);
  giSGAWS_Port   := INIFile.ReadInteger('SGA','Port',8080);

  INIFile.Free;

  giCodigoEmpresaOld := giCodigoEmpresa;
  Result := (gsCustomerCode<>'') and (gbSGAWS_Active) and (giSGAWS_Port<>0);

end;


function CONFIG_Init(): boolean;
begin

  gsProductList := TStringList.Create;
  gsLicenseList := TStringList.Create;

end;


function CONFIG_DeInit(): boolean;
begin

  //FreeAndNil(gsProductList);
  //FreeAndNil(gsLicenseList);

end;


function CONFIG_ReadParams(Conn: TADOConnection): boolean;
var
  sSQL: String;
  Q: TADOQuery;
  iPeriodo: Integer;
  iDia: Integer;
begin

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_GS1_Estandar, gbGS1Estandar, 0 );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_GS1_GroupSeparator, gsGS1GroupSeparator, 0 );
  // PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_TratamientoSimplificado, gbTratamientoSimplificado, 1 );

  gaLogFile.Write('Lectura de códigos GS1-128 estándar: ' + SQL_BooleanToStr(gbGS1Estandar), CONST_LOGID_GENERAL, LOG_LEVEL_INFO );

  Result := TRUE;

end;

{$ENDREGION}



procedure ARTEC_Sleep ( dwTime: DWORD; bCond: PBoolean );
var
  Start, Elapsed: DWORD;
begin

  // sleep for 'dwTime' seconds without freezing
  Start := GetTickCount;
  Elapsed := 0;
  repeat
    // (WAIT_OBJECT_0+nCount) is returned when a message is in the queue.
    // WAIT_TIMEOUT is returned when the timeout elapses.
    if MsgWaitForMultipleObjects(0, Pointer(nil)^, FALSE, dwTime-Elapsed, QS_ALLINPUT) <> WAIT_OBJECT_0 then Break;
    Application.ProcessMessages;
    Elapsed := GetTickCount - Start;
  until (bCond^) or (Elapsed >= dwTime);

end;


function WaitOperationDone ( Conn: TADOConnection; iLastID: Integer; var Status: Integer; var Mensaje: String ): Boolean;
var
  sSQLCurrentId, sSQLCount, sSQL: String;
  TC: LONGWORD;
  Id: Integer;
  iNum: Integer;
  iOldNum: Integer;
  Q: TADOQuery;
  iStart, iEnd: Integer;
  iPct: Integer;
  bFALSE: Boolean;
begin

  bFALSE := FALSE;

  sSQLCurrentId := 'SELECT ' +
                   '  oper_id ' +
                   'FROM FS_Operations WITH (NOLOCK) ' +
                   'WHERE ' +
                   '  oper_status = 0 ' +
                   'ORDER BY ' +
                   '  oper_id';
  iStart := SQL_Execute ( Conn, sSQLCurrentId );
  iEnd   := iLastID;

  Id := 0;

  sSQLCount := 'SELECT ' +
               '  COUNT(*) ' +
               'FROM FS_Operations WITH (NOLOCK) ' +
               'WHERE ' +
               '  oper_status=0';
  iOldNum := SQL_Execute ( Conn, sSQLCount );

  sSQL := 'SELECT ' +
          '  oper_id, oper_message, oper_status ' +
          'FROM FS_Operations WITH (NOLOCK) ' +
          'WHERE ' +
          '  oper_id = ' + IntToStr(iLastID) + ' AND ' +
          '  oper_status<>0';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  TC := GetTickCount();

  while ((Id=0) AND (TC+20000>GetTickCount())) do begin

    // Allarguem el plaç perquè s'executi l'operació que estem esperant
    iNum := SQL_Execute ( Conn, sSQLCount );
    if iOldNum <> iNum then begin
      TC      := GetTickCount();
      iOldNum := iNum;
      iStart := SQL_Execute ( Conn, sSQLCurrentId );
    end;

    Q.Open;
    Id      := Q.Fields[0].AsInteger;
    Mensaje := Q.Fields[1].AsString;
    Status  := Q.Fields[2].AsInteger;
    Q.Close;

    if Id=0 then
      ARTEC_Sleep ( 1000, @bFALSE );

  end;

  Q.Free;

  Result := (Id<>0);

  if Id=0 then
    Mensaje := 'Tiempo de espera superado sin procesar la operación';

end;


function IsDelphiRunning: Boolean;
begin
  Result := (FindWindow('TAppBuilder', nil) > 0) and
    (FindWindow('TPropertyInspector', 'Object Inspector') > 0);
end;


function IsOrWasUnderDebugger: Boolean;
begin
  Result := DebugHook <> 0;
end;


function StreamToString(Stream: TStream): string;
var
  ms: TMemoryStream;
begin
  Result := '';
  ms := TMemoryStream.Create;
  try
    ms.LoadFromStream(Stream);
    SetString(Result, PAnsiChar(ms.memory), ms.Size);
  finally
    ms.Free;
  end;
end;


function CanonicalizeUrl(const Url: string; dwFlags: integer): WideString;
var
  Buffer: array[0..8192] of WideChar;
  Size: DWORD;
  bResult: boolean;
begin
  Size := SizeOf(Buffer);
  bResult := InternetCanonicalizeUrlW(PWideChar(Url), Buffer, Size, dwFlags);
  if bResult then
  begin
    Result := Buffer;
  end
  else
  begin
    Result := '';
  end;
end;


{$REGION '--- FUNCIONS PER LOGS TRAÇABILITAT'}

function LOG_Clear(): TLogTrace;
begin

  FillChar ( Result, SizeOf(Result), 0 );

end;


procedure LOG_Add (
  Conn: TADOConnection;
  CodigoUsuario: Integer;
  UUID: String;
  IP: String;
  Accion: String;
  Observaciones: String;
  Params: PLogTrace = nil
);
var
  sSQL: String;
begin

  sSQL :=
    'INSERT INTO FS_SGA_TraceLog ( ' +
    '  UUID, Ejercicio, CodigoUsuario, IP, Accion, Observaciones ';

  if Params<>nil then
  begin
    sSQL := sSQL + ',' +
      'MovOrigen, Matricula, IdPreparacion, IdRecepcion, IdDevolucion, IdDevolucionP, IdAprovisionamiento, IdInventario ';
  end;

  sSQL := sSQL +
    ') ' +
    'VALUES ( ' +
    '''' + SQL_Str(UUID) + ''', ' +
    IntToStr(YearOf(Now())) + ', ' +
    IntToStr(CodigoUsuario) + ', ' +
    '''' + SQL_Str(IP) + ''', ' +
    '''' + SQL_Str(Accion) + ''', ' +
    '''' + SQL_Str(Observaciones) + ''' ';

  if Params<>nil then
  begin
    sSQL := sSQL + ', ';

    if Params^.MovOrigen<>'' then
      sSQL := sSQL + '''' + SQL_GUID_ToStr(Params^.MovOrigen) + ''', '
    else
      sSQL := sSQL + 'NULL, ';

    if Params^.Matricula<>'' then
      sSQL := sSQL + '''' + SQL_Str(Params^.Matricula) + ''', '
    else
      sSQL := sSQL + 'NULL, ';

    sSQL := sSQL + IntToStr(Params^.IdPreparacion) + ', ';
    sSQL := sSQL + IntToStr(Params^.IdRecepcion) + ', ';
    sSQL := sSQL + IntToStr(Params^.IdDevolucion) + ', ';
    sSQL := sSQL + IntToStr(Params^.IdDevolucionP) + ', ';
    sSQL := sSQL + IntToStr(Params^.IdAprovisionamiento) + ', ';
    sSQL := sSQL + IntToStr(Params^.IdInventario) + ' ';

  end;

  sSQL := sSQL +
    ')';

  try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
  end;

end;

{$ENDREGION}


end.

