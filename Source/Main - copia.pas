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
  ppProd, ppReport, raCodMod, ppModule, ppDB, ppDBPipe;


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
    constructor Create(
      const AConnectionString: String;
      const AParams, ARemoteAddr: String;
      AActionProc: TWebModuleActionProc;
      AHttpServer: TclHttpServer;
      AConnection: TclHttpUserConnection;
      const AContentType, ACharSet, AContentLanguage: String;
      AExtraFields: TStringList
    );
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
begin

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

  try
    if (sCommand='/diagnostics') then
      WebModule1diagnosticsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/logo') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1logoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/userimage') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1userImageAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/artimage') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1artImageAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/loadscans') then
      WebModule1loadScansAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/savescans') then
      WebModule1saveScansAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/savenumerosseriepreparacion') then
      WebModule1saveNumerosSeriePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/reconnectdb') then
      WebModule1reconnectDBAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/printercapabilities') then
    begin
      AConnection.ResponseHeader.ContentType := '';
      WebModule1testPrinterAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )
    end

    else if (sCommand='/impresoras') then
      WebModule1impresorasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listtemplates') then
      WebModule1listTemplatesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/restartservice') then
      WebModule1restartServiceAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkubicacionpalet') then
      WebModule1checkUbicacionPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/imprimircajaexpedicion') then
      WebModule1printCajaExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/moverpalet') then
      WebModule1moverPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/paletsenubicacion') then
      WebModule1paletsEnUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/empresas') then
      WebModule1listCompaniesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/aprovisionamientos') then
      WebModule1listAprovisionamientosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getaprovisionamientodetail') then
      WebModule1getAprovisionamientoDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/refreshaprovisionamientodetail') then
      WebModule1refreshAprovisionamientoDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getaprovisionamientosmovimientos') then
      WebModule1getAprovisionamientoMovimientosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cerraraprovisionamiento') then
      WebModule1cerrarAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/setbloqueoubicacion') then
      WebModule1setBloqueoUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generatematricula') then
      WebModule1generateMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/changepaletpackaging') then
      WebModule1changePaletPackagingAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listalmacenes') then
      WebModule1listAlmacenesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/logout') then
      WebModule1logoutAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validateuser') then
      WebModule1validateUserAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.Port, statusCode, statusText, sResponse )

    else if (sCommand='/readformperms') then
      WebModule1readFormPermsAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.Port, statusCode, statusText, sResponse )

    else if (sCommand='/userlist') then
      WebModule1userListAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/freelicense') then
      WebModule1freeLicenseAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.PeerPort, statusCode, statusText, sResponse )

    else if (sCommand='/encodeurl') then
      WebModule1encodeUrlAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.PeerPort, statusCode, statusText, sResponse )

    else if (sCommand='/checklicense') then
      WebModule1checkLicenseAction
        ( SQLConn, sParams, AConnection.PeerIP, AConnection.PeerPort, statusCode, statusText, sResponse )

    else if (sCommand='/updateinventariodetail') then
      WebModule1updateInventarioDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deleteinventariodetail') then
      WebModule1deleteInventarioDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/closeinventario') then
      WebModule1closeInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validateinventoriodetail') then
      WebModule1validateInventarioDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validarubicacioninventario') then
      WebModule1validarUbicacionInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/readparam') then
      WebModule1readParamAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkubicacioninventario') then
      WebModule1checkUbicacionInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/proximaubicacion') then
      WebModule1proximaUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/readparams') then
      WebModule1readParamsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/readbarcode') then
      WebModule1readBarcodeAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getdefaultlocations') then
      WebModule1getDefaultLocationsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listinformes') then
      WebModule1listInformesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/startpreparacion') then
      WebModule1startPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/stoppreparacion') then
      WebModule1stopPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpreparaciones') then
      WebModule1listPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpreparaciones2') then
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
      Exit; // Salir sin enviar respuesta - el thread lo hará
    end

    else if (sCommand='/getmetodoruta') then
      WebModule1getMetodoRutaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/savemetodoruta') then
      WebModule1saveMetodoRutaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cambiarunidadmedida') then
      WebModule1cambiarUnidadMedidaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepedidoslist') then
      WebModule1updatePedidosListAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/clearexpedicion') then
      WebModule1clearExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/recibirlinea') then
      WebModule1recibirLineaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getinfopreparacion') then
      WebModule1getInfoPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateobservacionespreparacion') then
      WebModule1updateObservacionesPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/entradastock') then
      WebModule1entradaStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/salidastock') then
      WebModule1salidaStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/traspasostock') then
      WebModule1traspasoStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/regularizacion') then
      WebModule1regularizacionStockAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabecerapedidoventa') then
      WebModule1cabeceraPedidoVentaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabecerapedidocompra') then
      WebModule1cabeceraPedidoCompraAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesarticulo') then
      WebModule1ubicacionesArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getpackinglist') then
      WebModule1getPackingListAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/connectioninfo') then
      WebModule1getConnectionInfoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getpackinglistexpedicion') then
      WebModule1getPackingListExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/movimientosarticulo') then
      WebModule1movimientosArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deleteexpediciondetalle') then
      WebModule1deleteExpedicionDetalleAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/codigoarticuloubicacion') then
      WebModule1codigoArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listzonas') then
      WebModule1getZonasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listubicaciones') then
      WebModule1getUbicacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosubicacion') then
      WebModule1listArticulosUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listproveedores') then
      WebModule1listProveedoresAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getzonaspreparaciones') then
      WebModule1getZonasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/gettransportistaspreparaciones') then
      WebModule1getTransportistasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getcomisionistaspreparaciones') then
      WebModule1getComisionistasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getrutaspreparaciones') then
      WebModule1getRutasPreparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpartidas') then
      WebModule1listPartidasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listtallas') then
      WebModule1listTallasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listcolores') then
      WebModule1listColoresAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listclientes') then
      WebModule1listClientesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineaspedidocompra') then
      WebModule1listLineasPedidoCompraAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineasalbarancompra') then
      WebModule1listLineasAlbaranProveedorAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineaspedidoventa') then
      WebModule1listLineasPedidoVentaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabeceraalbaranventa') then
      WebModule1listCabeceraAlbaranClienteAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cabeceraalbarancompra') then
      WebModule1listCabeceraAlbaranCompraAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/lineasalbaranventa') then
      WebModule1listLineasAlbaranVentaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatetraspasosselected') then
      WebModule1updateTraspasosSelectedAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/traspasarlista') then
      WebModule1traspasarListaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkemptytarget') then
      WebModule1checkEmptyTargetAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulos') then
      WebModule1listArticulosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/findarticulos') then
      WebModule1findArticulosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getnumerosserierecepcion') then
      WebModule1getNumerosSerieRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getnumerosseriepreparacion') then
      WebModule1getNumerosSeriePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listfamilias') then
      WebModule1listFamiliasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listsubfamilias') then
      WebModule1listSubfamiliasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpasillos') then
      WebModule1getPasilloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listestanterias') then
      WebModule1listEstanteriasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listalturas') then
      WebModule1listAlturasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listfondos') then
      WebModule1listFondosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacion') then
      WebModule1detallePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/preparacionubicaciones') then
      WebModule1preparacionUbicacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listinventarios') then
      WebModule1listInventariosAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/test') then
      CONFIG_SendVersions ( SQLConn )

    else if (sCommand='/updatecajaspalets') then
      WebModule1updateCajasPaletsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatereservapalet') then
      WebModule1updateReservaPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checkunidadespreparadas') then
      WebModule1checkUnidadesPreparadas
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generatepackinglistauto') then
      WebModule1generatePackingListAuto
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generatepackinglistasis') then
      WebModule1generatePackingListAsis
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getarticulodetails') then
      WebModule1getArticuloDetailsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateunidadespreparacion') then
      WebModule1updateUnidadesPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateunidadespreparaciontc') then
      WebModule1updateUnidadesPreparacionTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deletepreparaciondetail') then
      WebModule1deletePreparacionDetailTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listrecepciones') then
      WebModule1listRecepcionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallerecepcion') then
      WebModule1detalleRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updaterecepcion') then
      WebModule1updateRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/dashboard') then
      WebModule1dashboardAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/validateubicacion') then
      WebModule1validateUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listinventarioubicaciones') then
      WebModule1listInventarioUbicacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateinventarioubicacion') then
      WebModule1updateInventarioUbicacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listincidencias') then
      WebModule1listIncidenciasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listubicacionesfavoritas') then
      WebModule1listUbicacionesFavoritasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesrecepcion') then
      WebModule1ubicacionesRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesdevolucion') then
      WebModule1ubicacionesDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/ubicacionesdevolucionprov') then
      WebModule1ubicacionesDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirrecepcion') then
      WebModule1servirRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listdevoluciones') then
      WebModule1listDevolucionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listdevolucionesprov') then
      WebModule1listDevolucionesProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalledevolucion') then
      WebModule1detalleDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalledevolucionprov') then
      WebModule1detalleDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpedicion') then
      WebModule1detalleExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expediciondisponible') then
      WebModule1expedicionDisponibleAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/actualizarexpedicion') then
      WebModule1actualizarExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getdetallepartidas') then
      WebModule1getDetallePartidasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/actualizarexpedicionall') then
      WebModule1actualizarExpedicionAllAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatedevolucion') then
      WebModule1updateDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatedevolucionprov') then
      WebModule1updateDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirdevolucion') then
      WebModule1servirDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirdevolucionprov') then
      WebModule1servirDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacionorden') then
      WebModule1detallePreparacionOrdenAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deleterecepciondetail') then
      WebModule1deleteRecepcionDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deletedevoluciondetail') then
      WebModule1deleteDevolucionDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/deletedevolucionprovdetail') then
      WebModule1deleteDevolucionProvDetailAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getreposicionescount') then
      WebModule1getReposicionesCountAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getreposicionesalmacen') then
      WebModule1getReposicionesAlmacenAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/articuloenreposicion') then
      WebModule1articuloEnReposicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/preparacioncalcularindice') then
      WebModule1preparacionCalcularIndiceAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepaletcajaactual') then
      WebModule1updatePaletCajaActualAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepaletcajapreparacion') then
      WebModule1updatePaletCajaPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/findpaletmatricula') then
      WebModule1findPaletMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generarpackinglistauto') then
      WebModule1generarPackingListAutoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedirtodo') then
      WebModule1expedirTodoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getlastcajaid') then
      WebModule1getLastCajaIdAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/borrarlineaexpedicion') then
      WebModule1borrarLineaExpedicionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedirlinea') then
      WebModule1expedirLineaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checknumeroserierecepcion') then
      WebModule1checkNumeroSerieRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/checknumeroseriepreparacion') then
      WebModule1checkNumeroSeriePreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/renumerarcajas') then
      WebModule1renumerarCajasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getexpedicioncaja') then
      WebModule1getexpedicioncajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedicionpartidasarticulo') then
      WebModule1expedicionPartidasArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedicionpartidasarticulotc') then
      WebModule1expedicionPartidasArticuloTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedicionpartidasarticulobryocantc') then
      WebModule1expedicionPartidasArticuloBryocanTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpedicion2') then
      WebModule1detalleExpedicion2Action
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/traspasoubicaciondestino') then
      WebModule1traspasoUbicacionDestinoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getmaxusedpartida') then
      WebModule1getMaxUsedPartidaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/articuloscaja') then
      WebModule1articulosCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/actualizarruta') then
      WebModule1actualizarRutaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosrecepcion') then
      WebModule1listArticulosRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosdevolucion') then
      WebModule1listArticulosDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listarticulosdevolucionprov') then
      WebModule1listArticulosDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/desgloserecepcion') then
      WebModule1desgloseRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/desglosedevolucion') then
      WebModule1desgloseDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/desglosedevolucionprov') then
      WebModule1desgloseDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatecabecerarecepcion') then
      WebModule1updateCabeceraRecepcionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatecabeceradevolucion') then
      WebModule1updateCabeceraDevolucionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatecabeceradevolucionprov') then
      WebModule1updateCabeceraDevolucionProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacionpedido') then
      WebModule1detallePreparacionPedidoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepreparacionpedidonew') then
      WebModule1detallePreparacionPedidoNewAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpackagings') then
      WebModule1listPackagingsAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/imprimirmatricula') then
      WebModule1imprimirMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpackagingspreparacion') then
      WebModule1listPackagingsPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingmatricula') then
      WebModule1updatePackagingMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingmatriculacaja') then
      WebModule1updatePackagingMatriculaCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingpalet') then
      WebModule1updatePackagingPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updatepackagingcaja') then
      WebModule1updatePackagingCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpediciontc') then
      WebModule1detalleExpedicionTCAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpediciontcpartidas') then
      WebModule1detalleExpedicionTCPartidasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/recuperarpackinglistscans') then
      WebModule1detallerecuperarPackingListScansAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleexpediciontcagrupaciones') then
      WebModule1detalleExpedicionTCAgrupacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detallepackinglistarticulo') then
      WebModule1detallePackingListArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/expedirpedido') then
      WebModule1expedirPedidoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/contenidoubicacioninventario') then
      WebModule1contenidoUbicacionInventarioAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listpreparacionordenada') then
      WebModule1listPreparacionOrdenadaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listinformes') then
      WebModule1listInformesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/recuperarinfopalet') then
      WebModule1recuperarInfoPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/findubicacionmatricula') then
      WebModule1findUbicacionMatriculaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/clientes') then
      WebModule1clientesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cadenas') then
      WebModule1cadenasAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    {else if (sCommand='/preparaciones') then
      WebModule1preparacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )}

    else if (sCommand='/recuperarmotivosbloqueo') then
      WebModule1recuperarMotivosBloqueoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cambiarmotivobloqueo') then
      WebModule1cambiarMotivoBloqueoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/cambiartiporeserva') then
      WebModule1cambiarTipoReservaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/updateestadopalet') then
      WebModule1updateEstadoPaletAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/generarinforme') then
      WebModule1generarInformeAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirprep') then
      WebModule1prepareServirPrepAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/servirpreparacion') then
      WebModule1servirPreparacionAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirrec') then
      WebModule1prepareServirRecAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirdev') then
      WebModule1prepareServirDevAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/prepareservirdevprov') then
      WebModule1prepareServirDevProvAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/listaprovisionamientos') then
      WebModule1listAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/detalleaprovisionamiento') then
      WebModule1detalleAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/finishtransitosaprovisionamiento') then
      WebModule1finishTransitosAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/restorepaletmatriculacaja') then
      WebModule1restorePaletMatriculaCajaAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/refreshrutaaprovisionamiento') then
      WebModule1refreshRutaAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/moveaprovisionamientotoend') then
      WebModule1moveAprovisionamientoToEndAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/doaprovisionamiento') then
      WebModule1doAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/refreshstockarticulo') then
      WebModule1refreshStockArticuloAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    else if (sCommand='/getlicenseinfo') then
      WebModule1getLicenseInfoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )

    {else if (sCommand='/updateaprovisionamiento') then
      WebModule1updateAprovisionamientoAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse )}

    else if (sCommand='/getagrupaciones') then
      WebModule1getAgrupacionesAction
        ( SQLConn, sParams, AConnection.PeerIP, statusCode, statusText, sResponse );

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

  try
    (Sender as TclHttpServer).SendResponse(AConnection, statusCode, statusText, sResponse);
  finally
    (Sender as TclHttpServer).EndWork;
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
  
  if Assigned(gaLogFile) then
    gaLogFile.Write('Thread asíncrono iniciado. TaskId: ' + FTaskId + '. IP: ' + FRemoteAddr, 
                   CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO);
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
      if Assigned(gaLogFile) then
        gaLogFile.Write('Creando conexión DB en thread. TaskId: ' + FTaskId, 
                       CONST_LOGID_SGA, LOG_LEVEL_DEBUG);
      
      Conn := TADOConnection.Create(nil);
      Conn.ConnectionString := FConnectionString;
      Conn.LoginPrompt := False;
      Conn.CommandTimeout := 300; // 5 minutos para comandos SQL
      
      try
        Conn.Open;
        
        if Assigned(gaLogFile) then
          gaLogFile.Write('Conexión DB abierta en thread. TaskId: ' + FTaskId, 
                         CONST_LOGID_SGA, LOG_LEVEL_DEBUG);
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
      if Assigned(gaLogFile) then
        gaLogFile.Write('Ejecutando acción en thread. TaskId: ' + FTaskId, 
                       CONST_LOGID_SGA, LOG_LEVEL_INFO);
        
      FActionProc(Conn, FParams, FRemoteAddr, FStatusCode, FStatusText, FResponse);
      
      // Calcular tiempo de ejecución
      ExecutionTime := SecondsBetween(Now, FStartTime);
      
      if Assigned(gaLogFile) then
        gaLogFile.Write('Acción completada en thread. TaskId: ' + FTaskId + 
                       '. Tiempo: ' + IntToStr(ExecutionTime) + 's. StatusCode: ' + IntToStr(FStatusCode), 
                       CONST_LOGID_SGA, LOG_LEVEL_INFO);
      
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
          
          if Assigned(gaLogFile) then
            gaLogFile.Write('Conexión DB cerrada en thread. TaskId: ' + FTaskId, 
                           CONST_LOGID_SGA, LOG_LEVEL_DEBUG);
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
    
    // Enviar respuesta HTTP (sincronizado con thread principal)
    if not bTimeout then
      Synchronize(SendHttpResponse)
    else
    begin
      // Si hay timeout, intentar enviar respuesta de todas formas
      try
        Synchronize(SendHttpResponse);
      except
        if Assigned(gaLogFile) then
          gaLogFile.Write('No se pudo enviar respuesta de timeout. TaskId: ' + FTaskId, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_ERROR);
      end;
    end;
  end;
end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ ENVÍO DE RESPUESTA HTTP (ejecutado en thread principal)              │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure TAsyncWebModuleThread.SendHttpResponse;
var
  bConnectionValid: Boolean;
  sPeerIP: String;
begin
  bConnectionValid := False;
  sPeerIP := '';
  
  try
    // Verificar que los objetos sigan válidos
    if not Assigned(FHttpServer) then
    begin
      if Assigned(gaLogFile) then
        gaLogFile.Write('HttpServer es nil, no se puede enviar respuesta. TaskId: ' + FTaskId, 
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_ERROR);
      Exit;
    end;
    
    if not Assigned(FConnection) then
    begin
      if Assigned(gaLogFile) then
        gaLogFile.Write('Connection es nil, no se puede enviar respuesta. TaskId: ' + FTaskId, 
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
      Exit;
    end;
    
    // Verificar que la conexión siga activa
    try
      sPeerIP := FConnection.PeerIP;
      if sPeerIP <> '' then
        bConnectionValid := True;
    except
      on E: Exception do
      begin
        bConnectionValid := False;
        if Assigned(gaLogFile) then
          gaLogFile.Write('Error verificando conexión. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
      end;
    end;
    
    if not bConnectionValid then
    begin
      if Assigned(gaLogFile) then
        gaLogFile.Write('Conexión HTTP cerrada o inválida. TaskId: ' + FTaskId, 
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
      Exit;
    end;
    
    // Actualizar headers de respuesta
    try
      FConnection.ResponseHeader.ContentType := FContentType;
      FConnection.ResponseHeader.CharSet := FCharSet;
      FConnection.ResponseHeader.ContentLanguage := FContentLanguage;
      FConnection.ResponseHeader.ExtraFields.Assign(FExtraFields);
      FConnection.ResponseHeader.Update;
      
      if Assigned(gaLogFile) then
        gaLogFile.Write('Headers actualizados. TaskId: ' + FTaskId, 
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
    except
      on E: Exception do
      begin
        if Assigned(gaLogFile) then
          gaLogFile.Write('Error actualizando headers. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
        // Continuar de todas formas
      end;
    end;
    
    // Enviar respuesta HTTP (firma correcta: AConnection, statusCode, statusText, sResponse)
    try
      FHttpServer.SendResponse(FConnection, FStatusCode, FStatusText, FResponse);
      
      if Assigned(gaLogFile) then
        gaLogFile.Write('Respuesta HTTP enviada. TaskId: ' + FTaskId + 
                       '. StatusCode: ' + IntToStr(FStatusCode) + 
                       '. IP: ' + sPeerIP + 
                       '. Size: ' + IntToStr(Length(FResponse)) + ' bytes', 
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_INFO);
    except
      on E: Exception do
      begin
        if Assigned(gaLogFile) then
          gaLogFile.Write('Error enviando respuesta HTTP. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_ERROR);
        Exit;
      end;
    end;
    
    // Finalizar trabajo del servidor
    try
      FHttpServer.EndWork;
      
      if Assigned(gaLogFile) then
        gaLogFile.Write('EndWork ejecutado. TaskId: ' + FTaskId, 
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_DEBUG);
    except
      on E: Exception do
      begin
        if Assigned(gaLogFile) then
          gaLogFile.Write('Error en EndWork. TaskId: ' + FTaskId + '. Error: ' + E.Message, 
                         CONST_LOGID_WEBSERVER, LOG_LEVEL_WARNING);
      end;
    end;
    
  except
    on E: Exception do
    begin
      if Assigned(gaLogFile) then
        gaLogFile.Write('Error enviando respuesta asíncrona. TaskId: ' + FTaskId + 
                       '. Error: ' + E.Message + 
                       ' (la conexión probablemente se cerró)', 
                       CONST_LOGID_WEBSERVER, LOG_LEVEL_ERROR);
    end;
  end;
end;

{$ENDREGION}



end.
