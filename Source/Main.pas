// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// │ FACTORYSTART LICENSE SERVER v1.0                                      │ \\
// │                                                                       │ \\
// ├───────────────────────────────────────────────────────────────────────┤ \\
// │                                                                       │ \\
// │ └ ┘ ┐ ┌ ├ ┤ ┬ ┴ ┼ │ ─                                                 │ \\
// │                                                                       │ \\
// ├───────────────────────────────────────────────────────────────────────┤ \\
// │ COPYRIGHT © 2019-2020 ARTECSOFT, S.L.                                 │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\

unit Main;


interface


{$REGION '--- IMPORTACIONS'}

uses
  System.WideStrUtils,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Types,
  System.Classes,
  System.StrUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.SvcMgr,
  Vcl.Dialogs,
  INIFiles,
  ESBDates,
  Vcl.ExtCtrls,
  System.JSON,
  Variants,
  Data.DB,
  System.Win.ComObj,
  Data.Win.ADODB,
  ActiveX,
  DateUtils,
  System.Math,
  Vcl.OleServer,
  Web.HTTPApp,
  IdURI,
  WinInet,
  Registry,
  clTcpServer,
  clTcpServerTls,
  clHttpHeader,
  clHttpServer,
  clHttpRequest,
  clServerGuard,
  Functions_LogV2, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdServerIOHandler, IdSSL, IdSSLOpenSSL, ppPrnabl, ppClass, ppCtrls,
  ppBarCod, ppBands, ppCache, ppDesignLayer, ppParameter, ppComm, ppRelatv,
  ppProd, ppReport, raCodMod, ppModule, ppDB, ppDBPipe, System.SyncObjs;


{$ENDREGION}


{$REGION '--- DEFINICIÓ DE TIPUS'}

type
  TFS_MainWebServiceSGA = class(TService)
    SQLConn: TADOConnection;
    tmrFinalitzar: TTimer;
    HttpServer: TclHttpServer;
    IdHTTP1: TIdHTTP;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    ppReport1: TppReport;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppBarCode1: TppBarCode;
    ppFooterBand1: TppFooterBand;
    raCodeModule1: TraCodeModule;
    raProgramInfo1: TraProgramInfo;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppParameterList1: TppParameterList;
    ppParameter1: TppParameter;
    ppParameter2: TppParameter;
    ppParameter3: TppParameter;
    tmrTimeout: TTimer;
    ppDBPipeline1: TppDBPipeline;
    DataSource1: TDataSource;
    procedure ServiceExecute(Sender: TService);
    procedure ServiceAfterInstall(Sender: TService);
    procedure tmrFinalitzarTimer(Sender: TObject);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure SslHttpServer1AfterAnswer(Sender, Client: TObject);
    procedure HttpServerAcceptConnection(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
    procedure HttpServerCloseConnection(Sender: TObject; AConnection: TclUserConnection);
    procedure HttpServerSendResponse(Sender: TObject; AConnection: TclHttpUserConnection; AStatusCode: Integer; const AStatusText: string;
      AHeader: TclHttpResponseHeader; ABody: TStream);
    procedure HttpServerStart(Sender: TObject);
    procedure HttpServerStop(Sender: TObject);
    procedure HttpServerReceiveRequest(Sender: TObject; AConnection: TclHttpUserConnection; const AMethod, AUri: string; AHeader: TclHttpRequestHeader;
      ABody: TStream);
    procedure SQLConnExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure tmrTimeoutTimer(Sender: TObject);
    procedure HttpServerReadConnection(Sender: TObject;
      AConnection: TclUserConnection; AData: TStream);
    procedure SQLConnDisconnect(Connection: TADOConnection;
      var EventStatus: TEventStatus);
  private

    FIsStop: Boolean;

    procedure StartServer;
    procedure StopServer;
    procedure TerminateThreads;
    procedure Iniciar();
    procedure Detener();

  public

    FTerminated: Boolean;

    function  GetServiceController: TServiceController; override;

  end;

  {$REGION 'THREADS'}

  // Tipo de procedimiento para las acciones del WebModule
  TWebModuleActionProc = procedure(
    Conn: TADOConnection;
    sParams, sRemoteAddr: String;
    var statusCode: Integer;
    var statusText: String;
    var Result: String
  );

  // Tipo de procedimiento con puerto (para validación de licencias/usuarios)
  TWebModuleActionProcWithPort = procedure(
    Conn: TADOConnection;
    sParams, sRemoteAddr: String;
    Port: Integer;
    var statusCode: Integer;
    var statusText: String;
    var Result: String
  );

  // Thread asíncrono para ejecutar acciones del WebModule
  TAsyncWebModuleThread = class(TThread)
  private
    FConnectionString: String;
    FParams: String;
    FRemoteAddr: String;
    FStatusCode: Integer;
    FStatusText: String;
    FResponse: String;
    FActionProc: TWebModuleActionProc;
    FActionProcWithPort: TWebModuleActionProcWithPort; // Nuevo campo para proc con port
    FPort: Integer; // Nuevo campo para el puerto
    FHttpServer: TclHttpServer;
    FConnection: TclHttpUserConnection;
    FContentType: String;
    FCharSet: String;
    FContentLanguage: String;
    FExtraFields: TStringList;
    FTaskId: String;
    FStartTime: TDateTime;
    FMaxExecutionSeconds: Integer;
    
    procedure SendHttpResponse;
  protected
    procedure Execute; override;
  public
    // Constructor estándar
    constructor Create(
      const AConnectionString: String;
      const AParams, ARemoteAddr: String;
      AActionProc: TWebModuleActionProc;
      AHttpServer: TclHttpServer;
      AConnection: TclHttpUserConnection;
      const AContentType, ACharSet, AContentLanguage: String;
      AExtraFields: TStringList
    ); overload;

    // Nuevo constructor para acciones que requieren puerto
    constructor Create(
      const AConnectionString: String;
      const AParams, ARemoteAddr: String;
      APort: Integer;
      AActionProc: TWebModuleActionProcWithPort;
      AHttpServer: TclHttpServer;
      AConnection: TclHttpUserConnection;
      const AContentType, ACharSet, AContentLanguage: String;
      AExtraFields: TStringList
    ); overload;
    destructor Destroy; override;
  end;

  {$ENDREGION}

{$ENDREGION}


{$REGION '--- VARIABLES GLOBALS'}

var
  FS_MainWebServiceSGA: TFS_MainWebServiceSGA;
  sIDCall: String;
  gaLogFile2: TLogFile;
  bCleanLog: Boolean;
  
  // Critical section para proteger llamadas HTTP desde threads
  gHttpResponseCS: TCriticalSection;

{$ENDREGION}


implementation


{$R *.dfm}


{$REGION '--- IMPORTACIONS'}

uses
  SGAWebModule,
  Globals,
  Functions,
  Functions_Updates,
  Functions_Process,
  Functions_DB,
  Functions_SGA,
  Functions_JSON,
  Functions_Network,
  Functions_SAGE,
  Functions_Registry,
  Functions_EncryptDecrypt;

{$ENDREGION}


{$REGION '--- FUNCIONS DEL SERVEI'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure ServiceController(CtrlCode: DWord); stdcall;
begin

  FS_MainWebServiceSGA.Controller(CtrlCode);

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
function TFS_MainWebServiceSGA.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;


procedure TFS_MainWebServiceSGA.HttpServerAcceptConnection(Sender: TObject; AConnection: TclUserConnection; var Handled: Boolean);
begin

  gaLogFile.Write ( 'Conexión aceptada. Host: ' + AConnection.PeerIP + '. Conexiones activas: ' + IntToStr(httpserver.ConnectionCount), CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );
  Inc(giNumSessions);

end;

procedure TFS_MainWebServiceSGA.HttpServerCloseConnection(Sender: TObject; AConnection: TclUserConnection);
begin

  Dec(giNumSessions);
  if not FIsStop then
  begin
    gaLogFile.Write ( 'Conexión cerrada. Host: ' + AConnection.PeerIP + '. Conexiones activas: ' + IntToStr(httpserver.ConnectionCount), CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );
  end;

end;

procedure TFS_MainWebServiceSGA.HttpServerReadConnection(Sender: TObject;
  AConnection: TclUserConnection; AData: TStream);
begin

  // Test

end;

procedure TFS_MainWebServiceSGA.HttpServerReceiveRequest(Sender: TObject; AConnection: TclHttpUserConnection; const AMethod, AUri: string;
  AHeader: TclHttpRequestHeader; ABody: TStream);
var
  sResponse: String;
  statusCode: Integer;
  statusText: string;
  sUri: String;
  sCommand, sParams: String;
  SL: TStringList;
  SLHeader: TStringList;
  sText: String;
  SS: TStringStream;
  aIdURI: TIDUri;
  cp: Integer;
  st: TSTringList;
  sURL: String;
  bAsyncRequest: Boolean;
begin
  bAsyncRequest := False;

  (Sender as TclHttpServer).BeginWork;
  if (AUri='/favicon.ico') then
  begin
    (Sender as TclHttpServer).EndWork;
    Exit;
  end;

  if AnsiUpperCase(AMethod)='POST' then
  begin
    sCommand := AnsiLowerCase ( AUri );
    ABody.Position := 0;
    st := TSTringList.Create;
    st.LoadFromStream(ABody,TEncoding.UTF8);
    sParams := st.Text;
    sParams := CanonicalizeUrl ( sParams, ICU_DECODE or ICU_NO_ENCODE );

    while (RightStr(sParams,1)=#13) or (RightStr(sParams,1)=#10) do
    begin
      Delete(sParams,Length(sParams),1);
    end;

    FreeAndNil(st);
  end else begin
    sUri := AUri; // AnsiLowerCase ( AUri );
    SL := TStringList.Create;
    SL.Delimiter := '?';
    SL.StrictDelimiter := TRUE;
    SL.DelimitedText := sUri;
    sCommand := SL[0];
    if SL.Count>1 then
      sParams := SL[1]
    else
      sParams := '';
    FreeAndNil(SL);
    sParams := CanonicalizeUrl ( sParams, ICU_DECODE or ICU_NO_ENCODE );
  end;

  sCommand := AnsiLowerCase ( sCommand );
  {aIdURI := TIdURI.Create(TIdURI.URLDecode(sParams));
  sParams := aIdUri.GetPathAndParams; // .Document;
  FreeAndNil(aIdURI); }

  sIDCall := LOG_GenerateRandomHash ( 12 );

  if sCommand<>'/' then
  begin
    gaLogFile.Write ( 'Request: ' + sCommand + '?' + sParams, CONST_LOGID_SGA, LOG_LEVEL_INFO );
  end;

  SLHeader := TStringList.Create;
  SLHeader.Add('Access-Control-Allow-Origin:*');
  SLHeader.Add('Access-Control-Allow-Methods: PUT,POST,DELETE');

  AConnection.ResponseHeader.ContentType := 'application/json; charset=ISO-8859-1';
  AConnection.ResponseHeader.CharSet := 'ISO-8859-1';
  AConnection.ResponseHeader.ContentLanguage := 'es-ES';
  AConnection.ResponseHeader.ExtraFields.Assign(SLHeader);
  AConnection.ResponseHeader.Update;

  FreeAndNil(SLHeader);

  sResponse := '{"Result":"OK","Error":"","Data":"SGA - Servidor web v0.1"}';
  statusCode := 200;
  statusText := 'OK';

  //sCommand := sCommand + '2';

  try

    {$REGION 'CRIDES ANTIGUES'}

    if (sCommand='/diagnosticsOLD') then
      WebModule1diagnosticsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/logoOLD') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1logoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/userimageOLD') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1userImageAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/artimageOLD') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1artImageAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/loadscansOLD') then
      WebModule1loadScansAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/savescansOLD') then
      WebModule1saveScansAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/savenumerosseriepreparacionOLD') then
      WebModule1saveNumerosSeriePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/reconnectdbOLD') then
      WebModule1reconnectDBAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/printercapabilitiesOLD') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1testPrinterAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/impresorasOLD') then
      WebModule1impresorasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listtemplatesOLD') then
      WebModule1listTemplatesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/restartserviceOLD') then
      WebModule1restartServiceAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkubicacionpaletOLD') then
      WebModule1checkUbicacionPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/imprimircajaexpedicionOLD') then
      WebModule1printCajaExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/moverpaletOLD') then
      WebModule1moverPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/paletsenubicacionOLD') then
      WebModule1paletsEnUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/empresasOLD') then
      WebModule1listCompaniesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/aprovisionamientosOLD') then
      WebModule1listAprovisionamientosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getaprovisionamientodetailOLD') then
      WebModule1getAprovisionamientoDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/refreshaprovisionamientodetailOLD') then
      WebModule1refreshAprovisionamientoDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getaprovisionamientosmovimientosOLD') then
      WebModule1getAprovisionamientoMovimientosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cerraraprovisionamientoOLD') then
      WebModule1cerrarAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/setbloqueoubicacionOLD') then
      WebModule1setBloqueoUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generatematriculaOLD') then
      WebModule1generateMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/changepaletpackagingOLD') then
      WebModule1changePaletPackagingAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listalmacenesOLD') then
      WebModule1listAlmacenesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/logoutOLD') then
      WebModule1logoutAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validateuserOLD') then
      WebModule1validateUserAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.Port, statusCode, statusText, sResponse )

    else if (sCommand='/validateuser2OLD') then
    begin
        TAsyncWebModuleThread.Create(
          SQLConn.ConnectionString,
          sParams,
          AConnection.PeerIP,
          AConnection.Port,
          @WebModule1validateUserAction,
          HttpServer,
          AConnection,
          AConnection.ResponseHeader.ContentType,
          AConnection.ResponseHeader.CharSet,
          AConnection.ResponseHeader.ContentLanguage,
          SLHeader
        );
        bAsyncRequest := True;
    end

    else if (sCommand='/readformpermsOLD') then
      WebModule1readFormPermsAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.Port, statusCode, statusText, sResponse )

    else if (sCommand='/userlistOLD') then
      WebModule1userListAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/freelicenseOLD') then
      WebModule1freeLicenseAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.PeerPort, statusCode, statusText, sResponse )

    else if (sCommand='/encodeurlOLD') then
      WebModule1encodeUrlAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.PeerPort, statusCode, statusText, sResponse )

    else if (sCommand='/checklicenseOLD') then
      WebModule1checkLicenseAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.PeerPort, statusCode, statusText, sResponse )

    else if (sCommand='/updateinventariodetailOLD') then
      WebModule1updateInventarioDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deleteinventariodetailOLD') then
      WebModule1deleteInventarioDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/closeinventarioOLD') then
      WebModule1closeInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validateinventoriodetailOLD') then
      WebModule1validateInventarioDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validarubicacioninventarioOLD') then
      WebModule1validarUbicacionInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/readparamOLD') then
      WebModule1readParamAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkubicacioninventarioOLD') then
      WebModule1checkUbicacionInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/proximaubicacionOLD') then
      WebModule1proximaUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/readparamsOLD') then
      WebModule1readParamsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/readbarcodeOLD') then
      WebModule1readBarcodeAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getdefaultlocationsOLD') then
      WebModule1getDefaultLocationsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listinformesOLD') then
      WebModule1listInformesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/startpreparacionOLD') then
      WebModule1startPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/stoppreparacionOLD') then
      WebModule1stopPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpreparacionesOLD') then
      WebModule1listPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpreparaciones2OLD') then
    begin
      // Versión asíncrona usando threads
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
        sParams,
        AConnection.PeerIP,
        @WebModule1listPreparacionesAction,
        HttpServer,
        AConnection,
        AConnection.ResponseHeader.ContentType,
        AConnection.ResponseHeader.CharSet,
        AConnection.ResponseHeader.ContentLanguage,
        SLHeader
      );
      bAsyncRequest := True; // Marcar petición como asíncrona
    end

    else if (sCommand='/getmetodorutaOLD') then
      WebModule1getMetodoRutaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/savemetodorutaOLD') then
      WebModule1saveMetodoRutaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cambiarunidadmedidaOLD') then
      WebModule1cambiarUnidadMedidaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepedidoslistOLD') then
      WebModule1updatePedidosListAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/clearexpedicionOLD') then
      WebModule1clearExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/recibirlineaOLD') then
      WebModule1recibirLineaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getinfopreparacionOLD') then
      WebModule1getInfoPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateobservacionespreparacionOLD') then
      WebModule1updateObservacionesPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/entradastockOLD') then
      WebModule1entradaStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/salidastockOLD') then
      WebModule1salidaStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/traspasostockOLD') then
      WebModule1traspasoStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/regularizacionOLD') then
      WebModule1regularizacionStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabecerapedidoventaOLD') then
      WebModule1cabeceraPedidoVentaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabecerapedidocompraOLD') then
      WebModule1cabeceraPedidoCompraAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesarticuloOLD') then
      WebModule1ubicacionesArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getpackinglistOLD') then
      WebModule1getPackingListAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/connectioninfoOLD') then
      WebModule1getConnectionInfoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getpackinglistexpedicionOLD') then
      WebModule1getPackingListExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/movimientosarticuloOLD') then
      WebModule1movimientosArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deleteexpediciondetalleOLD') then
      WebModule1deleteExpedicionDetalleAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/codigoarticuloubicacionOLD') then
      WebModule1codigoArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listzonasOLD') then
      WebModule1getZonasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listubicacionesOLD') then
      WebModule1getUbicacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosubicacionOLD') then
      WebModule1listArticulosUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listproveedoresOLD') then
      WebModule1listProveedoresAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getzonaspreparacionesOLD') then
      WebModule1getZonasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/gettransportistaspreparacionesOLD') then
      WebModule1getTransportistasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getcomisionistaspreparacionesOLD') then
      WebModule1getComisionistasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getrutaspreparacionesOLD') then
      WebModule1getRutasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpartidasOLD') then
      WebModule1listPartidasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listtallasOLD') then
      WebModule1listTallasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listcoloresOLD') then
      WebModule1listColoresAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listclientesOLD') then
      WebModule1listClientesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineaspedidocompraOLD') then
      WebModule1listLineasPedidoCompraAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineasalbarancompraOLD') then
      WebModule1listLineasAlbaranProveedorAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineaspedidoventaOLD') then
      WebModule1listLineasPedidoVentaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabeceraalbaranventaOLD') then
      WebModule1listCabeceraAlbaranClienteAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabeceraalbarancompraOLD') then
      WebModule1listCabeceraAlbaranCompraAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineasalbaranventaOLD') then
      WebModule1listLineasAlbaranVentaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatetraspasosselectedOLD') then
      WebModule1updateTraspasosSelectedAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/traspasarlistaOLD') then
      WebModule1traspasarListaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkemptytargetOLD') then
      WebModule1checkEmptyTargetAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosOLD') then
      WebModule1listArticulosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/findarticulosOLD') then
      WebModule1findArticulosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getnumerosserierecepcionOLD') then
      WebModule1getNumerosSerieRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getnumerosseriepreparacionOLD') then
      WebModule1getNumerosSeriePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listfamiliasOLD') then
      WebModule1listFamiliasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listsubfamiliasOLD') then
      WebModule1listSubfamiliasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpasillosOLD') then
      WebModule1getPasilloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listestanteriasOLD') then
      WebModule1listEstanteriasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listalturasOLD') then
      WebModule1listAlturasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listfondosOLD') then
      WebModule1listFondosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacionOLD') then
      WebModule1detallePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/preparacionubicacionesOLD') then
      WebModule1preparacionUbicacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listinventariosOLD') then
      WebModule1listInventariosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/testOLD') then
      CONFIG_SendVersions ( SQLConn )

    else if (sCommand='/updatecajaspaletsOLD') then
      WebModule1updateCajasPaletsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatereservapaletOLD') then
      WebModule1updateReservaPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkunidadespreparadasOLD') then
      WebModule1checkUnidadesPreparadas
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generatepackinglistautoOLD') then
      WebModule1generatePackingListAuto
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generatepackinglistasisOLD') then
      WebModule1generatePackingListAsis
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getarticulodetailsOLD') then
      WebModule1getArticuloDetailsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateunidadespreparacionOLD') then
      WebModule1updateUnidadesPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateunidadespreparaciontcOLD') then
      WebModule1updateUnidadesPreparacionTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deletepreparaciondetailOLD') then
      WebModule1deletePreparacionDetailTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listrecepcionesOLD') then
      WebModule1listRecepcionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallerecepcionOLD') then
      WebModule1detalleRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updaterecepcionOLD') then
      WebModule1updateRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/dashboardOLD') then
      WebModule1dashboardAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validateubicacionOLD') then
      WebModule1validateUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listinventarioubicacionesOLD') then
      WebModule1listInventarioUbicacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateinventarioubicacionOLD') then
      WebModule1updateInventarioUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listincidenciasOLD') then
      WebModule1listIncidenciasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listubicacionesfavoritasOLD') then
      WebModule1listUbicacionesFavoritasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesrecepcionOLD') then
      WebModule1ubicacionesRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesdevolucionOLD') then
      WebModule1ubicacionesDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesdevolucionprovOLD') then
      WebModule1ubicacionesDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirrecepcionOLD') then
      WebModule1servirRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listdevolucionesOLD') then
      WebModule1listDevolucionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listdevolucionesprovOLD') then
      WebModule1listDevolucionesProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalledevolucionOLD') then
      WebModule1detalleDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalledevolucionprovOLD') then
      WebModule1detalleDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpedicionOLD') then
      WebModule1detalleExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expediciondisponibleOLD') then
      WebModule1expedicionDisponibleAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/actualizarexpedicionOLD') then
      WebModule1actualizarExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getdetallepartidasOLD') then
      WebModule1getDetallePartidasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/actualizarexpedicionallOLD') then
      WebModule1actualizarExpedicionAllAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatedevolucionOLD') then
      WebModule1updateDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatedevolucionprovOLD') then
      WebModule1updateDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirdevolucionOLD') then
      WebModule1servirDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirdevolucionprovOLD') then
      WebModule1servirDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacionordenOLD') then
      WebModule1detallePreparacionOrdenAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deleterecepciondetailOLD') then
      WebModule1deleteRecepcionDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deletedevoluciondetailOLD') then
      WebModule1deleteDevolucionDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deletedevolucionprovdetailOLD') then
      WebModule1deleteDevolucionProvDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getreposicionescountOLD') then
      WebModule1getReposicionesCountAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getreposicionesalmacenOLD') then
      WebModule1getReposicionesAlmacenAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/articuloenreposicionOLD') then
      WebModule1articuloEnReposicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/preparacioncalcularindiceOLD') then
      WebModule1preparacionCalcularIndiceAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepaletcajaactualOLD') then
      WebModule1updatePaletCajaActualAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepaletcajapreparacionOLD') then
      WebModule1updatePaletCajaPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/findpaletmatriculaOLD') then
      WebModule1findPaletMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generarpackinglistautoOLD') then
      WebModule1generarPackingListAutoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedirtodoOLD') then
      WebModule1expedirTodoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getlastcajaidOLD') then
      WebModule1getLastCajaIdAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/borrarlineaexpedicionOLD') then
      WebModule1borrarLineaExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedirlineaOLD') then
      WebModule1expedirLineaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checknumeroserierecepcionOLD') then
      WebModule1checkNumeroSerieRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checknumeroseriepreparacionOLD') then
      WebModule1checkNumeroSeriePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/renumerarcajasOLD') then
      WebModule1renumerarCajasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getexpedicioncajaOLD') then
      WebModule1getexpedicioncajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedicionpartidasarticuloOLD') then
      WebModule1expedicionPartidasArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedicionpartidasarticulotcOLD') then
      WebModule1expedicionPartidasArticuloTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedicionpartidasarticulobryocantcOLD') then
      WebModule1expedicionPartidasArticuloBryocanTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpedicion2OLD') then
      WebModule1detalleExpedicion2Action
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/traspasoubicaciondestinoOLD') then
      WebModule1traspasoUbicacionDestinoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getmaxusedpartidaOLD') then
      WebModule1getMaxUsedPartidaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/articuloscajaOLD') then
      WebModule1articulosCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/actualizarrutaOLD') then
      WebModule1actualizarRutaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosrecepcionOLD') then
      WebModule1listArticulosRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosdevolucionOLD') then
      WebModule1listArticulosDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosdevolucionprovOLD') then
      WebModule1listArticulosDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/desgloserecepcionOLD') then
      WebModule1desgloseRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/desglosedevolucionOLD') then
      WebModule1desgloseDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/desglosedevolucionprovOLD') then
      WebModule1desgloseDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatecabecerarecepcionOLD') then
      WebModule1updateCabeceraRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatecabeceradevolucionOLD') then
      WebModule1updateCabeceraDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatecabeceradevolucionprovOLD') then
      WebModule1updateCabeceraDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacionpedidoOLD') then
      WebModule1detallePreparacionPedidoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacionpedidonewOLD') then
      WebModule1detallePreparacionPedidoNewAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpackagingsOLD') then
      WebModule1listPackagingsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/imprimirmatriculaOLD') then
      WebModule1imprimirMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpackagingspreparacionOLD') then
      WebModule1listPackagingsPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingmatriculaOLD') then
      WebModule1updatePackagingMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingmatriculacajaOLD') then
      WebModule1updatePackagingMatriculaCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingpaletOLD') then
      WebModule1updatePackagingPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingcajaOLD') then
      WebModule1updatePackagingCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpediciontcOLD') then
      WebModule1detalleExpedicionTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpediciontcpartidasOLD') then
      WebModule1detalleExpedicionTCPartidasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/recuperarpackinglistscansOLD') then
      WebModule1detallerecuperarPackingListScansAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpediciontcagrupacionesOLD') then
      WebModule1detalleExpedicionTCAgrupacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepackinglistarticuloOLD') then
      WebModule1detallePackingListArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedirpedidoOLD') then
      WebModule1expedirPedidoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/contenidoubicacioninventarioOLD') then
      WebModule1contenidoUbicacionInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpreparacionordenadaOLD') then
      WebModule1listPreparacionOrdenadaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/recuperarinfopaletOLD') then
      WebModule1recuperarInfoPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/findubicacionmatriculaOLD') then
      WebModule1findUbicacionMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/clientesOLD') then
      WebModule1clientesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cadenasOLD') then
      WebModule1cadenasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    {else if (sCommand='/preparacionesOLD') then
      WebModule1preparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )}

    else if (sCommand='/recuperarmotivosbloqueoOLD') then
      WebModule1recuperarMotivosBloqueoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cambiarmotivobloqueoOLD') then
      WebModule1cambiarMotivoBloqueoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cambiartiporeservaOLD') then
      WebModule1cambiarTipoReservaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateestadopaletOLD') then
      WebModule1updateEstadoPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generarinformeOLD') then
      WebModule1generarInformeAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirprepOLD') then
      WebModule1prepareServirPrepAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirpreparacionOLD') then
      WebModule1servirPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirrecOLD') then
      WebModule1prepareServirRecAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirdevOLD') then
      WebModule1prepareServirDevAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirdevprovOLD') then
      WebModule1prepareServirDevProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listaprovisionamientosOLD') then
      WebModule1listAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleaprovisionamientoOLD') then
      WebModule1detalleAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/finishtransitosaprovisionamientoOLD') then
      WebModule1finishTransitosAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/restorepaletmatriculacajaOLD') then
      WebModule1restorePaletMatriculaCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/refreshrutaaprovisionamientoOLD') then
      WebModule1refreshRutaAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/moveaprovisionamientotoendOLD') then
      WebModule1moveAprovisionamientoToEndAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/doaprovisionamientoOLD') then
      WebModule1doAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/refreshstockarticuloOLD') then
      WebModule1refreshStockArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getlicenseinfoOLD') then
      WebModule1getLicenseInfoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    {else if (sCommand='/updateaprovisionamientoOLD') then
      WebModule1updateAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )}

    else if (sCommand='/getagrupacionesOLD') then
      WebModule1getAgrupacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    {$ENDREGION}

    // ═══════════════════════════════════════════════════════════════════════
    // ASYNC ENDPOINT VERSIONS (High Priority)
    // Pattern: Original endpoint + '2' suffix = Async version
    // ═══════════════════════════════════════════════════════════════════════

    else if (sCommand='/diagnostics') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1diagnosticsAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/loadscans') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1loadScansAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/savescans') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1saveScansAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/savenumerosseriepreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1saveNumerosSeriePreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/reconnectdb') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1reconnectDBAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/impresoras') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1impresorasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listtemplates') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listTemplatesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/restartservice') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1restartServiceAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/checkubicacionpalet') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1checkUbicacionPaletAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/imprimircajaexpedicion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1printCajaExpedicionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/moverpalet') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1moverPaletAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/paletsenubicacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1paletsEnUbicacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/empresas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listCompaniesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/aprovisionamientos') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listAprovisionamientosAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getaprovisionamientodetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getAprovisionamientoDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/refreshaprovisionamientodetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1refreshAprovisionamientoDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getaprovisionamientosmovimientos') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getAprovisionamientoMovimientosAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end


    else if (sCommand='/cerraraprovisionamiento') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1cerrarAprovisionamientoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/setbloqueoubicacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1setBloqueoUbicacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/generatematricula') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1generateMatriculaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/changepaletpackaging') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1changePaletPackagingAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listalmacenes') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listAlmacenesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/logout') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1logoutAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/validateuser') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      AConnection.Port,
      @WebModule1validateUserAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/readformperms') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      AConnection.Port,
      @WebModule1readFormPermsAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/userlist') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1userListAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/freelicense') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      AConnection.PeerPort,
      @WebModule1freeLicenseAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/encodeurl') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      AConnection.PeerPort,
      @WebModule1encodeUrlAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/checklicense') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      AConnection.PeerPort,
      @WebModule1checkLicenseAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updateinventariodetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateInventarioDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/deleteinventariodetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1deleteInventarioDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/closeinventario') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1closeInventarioAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/validateinventoriodetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1validateInventarioDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/validarubicacioninventario') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1validarUbicacionInventarioAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/readparam') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1readParamAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/checkubicacioninventario') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1checkUbicacionInventarioAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/proximaubicacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1proximaUbicacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/readparams') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1readParamsAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/readbarcode') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1readBarcodeAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getdefaultlocations') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getDefaultLocationsAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listinformes') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listInformesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/startpreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1startPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/stoppreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1stopPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listpreparaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listPreparacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getmetodoruta') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getMetodoRutaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/savemetodoruta') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1saveMetodoRutaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cambiarunidadmedida') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1cambiarUnidadMedidaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatepedidoslist') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updatePedidosListAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/clearexpedicion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1clearExpedicionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/recibirlinea') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1recibirLineaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getinfopreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getInfoPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updateobservacionespreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateObservacionesPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/entradastock') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1entradaStockAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/salidastock') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1salidaStockAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/traspasostock') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1traspasoStockAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/regularizacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1regularizacionStockAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cabecerapedidoventa') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1cabeceraPedidoVentaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cabecerapedidocompra') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1cabeceraPedidoCompraAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/ubicacionesarticulo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1ubicacionesArticuloAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getpackinglist') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getPackingListAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/connectioninfo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getConnectionInfoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getpackinglistexpedicion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getPackingListExpedicionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/movimientosarticulo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1movimientosArticuloAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/deleteexpediciondetalle') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1deleteExpedicionDetalleAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/codigoarticuloubicacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1codigoArticuloAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listzonas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getZonasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listubicaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getUbicacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listarticulosubicacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listArticulosUbicacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listproveedores') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listProveedoresAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getzonaspreparaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getZonasPreparacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/gettransportistaspreparaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getTransportistasPreparacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getcomisionistaspreparaciones') then
     begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getComisionistasPreparacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getrutaspreparaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getRutasPreparacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listpartidas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listPartidasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listtallas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listTallasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listcolores') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listColoresAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listclientes') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listClientesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/lineaspedidocompra') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listLineasPedidoCompraAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/lineasalbarancompra') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listLineasAlbaranProveedorAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/lineaspedidoventa') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listLineasPedidoVentaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cabeceraalbaranventa') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listCabeceraAlbaranClienteAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cabeceraalbarancompra') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listCabeceraAlbaranCompraAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/lineasalbaranventa') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listLineasAlbaranVentaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatetraspasosselected') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateTraspasosSelectedAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/traspasarlista') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1traspasarListaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/checkemptytarget') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1checkEmptyTargetAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listarticulos') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listArticulosAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/findarticulos') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1findArticulosAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getnumerosserierecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getNumerosSerieRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getnumerosseriepreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getNumerosSeriePreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listfamilias') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listFamiliasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listsubfamilias') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listSubfamiliasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listpasillos') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getPasilloAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listestanterias') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listEstanteriasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listalturas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listAlturasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listfondos') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listFondosAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detallepreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detallePreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/preparacionubicaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1preparacionUbicacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listinventarios') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listInventariosAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/test') then
    begin
        CONFIG_SendVersions ( SQLConn )
    end

    else if (sCommand='/updatecajaspalets') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateCajasPaletsAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatereservapalet') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateReservaPaletAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/checkunidadespreparadas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1checkUnidadesPreparadas,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/generatepackinglistauto') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1generatePackingListAuto,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/generatepackinglistasis') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1generatePackingListAsis,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getarticulodetails') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getArticuloDetailsAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updateunidadespreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateUnidadesPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updateunidadespreparaciontc') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateUnidadesPreparacionTCAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/deletepreparaciondetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1deletePreparacionDetailTCAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listrecepciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listRecepcionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detallerecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updaterecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/dashboard') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1dashboardAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/validateubicacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1validateUbicacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listinventarioubicaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listInventarioUbicacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updateinventarioubicacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateInventarioUbicacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listincidencias') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listIncidenciasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listubicacionesfavoritas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listUbicacionesFavoritasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/ubicacionesrecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1ubicacionesRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/ubicacionesdevolucion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1ubicacionesDevolucionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/ubicacionesdevolucionprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1ubicacionesDevolucionProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/servirrecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1servirRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listdevoluciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listDevolucionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listdevolucionesprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listDevolucionesProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalledevolucion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleDevolucionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalledevolucionprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleDevolucionProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalleexpedicion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleExpedicionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/expediciondisponible') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1expedicionDisponibleAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/actualizarexpedicion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1actualizarExpedicionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getdetallepartidas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getDetallePartidasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/actualizarexpedicionall') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1actualizarExpedicionAllAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatedevolucion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateDevolucionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatedevolucionprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateDevolucionProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/servirdevolucion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1servirDevolucionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/servirdevolucionprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1servirDevolucionProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detallepreparacionorden') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detallePreparacionOrdenAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/deleterecepciondetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1deleteRecepcionDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/deletedevoluciondetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1deleteDevolucionDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/deletedevolucionprovdetail') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1deleteDevolucionProvDetailAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getreposicionescount') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getReposicionesCountAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getreposicionesalmacen') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getReposicionesAlmacenAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/articuloenreposicion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1articuloEnReposicionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/preparacioncalcularindice') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1preparacionCalcularIndiceAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatepaletcajaactual') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updatePaletCajaActualAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatepaletcajapreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updatePaletCajaPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/findpaletmatricula') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1findPaletMatriculaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/generarpackinglistauto') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1generarPackingListAutoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/expedirtodo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1expedirTodoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getlastcajaid') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getLastCajaIdAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/borrarlineaexpedicion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1borrarLineaExpedicionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/expedirlinea') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1expedirLineaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/checknumeroserierecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1checkNumeroSerieRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/checknumeroseriepreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1checkNumeroSeriePreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/renumerarcajas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1renumerarCajasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getexpedicioncaja') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getexpedicioncajaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/expedicionpartidasarticulo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1expedicionPartidasArticuloAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/expedicionpartidasarticulotc') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1expedicionPartidasArticuloTCAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/expedicionpartidasarticulobryocantc') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1expedicionPartidasArticuloBryocanTCAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalleexpedicion2') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleExpedicion2Action,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/traspasoubicaciondestino') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1traspasoUbicacionDestinoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getmaxusedpartida') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getMaxUsedPartidaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/articuloscaja') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1articulosCajaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/actualizarruta') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1actualizarRutaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listarticulosrecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listArticulosRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listarticulosdevolucion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listArticulosDevolucionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listarticulosdevolucionprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listArticulosDevolucionProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/desgloserecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1desgloseRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/desglosedevolucion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1desgloseDevolucionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/desglosedevolucionprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1desgloseDevolucionProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatecabecerarecepcion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateCabeceraRecepcionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatecabeceradevolucion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateCabeceraDevolucionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatecabeceradevolucionprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateCabeceraDevolucionProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detallepreparacionpedido') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detallePreparacionPedidoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detallepreparacionpedidonew') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detallePreparacionPedidoNewAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listpackagings') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listPackagingsAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/imprimirmatricula') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1imprimirMatriculaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listpackagingspreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listPackagingsPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatepackagingmatricula') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updatePackagingMatriculaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatepackagingmatriculacaja') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updatePackagingMatriculaCajaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatepackagingpalet') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updatePackagingPaletAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updatepackagingcaja') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updatePackagingCajaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalleexpediciontc') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleExpedicionTCAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalleexpediciontcpartidas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleExpedicionTCPartidasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/recuperarpackinglistscans') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detallerecuperarPackingListScansAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalleexpediciontcagrupaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleExpedicionTCAgrupacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detallepackinglistarticulo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detallePackingListArticuloAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/expedirpedido') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1expedirPedidoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/contenidoubicacioninventario') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1contenidoUbicacionInventarioAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listpreparacionordenada') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listPreparacionOrdenadaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/recuperarinfopalet') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1recuperarInfoPaletAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/findubicacionmatricula') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1findUbicacionMatriculaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/clientes') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1clientesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cadenas') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1cadenasAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    {else if (sCommand='/preparaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1preparacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end}

    else if (sCommand='/recuperarmotivosbloqueo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1recuperarMotivosBloqueoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cambiarmotivobloqueo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1cambiarMotivoBloqueoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/cambiartiporeserva') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1cambiarTipoReservaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/updateestadopalet') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateEstadoPaletAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/generarinforme') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1generarInformeAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/prepareservirprep') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1prepareServirPrepAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/servirpreparacion') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1servirPreparacionAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/prepareservirrec') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1prepareServirRecAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/prepareservirdev') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1prepareServirDevAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/prepareservirdevprov') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1prepareServirDevProvAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/listaprovisionamientos') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1listAprovisionamientoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/detalleaprovisionamiento') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1detalleAprovisionamientoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
	  end

    else if (sCommand='/finishtransitosaprovisionamiento') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1finishTransitosAprovisionamientoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/restorepaletmatriculacaja') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1restorePaletMatriculaCajaAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/refreshrutaaprovisionamiento') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1refreshRutaAprovisionamientoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/moveaprovisionamientotoend') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1moveAprovisionamientoToEndAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/doaprovisionamiento') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1doAprovisionamientoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/refreshstockarticulo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1refreshStockArticuloAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/getlicenseinfo') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getLicenseInfoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    {else if (sCommand='/updateaprovisionamiento') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1updateAprovisionamientoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end}

    else if (sCommand='/getagrupaciones') then
    begin
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1getAgrupacionesAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/printercapabilities') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1testPrinterAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    else if (sCommand='/logo') then
    begin
      AConnection.ResponseHeader.ContentType := '';
        TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1logoAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

      else if (sCommand='/userimage') then
    begin
      AConnection.ResponseHeader.ContentType := '';
        TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1userImageAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

      else if (sCommand='/artimage') then
    begin
      AConnection.ResponseHeader.ContentType := '';
        TAsyncWebModuleThread.Create(
        SQLConn.ConnectionString,
      sParams,
      AConnection.PeerIP,
      @WebModule1artImageAction,
      HttpServer,
      AConnection,
      AConnection.ResponseHeader.ContentType,
      AConnection.ResponseHeader.CharSet,
      AConnection.ResponseHeader.ContentLanguage,
      SLHeader
      );
      bAsyncRequest := True;
    end

    // ═══════════════════════════════════════════════════════════════════════
    // END OF ASYNC ENDPOINTS (High Priority)
    // To add more: Use template in walkthrough.md or run PowerShell script
    // ═══════════════════════════════════════════════════════════════════════

  except

    on E:Exception do
    begin
      sResponse := '{"Request":"' + JSON_StrWeb(sParams) + '","Result":"ERROR","Message":"' + JSON_StrWeb(E.Message) + '. Reiniciamos servicio.","Data":[]}';
      gbFinalitzar := TRUE;
    end;

  end;

  if Pos ( 'Error en la conexión', sResponse ) > 0 then
  begin
    gbFinalitzar := TRUE;
  end;

  (*
  if Copy(sResponse,1,1)='{' then
  begin
    Delete(sResponse,1,1);
    sResponse :=
      '{' +
      '"ID":"' + JSON_Str(gsCustomerCode) + '",' +
      sResponse;
  end;
  *)

  // Las peticiones asíncronas envían su propia respuesta desde el thread
  // IMPORTANTE: Llamamos a EndWork INMEDIATAMENTE para liberar el servidor y permitir nuevas conexiones
  // El thread tiene su propia referencia a la conexión para enviar datos
  if bAsyncRequest then
  begin
    (Sender as TclHttpServer).EndWork;
  end
  else
  begin
    try
      (Sender as TclHttpServer).SendResponse(AConnection, statusCode, statusText, sResponse);
    finally
      (Sender as TclHttpServer).EndWork;
    end;
  end;

end;

procedure TFS_MainWebServiceSGA.HttpServerSendResponse(Sender: TObject; AConnection: TclHttpUserConnection; AStatusCode: Integer; const AStatusText: string;
  AHeader: TclHttpResponseHeader; ABody: TStream);
var
  SLHeader: TStringList;
begin

  {SLHeader := TStringList.Create;
  SLHeader.AddPair('Access-Control-Allow-Origin','*');

  AHeader.ExtraFields.Assign(SLHeader);

  FreeAndNil(SLHeader);
  }


  //gaLogFile.Write ( 'Response: ' + IntToStr(AStatusCode) + ' ' + AStatusText + ' Length: ' + IntToStr(ABody.Size), CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );

end;

procedure TFS_MainWebServiceSGA.HttpServerStart(Sender: TObject);
begin

  gaLogFile.Write ( 'Arrancamos Servidor HTTP', CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );

end;

procedure TFS_MainWebServiceSGA.HttpServerStop(Sender: TObject);
begin

  gaLogFile.Write ( 'Detenemos Servidor HTTP', CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ CANVIAR LA DESCRIPCIÓ DEL SERVEI                                      │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin

  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, false) then
    begin
      Reg.WriteString('Description', 'Webservice para SGA Mobile');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;

end;

procedure TFS_MainWebServiceSGA.ServiceBeforeInstall(Sender: TService);
var
  INI: TINIFile;
  sName: String;
  sCustomer: String;
begin

  gsPath := ExtractFileDir(ParamStr(0));

  sCustomer := REGISTRY_HKLM_Read ( 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'FS_CUSTOMER' );
  if sCustomer<>'' then sCustomer := '.' + sCustomer;

  INI := TINIFile.Create( gsPath + '\FS_LicenseServer.ini' );
  gbMultiInstance := INI.ReadBool ( 'GENERAL', 'MultiInstance', FALSE );
  if not gbMultiInstance then sCustomer := '';
  sName := INI.ReadString('General', 'ServiceName','');
  INI.Free;

  if sName<>'' then begin
    Name := 'FS_MainWebServiceSGA_' + sName;
    DisplayName := 'FactoryStart - WebService de SGA (' + sName + ')';
  end;

end;

procedure TFS_MainWebServiceSGA.ServiceBeforeUninstall(Sender: TService);
var
  INI: TINIFile;
  sName: String;
  sCustomer: String;
begin

  gsPath := ExtractFileDir(ParamStr(0));

  sCustomer := REGISTRY_HKLM_Read ( 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'FS_CUSTOMER' );
  if sCustomer<>'' then sCustomer := '.' + sCustomer;

  INI := TINIFile.Create( gsPath + '\FS_LicenseServer.ini' );
  gbMultiInstance := INI.ReadBool ( 'GENERAL', 'MultiInstance', FALSE );
  if not gbMultiInstance then sCustomer := '';
  sName := INI.ReadString('General','ServiceName','');
  INI.Free;

  if sName<>'' then begin
    Name := 'FS_MainWebServiceSGA_' + sName;
    DisplayName := 'FactoryStart - WebService de SGA (' + sName + ')';
  end;

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.ServiceCreate(Sender: TObject);
var
  INI: TINIFile;
  sName: String;
  sCustomer: String;
begin

  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
  FormatSettings.DateSeparator   := '/';

  gsPath := ExtractFileDir(ParamStr(0));

  sCustomer := REGISTRY_HKLM_Read ( 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'FS_CUSTOMER' );
  if sCustomer<>'' then sCustomer := '.' + sCustomer;

  INI := TINIFile.Create( gsPath + '\FS_LicenseServer.ini' );
  gbMultiInstance := INI.ReadBool ( 'GENERAL', 'MultiInstance', FALSE );
  if not gbMultiInstance then sCustomer := '';
  sName := INI.ReadString('General', 'ServiceName','');
  INI.Free;

  if sName<>'' then begin
    Name := 'FS_MainWebServiceSGA_' + sName;
    DisplayName := 'FactoryStart - WebService de SGA (' + sName + ')';
  end;

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ INICI DEL WEBSERVER DEL SGA                                           │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.StartServer;
begin

  if not gbSGAWS_Active then
    Exit;

  gaLogFile.Write ( 'Iniciamos el webservice de SGA', CONST_LOGID_WEBSERVER );

  {------------------------- CLEVER -------------------------}
  HttpServer.Port := giSGAWS_Port;

  try
    giNumSessions := 0;
    HttpServer.Start();
    gaLogFile.Write ( 'Webservice de SGA iniciado correctamente en el puerto ' + IntToStr(giSGAWS_Port), CONST_LOGID_WEBSERVER );
  except
    on E:Exception do begin
      gaLogFile.Write_DBException ( E, '', CONST_LOGID_WEBSERVER, LOG_LEVEL_EXCEPTION );
      gbSGAWS_Active := FALSE;
    end;
  end;

  {---------------------- END CLEVER ------------------------}

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ PARADA DEL WEBSERVICE DEL SGA                                         │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.StopServer;
begin

  if not gbSGAWS_Active then
    Exit;

  gaLogFile.Write ( 'Detenemos el webservice de SGA', CONST_LOGID_WEBSERVER );

  HttpServer.Stop();
  giNumSessions := 0;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ BUCLE PRINCIPAL DEL SERVEI                                            │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.ServiceExecute(Sender: TService);
var
  wsRes: WideString;
  Res: Variant;
  wsProvider: WideString;
  YY, MM, DD, HH, NN, SS, MS: WORD;
  HH2, NN2, SS2, MS2: WORD;
  sSQL: String;
  i, iSeconds: Integer;
  dNextRestart: TDateTime;
  INI: TINIFile;
  sCustomer: String;
  bServerStarted: Boolean;
begin

  if ServiceThread=nil then
    Exit;

  CoInitFlags := COINIT_MULTITHREADED;
  CoInitialize(nil);

  SetExceptionMask(exAllArithmeticExceptions );
  FIsStop := FALSE;
  bServerStarted := FALSE;

  gsPath := ExtractFileDir(ParamStr(0));

  sCustomer := REGISTRY_HKLM_Read ( 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'FS_CUSTOMER' );
  if sCustomer<>'' then sCustomer := '.' + sCustomer;

  INI := TINIFile.Create( gsPath + '\FS_LicenseServer.ini' );
  gbMultiInstance := INI.ReadBool ( 'GENERAL', 'MultiInstance', FALSE );
  if not gbMultiInstance then sCustomer := '';
  aParamsConfig.WaitStart := INI.ReadInteger ( 'General', 'WaitStart', 0 );
  INI.Free;

  i := 0;

  (*
  aParamsConfig.WaitStart := 10;
  while (i<(aParamsConfig.WaitStart*10)) and (not Terminated) do begin
    Inc(i);
    ServiceThread.ProcessRequests(False);
    SleepEx(100, FALSE);
    if Terminated then
      break;
  end;
  *)

  {$I-}
    DeleteFile ( PWideChar(gsPath + '\CalcularRuta.tmp') );
    DeleteFile ( PWideChar(gsPath + '\GenerarPackingList.tmp') );
  {$I+}

  if (not FTerminated) and (not Terminated) then begin

    Iniciar();

    {$IFDEF FS_LICENSESERVER}
    CONFIG_Server_Alive();
    {$ENDIF}

    ServiceThread.Priority := tpLowest;

    if not SQL_Procedure_Exists ( SQLConn, 'FS_LICENSE_UPDATE') then
    begin

      gaLogFile.Write('ERROR: No existe el procedimiento FS_LICENSE_UPDATE', CONST_LOGID_BBDD, LOG_LEVEL_ERROR );

    end else begin

      sSQL :=
        'EXEC dbo.FS_LICENSE_UPDATE ' +
        '''' + gsCustomerCode + ''', ' +
        '''' + CONST_SERVIDOR + ''', ' +
        '''' + gsMACAddress + ''', ' +
        '''' + SQL_Str(gsPCName) + ''', ' +
        '''' + TVSFixedFileInfo.FileVersion + '''';

      try
        SQLConn.Execute(sSQL);
      except
        on E:Exception do
        begin
          gaLogFile.Write_DBException(E, sSQL, 'Error al actualizar licencias', CONST_LOGID_BBDD, LOG_LEVEL_EXCEPTION);
        end;
      end;

    end;

  end;

  iSeconds := 0;
  dNextRestart := 0;
  giNumSessions := 0;
  gdtLastLive := 0;

  gaLogFile.Write('Memoria ocupada = ' + IntToStr(WIN_MEMORY_Usage()), CONST_LOGID_WEBSERVER );

  while (not gbFinalitzar) and (not Terminated) do begin

    ServiceThread.ProcessRequests(False);
    Sleep(1000);

    if not bServerStarted then
    begin
      StartServer;
      bServerStarted := TRUE;

      {$ifndef DEBUG}
      gaLogFile.Write('Verificamos versiones', CONST_LOGID_GENERAL, LOG_LEVEL_INFO );

      try
        CONFIG_SendVersions ( SQLConn );
      except
        on E:Exception do
        begin
          gaLogFile.Write_DBException(E,'','Error de versiones', CONST_LOGID_GENERAL, LOG_LEVEL_EXCEPTION);
        end;
      end;

      gaLogFile.Write('Versiones verificadas', CONST_LOGID_GENERAL, LOG_LEVEL_INFO);
      {$endif}

    end;

    iSeconds := iSeconds + 1;
    if iSeconds >= 60 then try
      //gaLogFile.Write('Memoria ocupada = ' + IntToStr(WIN_MEMORY_Usage()) );
      iSeconds := 0;
      {$IFDEF FS_LICENSESERVER}
      CONFIG_Server_Alive();
      {$ENDIF}
    except
      on E:Exception do begin
        gaLogFile.Write_DBException ( E, '', 'Error actualizando bit LIVE', CONST_LOGID_WEBSERVER, LOG_LEVEL_EXCEPTION);
      end;
    end;

    // Reiniciem el servidor web cada hora per netejar-lo
    (*
    DecodeDateTime ( Now(), YY, MM, DD, HH, NN, SS, MS );
    if (Now()>dNextRestart) and (MM=0) and (not gbFinalitzar) then begin
      dNextRestart := Now()+1/24/60;
      try
        StopServer();
      except
      end;
      try
        StartServer();
      except
      end;
    end;
    *)

  end;

  gbFinalitzar := TRUE;
  StopServer();

  Detener();

  CoUninitialize();

end;



// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ ATURADA DEL SERVEI                                                    │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.ServiceStart(Sender: TService;
  var Started: Boolean);
begin

  if not Started then
  begin
    DoStart;
  end;

  Started := True;

end;

procedure TFS_MainWebServiceSGA.ServiceStop(Sender: TService;
  var Stopped: Boolean);
begin

  gbFinalitzar := TRUE;
  TerminateThreads;
  ServiceThread.Terminate;

end;


procedure TFS_MainWebServiceSGA.SQLConnDisconnect(Connection: TADOConnection;
  var EventStatus: TEventStatus);
begin

  if not gbFinalitzar then
  begin

  end;

end;

procedure TFS_MainWebServiceSGA.SQLConnExecuteComplete(
  Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin

  if bCleanLog then
  begin
    gaLogFile2.Write(command.CommandText);
  end;

  if gaLogFile.MinLevel = LOG_LEVEL_TRACE_ALL then
  begin
    gaLogFile.Write ( Command.CommandText, CONST_LOGID_BBDD, LOG_LEVEL_TRACE_ALL );
  end;

  if (Error.Number<>0) and (not gbCalculatingRoute) then
  begin
    gaLogFile.Write(Error.Description + ' (' + Command.CommandText + ')', CONST_LOGID_BBDD, LOG_LEVEL_ERROR );
    gbFinalitzar := TRUE;
  end;

end;

procedure TFS_MainWebServiceSGA.SslHttpServer1AfterAnswer(Sender, Client: TObject);
begin

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.TerminateThreads;
begin
  (*if TDSSessionManager.Instance <> nil then
    TDSSessionManager.Instance.TerminateAllSessions;*)
end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ ARRANC DEL SERVEI                                                     │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.Iniciar();
var
  wsRes: WideString;
  Res: Variant;
  wsProvider: WideString;
  INIFile: TINIFile;
  iMinLevel: Integer;
  iPurgeDays: Integer;
  bActive: Boolean;
  sCustomer: String;
begin

  SAGE := NULL;
  gsPath := ExtractFileDir(ParamStr(0));

  sCustomer := REGISTRY_HKLM_Read ( 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'FS_CUSTOMER' );
  if sCustomer<>'' then sCustomer := '.' + sCustomer;

  INIFile    := TINIFile.Create( gsPath + '\FS_LicenseServer.ini' );
  gbMultiInstance := INIFile.ReadBool ( 'GENERAL', 'MultiInstance', FALSE );
  if not gbMultiInstance then sCustomer := '';
  bActive    := INIFile.ReadBool ( 'SGA' + sCustomer, 'LogActive', TRUE );
  iMinLevel  := LOG_LevelFromName ( INIFile.ReadString ( 'SGA' + sCustomer, 'MinLogLevel', 'ERRO' ) );
  iPurgeDays := INIFile.ReadInteger ( 'SGA' + sCustomer, 'PurgeDays', 0 );
  bCleanLog  := INIFile.ReadBool ( 'SGA' + sCustomer, 'CleanLog', False );
  INIFile.Free;

  if bCleanLog then
  begin
    gaLogFile2                := TLogFile.Create;
    gaLogFile2.Enabled        := TRUE;
    gaLogFile2.ShowLevel      := FALSE;
    gaLogFile2.MinLevel       := 0;
    gaLogFile2.PurgeDays      := iPurgeDays;
    gaLogFile2.DefaultSection := CONST_LOGID_WEBSERVER;
    gaLogFile2.CleanLog       := TRUE;
    gaLogFile2.Open ( gsPath, 'FS_CleanWebServiceSGA' );
  end;

  gaLogFile                := TLogFile.Create;
  gaLogFile.Enabled        := bActive;
  gaLogFile.ShowLevel      := TRUE;
  gaLogFile.MinLevel       := iMinLevel;
  gaLogFile.PurgeDays      := iPurgeDays;
  gaLogFile.DefaultSection := CONST_LOGID_WEBSERVER;

  gaLogFile.Filter_INIAdd ( gsPath + '\FS_LicenseServer.ini', 'SGA.LOGFILTERS' + sCustomer );
  gaLogFile.Open ( gsPath, 'FS_WebServiceSGA' );

  gaLogFile.NewID();
  gaLogFile.Write ( 'Inicio del servicio', CONST_LOGID_WEBSERVER );
  gaLogFile.Write ( 'Creación del archivo de registro ' + gaLogFile.FileName, CONST_LOGID_WEBSERVER );

  CONFIG_Init();

  try
    TVSFixedFileInfo := CONFIG_GetVersion(ParamStr(0));
  except
    on E:Exception do begin
      gaLogFile.Write ( 'No hay información de versión: ' + E.Message, CONST_LOGID_WEBSERVER );
    end;
  end;

  gsMACAddress     := NETWORK_LocalMAC();
  gsPCName         := NETWORK_PCName();

  gaLogFile.Write ( 'Lectura de configuración', CONST_LOGID_WEBSERVER );
  if not CONFIG_Read() then begin
    gaLogFile.Write ( 'ERROR: No se puede leer el archivo de configuración', CONST_LOGID_WEBSERVER );
    gbFinalitzar := TRUE;
  end;

  SQLConn.ConnectionString :=
    'Provider=' + gsProv + ';' +
    'Persist Security Info=True;' +
    'User ID=' + gsUser + ';' +
    'Initial Catalog=' + gsBBDD + ';' +
    'Data Source=' + gsHost + ';' +
    //'MARS Connection=True;' +
    'Password=' + LICENSE_TwoFish_DEC ( gsPass );

  gaLogFile.Write ( 'Conexión a la base de datos ' + gsBBDD, CONST_LOGID_BBDD   );
  try
    SQLConn.Open;
  except
    on E:Exception do begin
      gaLogFile.Write_DBException ( E, SQLConn.ConnectionString, 'ERROR: No se puede connectar con la base de datos', CONST_LOGID_BBDD, LOG_LEVEL_EXCEPTION );
      gbFinalitzar := TRUE;
      Exit;
    end;
  end;

  gaLogFile.Write ( 'Creación objeto JSON', CONST_LOGID_WEBSERVER );
  //JSonObject := TJSonObject.Create;

  gaLogFile.Write ( 'Leer configuración general', CONST_LOGID_WEBSERVER );
  if not CONFIG_ReadParams(SQLConn) then begin
    gaLogFile.Write ( 'ERROR: No se puede leer la configuración general', CONST_LOGID_WEBSERVER );
    gbFinalitzar := TRUE;
  end;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ ATURADA DEL SERVEI                                                    │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TFS_MainWebServiceSGA.Detener();
begin

  try
    gaLogFile.NewID();

    gaLogFile.Write ( 'Eliminar objeto JSON', CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );

    gaLogFile.Write ( 'Cerrar conexión con BBDD', CONST_LOGID_BBDD, LOG_LEVEL_INFO );
    SQLConn.Close;

    gaLogFile.Write ( 'Guardar configuración', CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );
    //CONFIG_DeInit();

  except
    on E:Exception do begin
      gaLogFile.Write_DBException ( E, '', 'TFS_MainWebServiceSGA.Detener()', CONST_LOGID_WEBSERVER, LOG_LEVEL_EXCEPTION );
    end;
  end;

  gaLogFile.Write ( 'Cerrar archivo de registro', CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO );
  gaLogFile.Close();
  FreeAndNil(gaLogFile);

  if bCleanLog then
  begin
    gaLogFile2.Close();
    FreeAndNil(gaLogFile2);
  end;

end;

{$ENDREGION}


{$REGION '--- ALTRES FUNCIONS'}

  {$REGION '--- REINICIAR SERVEI'}

  // ┌───────────────────────────────────────────────────────────────────────┐ \\
  // │ REINICIAR EL SERVEI A UNA HORA CONCRETA SEGONS CONFIGURACIÓ           │ \\
  // └───────────────────────────────────────────────────────────────────────┘ \\
  procedure TFS_MainWebServiceSGA.tmrFinalitzarTimer(Sender: TObject);
  begin

    tmrFinalitzar.Enabled := FALSE;

    gaLogFile.NewID();
    gaLogFile.Write ( 'Reinici automàtic del servei' );

    gbFinalitzar := TRUE;

  end;

  procedure TFS_MainWebServiceSGA.tmrTimeoutTimer(Sender: TObject);
  var
    id: Cardinal;
  begin

    gaLogFile.Write('Error de timeout de impresión');
    tmrTimeOut.Enabled := FALSE;

    id := WIN_PROCESS_IDFromName ( gsPath, 'FS_WebServiceSGA.exe' );
    gaLogFile.Write(gsPath + ' Id=' + IntToStr(id), CONST_LOGID_GENERAL);

    WIN_PROCESS_Kill ( id );

    FTerminated := TRUE;
    ServiceThread.Terminate;

  end;

{$ENDREGION}


{$ENDREGION}


{$REGION '--- FUNCIONS DE JSON'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
(*
function TFS_MainWebServiceSGA._Parse_JSonValue ( JSONString: String ): TJSonValue;
Begin

   if Trim(JSONString)='' then begin
     Result := nil;
     Exit;
   end;

   try
     JsonValue := JSonObject.ParseJSONValue ( JSONString );
   except
     gaLogFile.Write('Error de JSON: ' + JSONString);
   end;

   if JsonValue<>nil then begin
     //gaLogFile.Write(TJSONObject(JsonValue).ToString);
   end else begin
     gaLogFile.Write('Error de JSON: ' + JSONString);
   end;

   if ((JsonValue=nil) or (TJSONObject(JsonValue).ToString='')) then
      Result := nil
   else
     Result := JSONValue;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
function TFS_MainWebServiceSGA._Get_JSonValue ( Param: String ): String;
var
  JP: TJSONPair;
begin

   if Trim(Param)='' then begin
     Result := '';
     sLastErrorMessage := 'Parámetros inválidos';
     Exit;
   end;

   try
     JP := (JsonValue as TJSONObject).Get(Param);
     if JP=nil then begin
       Result := '';
       sLastErrorMessage := 'Parámetros inválidos';
       Exit;
     end;
   except
     Result := '';
     sLastErrorMessage := 'Parámetros inválidos';
     Exit;
   end;

   try
     Result := JP.JSONValue.Value;
   except
     Result := '';
     sLastErrorMessage := 'Parámetros inválidos';
     Exit;
   end;

   if JP<>nil then
     FreeAndNil(JP);

end;
*)

{$ENDREGION}


{$REGION 'THREADS'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ CONSTRUCTOR DEL THREAD ASÍNCRONO                                      │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
constructor TAsyncWebModuleThread.Create(
  const AConnectionString: String;
  const AParams, ARemoteAddr: String;
  AActionProc: TWebModuleActionProc;
  AHttpServer: TclHttpServer;
  AConnection: TclHttpUserConnection;
  const AContentType, ACharSet, AContentLanguage: String;
  AExtraFields: TStringList
);
begin
  inherited Create(False); // Iniciar inmediatamente
  FreeOnTerminate := True;  // Auto-destrucción al finalizar
  
  FConnectionString := AConnectionString;
  FParams := AParams;
  FRemoteAddr := ARemoteAddr;
  FActionProc := AActionProc;
  FActionProcWithPort := nil; // Inicializar a nil
  FPort := 0;
  FHttpServer := AHttpServer;
  FConnection := AConnection;
  
  // Copiar configuración de headers
  FContentType := AContentType;
  FCharSet := ACharSet;
  FContentLanguage := AContentLanguage;
  FExtraFields := TStringList.Create;
  
  // Copiar ExtraFields de forma segura
  if Assigned(AExtraFields) then
  begin
    try
      FExtraFields.Assign(AExtraFields);
    except
      on E: Exception do
      begin
        // Si falla la copia, agregar headers básicos manualmente
        FExtraFields.Add('Access-Control-Allow-Origin:*');
        FExtraFields.Add('Access-Control-Allow-Methods: PUT,POST,DELETE');
        
        if Assigned(gaLogFile) then
          gaLogFile.Write('Error copiando ExtraFields en thread. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
      end;
    end;
  end
  else
  begin
    // Si AExtraFields es nil, agregar headers básicos
    FExtraFields.Add('Access-Control-Allow-Origin:*');
    FExtraFields.Add('Access-Control-Allow-Methods: PUT,POST,DELETE');
  end;
  
  FStatusCode := 200;
  FStatusText := 'OK';
  FResponse := '';
  FTaskId := LOG_GenerateRandomHash(12);
  FStartTime := Now;
  FMaxExecutionSeconds := 60; // Timeout de 60 segundos
  
  //gaLogFile.Write('Thread asíncrono iniciado. TaskId: ' + FTaskId + '. IP: ' + FRemoteAddr, CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO);

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ CONSTRUCTOR DEL THREAD ASÍNCRONO (CON PUERTO)                         │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
constructor TAsyncWebModuleThread.Create(
  const AConnectionString: String;
  const AParams, ARemoteAddr: String;
  APort: Integer;
  AActionProc: TWebModuleActionProcWithPort;
  AHttpServer: TclHttpServer;
  AConnection: TclHttpUserConnection;
  const AContentType, ACharSet, AContentLanguage: String;
  AExtraFields: TStringList
);
begin
  inherited Create(False); // Iniciar inmediatamente
  FreeOnTerminate := True;  // Auto-destrucción al finalizar
  
  FConnectionString := AConnectionString;
  FParams := AParams;
  FRemoteAddr := ARemoteAddr;
  FPort := APort;
  FActionProc := nil;
  FActionProcWithPort := AActionProc;
  FHttpServer := AHttpServer;
  FConnection := AConnection;
  
  // Copiar configuración de headers
  FContentType := AContentType;
  FCharSet := ACharSet;
  FContentLanguage := AContentLanguage;
  FExtraFields := TStringList.Create;
  
  // Copiar ExtraFields de forma segura
  if Assigned(AExtraFields) then
  begin
    try
      FExtraFields.Assign(AExtraFields);
    except
      on E: Exception do
      begin
        // Si falla la copia, agregar headers básicos manualmente
        FExtraFields.Add('Access-Control-Allow-Origin:*');
        FExtraFields.Add('Access-Control-Allow-Methods: PUT,POST,DELETE');
        
        if Assigned(gaLogFile) then
          gaLogFile.Write('Error copiando ExtraFields en thread. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
      end;
    end;
  end
  else
  begin
    // Si AExtraFields es nil, agregar headers básicos
    FExtraFields.Add('Access-Control-Allow-Origin:*');
    FExtraFields.Add('Access-Control-Allow-Methods: PUT,POST,DELETE');
  end;
  
  FStatusCode := 200;
  FStatusText := 'OK';
  FResponse := '';
  FTaskId := LOG_GenerateRandomHash(12);
  FStartTime := Now;
  FMaxExecutionSeconds := 60; // Timeout de 60 segundos
  
  //if Assigned(gaLogFile) then
  //  gaLogFile.Write('Thread asíncrono (PORT) iniciado. TaskId: ' + FTaskId + '. IP: ' + FRemoteAddr, CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO);
end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ DESTRUCTOR DEL THREAD                                                 │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
destructor TAsyncWebModuleThread.Destroy;
begin
  if Assigned(FExtraFields) then
    FreeAndNil(FExtraFields);
    
  inherited;
end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ EJECUCIÓN DEL THREAD                                                  │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TAsyncWebModuleThread.Execute;
var
  Conn: TADOConnection;
  ExecutionTime: Integer;
  bTimeout: Boolean;
begin
  Conn := nil;
  bTimeout := False;
  
  try
    try
      // Verificar timeout antes de empezar
      if SecondsBetween(Now, FStartTime) > FMaxExecutionSeconds then
      begin
        FStatusCode := 504;
        FStatusText := 'Gateway Timeout';
        FResponse := '{"Result":"ERROR","Error":"Thread timeout before execution","Data":[]}';
        bTimeout := True;
        
        if Assigned(gaLogFile) then
          gaLogFile.Write('Thread timeout antes de ejecutar. TaskId: ' + FTaskId, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
        Exit;
      end;
      
      // Crear conexión independiente a la base de datos
      //if Assigned(gaLogFile) then
      //  gaLogFile.Write('Creando conexión DB en thread. TaskId: ' + FTaskId,
      //                 CONST_LOGID_SGA, LOG_LEVEL_DEBUG);
      
      Conn := TADOConnection.Create(nil);
      Conn.ConnectionString := FConnectionString;
      Conn.LoginPrompt := False;
      Conn.CommandTimeout := 300; // 5 minutos para comandos SQL
      
      try
        Conn.Open;
        
        //if Assigned(gaLogFile) then
        //  gaLogFile.Write('Conexión DB abierta en thread. TaskId: ' + FTaskId,
        //                 CONST_LOGID_SGA, LOG_LEVEL_DEBUG);
      except
        on E: Exception do
        begin
          FStatusCode := 503;
          FStatusText := 'Service Unavailable';
          FResponse := '{"Result":"ERROR","Error":"Database connection failed: ' + 
                       StringReplace(E.Message, '"', '\"', [rfReplaceAll]) + 
                       '","Data":[]}';
          
          if Assigned(gaLogFile) then
            gaLogFile.Write('Error al conectar DB en thread. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                           CONST_LOGID_SGA, LOG_LEVEL_ERROR);
          Exit;
        end;
      end;
      
      // Ejecutar la acción del WebModule
      //if Assigned(gaLogFile) then
      //  gaLogFile.Write('Ejecutando acción en thread. TaskId: ' + FTaskId,
      //                 CONST_LOGID_SGA, LOG_LEVEL_INFO);
        
      if Assigned(FActionProc) then
        FActionProc(Conn, FParams, FRemoteAddr, FStatusCode, FStatusText, FResponse)
      else if Assigned(FActionProcWithPort) then
        FActionProcWithPort(Conn, FParams, FRemoteAddr, FPort, FStatusCode, FStatusText, FResponse);
      
      // Calcular tiempo de ejecución
      ExecutionTime := SecondsBetween(Now, FStartTime);
      
      //if Assigned(gaLogFile) then
      //  gaLogFile.Write('Acción completada en thread. TaskId: ' + FTaskId +
      //                 '. Tiempo: ' + IntToStr(ExecutionTime) + 's. StatusCode: ' + IntToStr(FStatusCode),
      //                 CONST_LOGID_SGA, LOG_LEVEL_INFO);
      
      // Verificar timeout después de ejecutar
      if ExecutionTime > FMaxExecutionSeconds then
      begin
        FStatusCode := 504;
        FStatusText := 'Gateway Timeout';
        FResponse := '{"Result":"ERROR","Error":"Execution timeout (' + 
                     IntToStr(ExecutionTime) + 's)","Data":[]}';
        bTimeout := True;
        
        if Assigned(gaLogFile) then
          gaLogFile.Write('Thread excedió timeout. TaskId: ' + FTaskId + 
                         '. Tiempo: ' + IntToStr(ExecutionTime) + 's', 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
      end;
      
    except
      on E: Exception do
      begin
        FStatusCode := 500;
        FStatusText := 'Internal Server Error';
        FResponse := '{"Result":"ERROR","Error":"' + 
                     StringReplace(E.Message, '"', '\"', [rfReplaceAll]) + 
                     '","Data":[]}';
        
        if Assigned(gaLogFile) then
          gaLogFile.Write('Excepción en thread. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                         CONST_LOGID_SGA, LOG_LEVEL_EXCEPTION);
      end;
    end;
    
  finally
    // Cerrar y liberar conexión DB
    if Assigned(Conn) then
    begin
      try
        if Conn.Connected then
        begin
          Conn.Close;
          
          //if Assigned(gaLogFile) then
          //  gaLogFile.Write('Conexión DB cerrada en thread. TaskId: ' + FTaskId,
          //                 CONST_LOGID_SGA, LOG_LEVEL_DEBUG);
        end;
      except
        on E: Exception do
        begin
          if Assigned(gaLogFile) then
            gaLogFile.Write('Error cerrando conexión DB. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                           CONST_LOGID_SGA, LOG_LEVEL_WARNING);
        end;
      end;
      FreeAndNil(Conn);
    end;
    
    // Enviar respuesta HTTP directamente (SIN Synchronize para permitir paralelismo real)
    // IMPORTANTE: Capturar TODAS las excepciones para evitar bloquear el servidor
    try
      if not bTimeout then
      begin
        try
          SendHttpResponse;  // Llamada directa - NO Synchronize
        except
          on E: Exception do
          begin
            // Cliente probablemente cerró la conexión - esto es normal
            if Assigned(gaLogFile) then
              gaLogFile.Write('Cliente desconectado antes de recibir respuesta. TaskId: ' + FTaskId + 
                             '. Error: ' + E.Message, 
                             CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
          end;
        end;
      end
      else
      begin
        // Si hay timeout, intentar enviar respuesta de todas formas
        try
          SendHttpResponse;  // Llamada directa - NO Synchronize
        except
          on E: Exception do
          begin
            if Assigned(gaLogFile) then
              gaLogFile.Write('No se pudo enviar respuesta de timeout. TaskId: ' + FTaskId + 
                             '. Error: ' + E.Message, 
                             CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
          end;
        end;
      end;
    except
      // Captura final por si acaso - nunca debe llegar aquí
      on E: Exception do
      begin
        if Assigned(gaLogFile) then
          gaLogFile.Write('Error inesperado en envío de respuesta. TaskId: ' + FTaskId + 
                         '. Error: ' + E.Message, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_ERROR);
      end;
    end;
  end;
end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ ENVÍO DE RESPUESTA HTTP (ejecutado directamente desde worker thread) │ \\
// │ NOTA: Usa TCriticalSection para thread-safety, NO Synchronize        │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TAsyncWebModuleThread.SendHttpResponse;
var
  bConnectionValid: Boolean;
  sPeerIP: String;
  bShouldSendResponse: Boolean;
begin
  bConnectionValid := False;
  sPeerIP := '';
  bShouldSendResponse := True;
  
  try
    // Verificar que los objetos sigan válidos
    if not Assigned(FHttpServer) then
    begin
      if Assigned(gaLogFile) then
        gaLogFile.Write('HttpServer es nil, no se puede enviar respuesta. TaskId: ' + FTaskId,
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
      bShouldSendResponse := False;
    end;
      
    if bShouldSendResponse and not Assigned(FConnection) then
    begin
      if Assigned(gaLogFile) then
        gaLogFile.Write('Connection es nil, no se puede enviar respuesta. TaskId: ' + FTaskId,
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
      bShouldSendResponse := False;
    end;
      
    // Verificar que la conexión siga activa
    if bShouldSendResponse then
    begin
      try
        sPeerIP := FConnection.PeerIP;
        if sPeerIP <> '' then
          bConnectionValid := True;
      except
        on E: Exception do
        begin
          bConnectionValid := False;
          if Assigned(gaLogFile) then
            gaLogFile.Write('Conexión cerrada por cliente. TaskId: ' + FTaskId,
                           CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
        end;
      end;
        
      if not bConnectionValid then
      begin
        //if Assigned(gaLogFile) then
        //  gaLogFile.Write('Cliente desconectado (refresh/close). TaskId: ' + FTaskId,
        //                 CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
        bShouldSendResponse := False;
      end;
    end;
      
    // Solo intentar enviar si la conexión es válida
    if bShouldSendResponse then
    begin
      // Actualizar headers de respuesta (NO necesita protección - cada thread tiene su FConnection)
      try
        FConnection.ResponseHeader.ContentType := FContentType;
        FConnection.ResponseHeader.CharSet := FCharSet;
        FConnection.ResponseHeader.ContentLanguage := FContentLanguage;
        FConnection.ResponseHeader.ExtraFields.Assign(FExtraFields);
        FConnection.ResponseHeader.Update;
      except
        on E: Exception do
        begin
          if Assigned(gaLogFile) then
            gaLogFile.Write('Error actualizando headers (ignorado). TaskId: ' + FTaskId,
                           CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
        end;
      end;
        
      // CRÍTICO: Solo proteger la llamada SendResponse (operación mínima)
      // Esto minimiza el tiempo en CriticalSection para máximo paralelismo
      try
        if Assigned(gHttpResponseCS) then
          gHttpResponseCS.Enter;
        try
          FHttpServer.SendResponse(FConnection, FStatusCode, FStatusText, FResponse);
        finally
          if Assigned(gHttpResponseCS) then
            gHttpResponseCS.Leave;
        end;
          
        //if Assigned(gaLogFile) then
        //  gaLogFile.Write('Respuesta HTTP enviada. TaskId: ' + FTaskId +
        //                 '. StatusCode: ' + IntToStr(FStatusCode) +
        //                 '. IP: ' + sPeerIP +
        //                 '. Size: ' + IntToStr(Length(FResponse)) + ' bytes',
        //                 CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO);
      except
        on E: Exception do
        begin
          // Cliente cerró conexión - esto es normal, no es un error
          if Assigned(gaLogFile) then
            gaLogFile.Write('Cliente cerró conexión antes de recibir respuesta. TaskId: ' + FTaskId,
                           CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
        end;
      end;
    end;

  except
    on E: Exception do
    begin
      if Assigned(gaLogFile) then
        gaLogFile.Write('Error inesperado en SendHttpResponse. TaskId: ' + FTaskId +
                       '. Error: ' + E.Message,
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
    end;
  end;
    
  // NOTA: Ya no llamamos a EndWork aquí porque lo llamamos en el hilo principal
  // para liberar el servidor inmediatamente.
  //if Assigned(gaLogFile) then
  //  gaLogFile.Write('Thread finalizado. TaskId: ' + FTaskId,
  //                 CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);

end;

{$ENDREGION}



initialization
  gHttpResponseCS := TCriticalSection.Create;

finalization
  if Assigned(gHttpResponseCS) then
    FreeAndNil(gHttpResponseCS);

end.
