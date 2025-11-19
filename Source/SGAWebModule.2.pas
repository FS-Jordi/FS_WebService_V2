// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │ \\
// │ FACTORYSTART LICENSE SERVER v1.0                                      │ \\
// │                                                                       │ \\
// ├───────────────────────────────────────────────────────────────────────┤ \\
// │                                                                       │ \\
// │ WEBSERVICE PER A L'APLICACIÓ SGA MÒBIL                                │ \\
// │                                                                       │ \\
// ├───────────────────────────────────────────────────────────────────────┤ \\
// │ COPYRIGHT © 2019-2020 ARTECSOFT, S.L.                                 │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\

unit SGAWebModule;


interface


{$REGION '--- IMPORTACIONS'}

uses
  System.SysUtils,
  System.Classes,
  Web.HTTPApp,
  Data.DB,
  Data.Win.ADODB,
  System.DateUtils,
  WinApi.ActiveX,
  System.JSON,
  System.RegularExpressions,
  Functions_PARAMS,
  Variants;

{$ENDREGION}


{$REGION '--- DEFINICIÓ DE TIPUS'}

const
  DEFAULT_PAGE_SIZE = 20;


procedure WebModuleBeforeDispatch ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

procedure WebModule1DefaultHandlerAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listCompaniesAction  ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listAlmacenesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1entradaStockAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listPedidosVentaAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listPedidosCompraAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1salidaStockAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1traspasoStockAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1regularizacionStockAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listUbicacionesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1movimientosArticuloAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1codigoArticuloAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1getZonasAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1getUbicacionesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1getArticulosAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listProveedoresAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listClientesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listLineasPedidoCompraAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listLineasAlbaranProveedorAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listLineasPedidoVentaAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listCabeceraAlbaranClienteAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listCabeceraAlbaranCompraAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listLineasAlbaranVentaAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listArticulosAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listFamiliasAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listSubfamiliasAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1getPasilloAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listEstanteriasAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listAlturasAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listFondosAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listPreparacionesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detallePreparacionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1preparacionUbicacionesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listInventariosAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1updateCajasPaletsAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1userListAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1validateUserAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1getArticuloDetailsAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1updateCantidadPreparacionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listRecepcionesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detalleRecepcionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1updateRecepcionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1dashboardAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1validateUbicacionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listInventarioUbicacionesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1updateInventarioUbicacionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listIndicenciasAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listUbicacionesFavoritasAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1ubicacionesRecepcionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1ubicacionesDevolucionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1servirRecepcionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listDevolucionesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detalleDevolucionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detalleExpedicionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1expedicionDisponibleAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1readBarcodeAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1actualizarExpedicionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1updateDevolucionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1servirDevolucionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1readParamAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detallePreparacionOrdenOldAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detallePreparacionOrdenAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1preparacionCalcularIndiceAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1expedicionPartidasArticuloAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detalleExpedicion2Action ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1traspasoUbicacionDestinoAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1articulosCajaAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1actualizarRutaAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listArticulosRecepcionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1desgloseRecepcionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1updateCabeceraRecepcionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1readParamsAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1detallePreparacionPedidoAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1expedirPedidoAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1contenidoUbicacionInventarioAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listPreparacionOrdenadaAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1listInformesAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1generarInformeAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1servirPreparacionOldAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1prepareServirPrepAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1servirPreparacionAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1prepareServirRecAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
procedure WebModule1diagnosticsAction ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );


{$ENDREGION}


function FS_SGA_ObtenerUbicaciones ( Conn: TADOConnection; CodigoEmpresa: Integer;
  CodigoArticulo, Partida, CodigoAlmacen: String; MostrarPartidas: Integer;
  var Error: Boolean; var iStockTotal: Double ): String;


implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}


{$REGION '--- IMPORTACIONS'}

uses
  Globals,
  Functions_EncryptDecrypt,
  Functions_LogV2,
  Functions,
  Functions_Network,
  Functions_DB,
  Functions_SAGE,
  Functions_SGA,
  Functions_JSON,
  Main;

{$ENDREGION}


{$REGION '--- FUNCIONS GENERALS'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ AFEGIM EL CORS A TOTES LES RESPOSTES DEL WEBSERVICE                   │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModuleBeforeDispatch ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
begin

  {
  Response.SetCustomHeader('Access-Control-Allow-Origin','*');

  if Trim(Request.GetFieldByName('Access-Control-Request-Headers')) <> '' then
  begin
    Response.SetCustomHeader('Access-Control-Allow-Headers',
      Request.GetFieldByName('Access-Control-Request-Headers'));
    Handled := True;
  end;

  if Conn=nil then
    Conn := FS_MainWebServiceSGA.SQLConn;

  //CONFIG_Server_Alive();
  }

end;



// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ PÀGINA INDEX                                                          │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1actualizarExpedicionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  contentfields: TStringList;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  IdPreparacion: Integer;
  PickingId: Integer;
  Result: String;
  sSQL: String;
  Data: String;
  Desglose: String;
  lJSonValue: TJSonValue;
  CodigoUbicacion: String;
  CodigoArticulo: String;
  Partida: String;
  LineasPosicion: String;
  Q: TADOQuery;
  aUbicacion: TSGAUbicacion;
  Stock: Double;
  bErr: Boolean;
  sMsg: String;
  sNewGuid: String;
  sNewMovOrigen: String;
  sOrigenMovimiento: String;
  YY: Integer;
  CodigoUsuario: Integer;
  iNum: Integer;
  Unidades: Double;
  UnidadMedida: String;
  UnidadesBase: Double;
  UnidadMedidaBase: String;
  UnidadesMaximas: Double;
  FactorConversion: Double;
  TratamientoPartidas: Boolean;
  IdentificadorExpedicion: Integer;
  CajaId: Integer;
  Ejercicio: Integer;
  sId: string;
  sStr: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1actualizarExpedicionAction: ' + Request.RemoteAddr, sIDCall, LOG_LEVEL_TRACE );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SGA_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  IdentificadorExpedicion := StrToIntDef(request.contentfields.values['IdExpedicion'],0);
  if IdentificadorExpedicion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CajaId := StrToIntDef(request.contentfields.values['CajaId'],0);
  if CajaId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de caja no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  PickingId := StrToIntDef(request.contentfields.values['PickingId'],0);
  if PickingId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de línea no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  LineasPosicion := Trim(request.contentfields.values['LineasPosicion']);
  LineasPosicion := StringReplace(LineasPosicion, '{', '', [rfReplaceAll]);
  LineasPosicion := StringReplace(LineasPosicion, '}', '', [rfReplaceAll]);
  if LineasPosicion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"GUID de línea del pedido no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoArticulo := Trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );
  if CodigoArticulo=''then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  TratamientoPartidas := ARTICULO_TratamientoPartida ( Conn, CodigoEmpresa, CodigoArticulo );

  Partida := Trim(request.contentfields.values['Partida']);
  if (Partida='') and (TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de partida no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if (Partida<>'') and (not TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no requiere partida","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  // Llegim la ubicació on tenim les unitats preparades
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacion, EmpresaOrigen );

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );
  if CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de ubicación incorrecto en parámetros","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, EmpresaOrigen, CodigoUbicacion );
  if aUbicacion.CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de ubicación es incorrecto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Unidades := FS_StrToFloatDef ( Trim(request.contentfields.values['Cantidad']), 0 );
  if Unidades<0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Cantidad no especificada","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  UnidadMedida     := trim ( request.contentfields.values['UnidadMedida'] );
  UnidadMedidaBase := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );

  if UnidadMedidaBase='' then
    Unidadmedida := '';

  UnidadesBase := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                    Unidades, UnidadMedidaBase, UnidadMedida, FactorConversion );

  if UnidadesBase<0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades de medida son incorrectas","Data":[]}';
    Exit;
  end;

  Stock := SGA_ALMACEN_Stock ( Conn, EmpresaOrigen, aUbicacion.CodigoAlmacen, CodigoUbicacion, CodigoArticulo, Partida, UnidadMedida );
  if Unidades>Stock then begin
    if Stock=0 then
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No hay stock en la ubicación de expedición","Data":[]}'
    else
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La cantidad es superior al stock de la ubicación de expedición","Data":[]}';
    gaLogFile.Write ( Result + 'Unidades requeridas: ' + FloatToStr(Unidades) + ', Stock en ubicación: ' + FloatToStr(Stock) + ', Ubicación: ' + CodigoUbicacion, sIDCall, LOG_LEVEL_TRACE  );
    Response.Content := Result;
    Exit;
  end;

  sSQL := 'SELECT ' +
          '  Ejercicio ' +
          'FROM ' +
          '  FS_SGA_Picking_Preparaciones WITH (NOLOCK) ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion);
  Ejercicio := SQL_Execute ( Conn, sSQL );

  if Ejercicio=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Ejercicio de preparación no encontrado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  sSQL := 'SELECT ' +
          '  SUM(Cantidad) ' +
          'FROM ' +
          '  FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  (LineaPedidoCliente = ''00000000-0000-0000-0000-000000000000'' OR ' +
          '  LineaPedidoCliente = ''' + SQL_Str(LineasPosicion) + ''') AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
          '  UnidadMedida = ''' + SQL_Str(UnidadMedida) + ''' AND ' +
          '  Partida = ''' + SQL_Str(Partida) + ''' AND ' +
          '  IdPreparacion = ' + IntToStr(IdPreparacion);
  try
    UnidadesMaximas := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, LOG_LEVEL_EXCEPTION );
    end;
  end;

  if (Unidades>UnidadesMaximas) then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No hay unidades disponibles. Refrescar pantalla","Data":[]}';
    Response.Content := Result;
    Exit;
    (*
    sId := Format ( '%d.%d.%d', [IdPreparacion,IdentificadorExpedicion,CajaId]);
    Request.QueryFields.AddPair('IdentificadorExpedicion', sId );
    Request.ContentFields.AddPair('IdentificadorExpedicion', sId );
    WebModule1detalleExpedicionAction ( Sender, Request, Response, Handled );
    *)
  end;

  {$ENDREGION}

  {$REGION 'Guardar les dades'}

  try
    // // Conn.BeginTrans;
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","' + JSON_Str(E.Message) + '","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  bErr := FALSE;
  sMsg := '';

  if not bErr then try
    sNewGuid           := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sNewMovOrigen      := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sOrigenMovimiento  := 'S';
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if not bErr then try

    gaLogFile.Write ( 'Before SGA_Reservar_stock_pedidoExpedicion', sIDCall );

    sMsg := SGA_Reservar_stock_pedidoExpedicion (
      Conn,
      EmpresaOrigen,
      Ejercicio,
      CodigoArticulo,
      Partida,
      IdPreparacion,
      PickingId,
      LineasPosicion,
      Unidades,
      UnidadMedida,
      UnidadesBase,
      UnidadMedidaBase,
      IdentificadorExpedicion,
      CajaId
    );
    bErr := (sMsg<>'');

    if bErr then
      gaLogFile.Write ( 'After SGA_Reservar_stock_pedidoExpedicion: ERROR', sIDCall )
    else
      gaLogFile.Write ( 'After SGA_Reservar_stock_pedidoExpedicion: OK', sIDCall );

  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;

  end;

  sStr := '  Preparacion    : ' + IntToStr(IdPreparacion) + #13 + #10 +
          '                       CodigoArticulo : ' + CodigoArticulo + #13 + #10 +
          '                       Partida        : ' + Partida + #13 + #10 +
          '                       LineasPosicion : ' + LineasPosicion + #13 + #10 +
          '                       Cantidad       : ' + FloatToStr(Unidades) + #13 + #10;
  gaLogFile.Write ( sStr, sIDCall  );

  //----------------------------------------------
  //-- ACTUALITZEM LA TAULA DE PACKING LIST
  //---------------------------------------------
  if ( not bErr ) then begin

    sSQL := 'DELETE FROM FS_SGA_PACKINGLIST ' +
            'WHERE ' +
            '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
            '  preparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
            '  identificadorExpedicion = ' + IntToStr(IdentificadorExpedicion) + ' AND ' +
            '  pickingId = ' + IntToStr(pickingId) + ' AND ' +
            '  cajaId = ' + IntToStr(CajaId);
    try
      SQL_Execute_NoRes( Conn, sSQL );
    except
      on E:Exception do begin
        sMsg := 'ERROR DELETING PACKING LIST DETAIL: ' + e.Message;
        bErr := TRUE;
      end;
    end;

  end;

  if ( not bErr ) and ( Unidades>0 ) then begin

    sSQL := 'INSERT INTO FS_SGA_PACKINGLIST ( ' +
            '  CodigoEmpresa, preparacionId, pickingId, identificadorExpedicion, ' +
            '  cajaId, ejercicio, unidades, unidadmedida ) ' +
            'VALUES ( '+
            IntToStr(EmpresaOrigen) + ', ' +
            IntToStr(IdPreparacion) + ', ' +
            IntToStr(pickingId) + ', ' +
            IntToStr(IdentificadorExpedicion) + ', ' +
            IntToStr(CajaId) + ', ' +
            IntToStr(Ejercicio) + ', ' +
            SQL_FloatToStr(unidades) + ', ' +
            '''' + SQL_Str(UnidadMedida) + ''' )';
    try
      SQL_Execute_NoRes( Conn, sSQL );
    except
      on E:Exception do begin
        sMsg := 'ERROR INSERTING PACKING LIST DETAIL: ' + e.Message;
        bErr := TRUE;
      end;
    end;

  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end else begin
    // Conn.RollbackTrans;
  end;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(sMsg) + '","Data":[]}';
    gaLogFile.Write ( Result, sIDCall  );
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  sId := Format ( '%d.%d.%d', [IdPreparacion,IdentificadorExpedicion,CajaId]);
  Request.QueryFields.AddPair('IdentificadorExpedicion', sId );
  Request.ContentFields.AddPair('IdentificadorExpedicion', sId );

  //WebModule1expedicionDisponibleAction ( Sender, Request, Response, Handled );
  WebModule1detalleExpedicionAction ( Sender, Request, Response, Handled );

  //Result := '{"Result":"OK","Error":"","Data":[]}';
  //Response.Content := Result;

end;

procedure WebModule1actualizarRutaAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  contentfields: TStringList;
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  iTotalRegs, iNumRegs: Integer;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoAlmacen: String;
  CodigoUbicacionExpedicion: String;
  CodigoUbicacionExpedicionTemp: String;
  bResult: Boolean;
  sMsg: String;
  sIDCall: String;
  bIsBuilding: Boolean;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1actualizarRutaAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  CodigoAlmacen   := Trim(request.ContentFields.Values['CodigoAlmacen']);

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, EmpresaOrigen );

  if CodigoAlmacen='' then begin
    PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicionTemp, CodigoEmpresa );
    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacionExpedicionTemp );
  end;

  {$ENDREGION}

  {$REGION 'Refem la ruta de la preparació' }

  bResult := SGA_Check_PreparacionOrdenada ( gsPath, Conn, EmpresaOrigen, YY, IdPreparacion, CodigoAlmacen, CodigoUbicacionExpedicion, sMsg, TRUE, bIsBuilding );

  if bIsBuilding then
  begin
    Result := '{"Result":"ERROR","Error":"Se está calculando la ruta. Volver a intentar en unos segundos","TotalRecords":0,"NumPages":0,"NumRecords":0,"Data":[]}';
  end else begin
    if bResult then begin
      Result := '{"Result":"OK","Error":"","TotalRecords":1,"NumPages":1,"NumRecords":1,"Data":[]}';
    end else begin
      Result := '{"Result":"ERROR","Error":"' + JSON_Str(sMsg) + '","TotalRecords":1,"NumPages":1,"NumRecords":1,"Data":[]}';
    end;
  end;

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1articulosCajaAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  contentfields: TStringList;
  CodigoEmpresa: Integer;
  Result: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  sCodigoExpedicion: String;
  YY: WORD;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoAlmacen: String;
  sAndWhere: String;
  Partida: string;
  EmpresaOrigen: Integer;
  iNumPunts: Integer;
  t: TStringList;
  sIdExpedicion: String;
  sIdentificadorExpedicion: String;
  sCajaId: String;
  iIdExpedicion: Integer;
  iIdentificadorExpedicion: Integer;
  iCajaId: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1articulosCajaAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  sCodigoExpedicion := request.contentfields.values['CodigoExpedicion'];

  iNumPunts := Length(sCodigoExpedicion)-Length(StringReplace(sCodigoExpedicion, '.','', [rfReplaceAll, rfIgnoreCase]));
  if iNumPunts<>2 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de expedición no es correcto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  t := TStringList.Create;
  t.Delimiter := '.';
  t.DelimitedText := sCodigoExpedicion;
  if t.Count=3 then begin
    sIdExpedicion := t[0];
    sIdentificadorExpedicion := t[1];
    sCajaId := t[2];
  end;
  t.Free;

  iIdExpedicion := StrToIntDef ( sIdExpedicion, 0 );
  iIdentificadorExpedicion := StrToIntDef ( sIdentificadorExpedicion, 0 );
  iCajaId := StrToIntDef ( sCajaId, 0 );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_PACKINGLIST WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  preparacionId = ' + IntToStr(iIdExpedicion) + ' AND ' +
          '  identificadorExpedicion = ' + IntToStr(iIdentificadorExpedicion) + ' AND ' +
          '  cajaId = ' + IntToStr(iCajaId);

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fspl.unidades, fspl.cajaId, fspl.cajaRef, fspl.paletId, fspl.paletRef, ' +
          '  fspl.Fecha, fsppl.* ' +
          'FROM ' +
          '  FS_SGA_PACKINGLIST fspl WITH (NOLOCK) ' +
          'INNER JOIN ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'ON ' +
          '  fspl.preparacionId = fsppl.PreparacionId AND ' +
          '  fspl.pickingId = fsppl.PickingId ' +
          'WHERE ' +
          '  fspl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fspl.preparacionId = ' + IntToStr(iIdExpedicion) + ' AND ' +
          '  fspl.identificadorExpedicion = ' + IntToStr(iIdentificadorExpedicion) + ' AND ' +
          '  fspl.cajaId = ' + IntToStr(iCajaId) + ' ' +
          'ORDER BY ' +
          '  fsppl.CodigoArticulo ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ', ' +
      '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ', ' +
      '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '", ' +
      '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ', ' +
      '"OrdenLineaPedido":' + Q.FieldByName('OrdenLineaPedido').AsString + ', ' +
      '"LineasPosicion":"' + JSON_Str(Q.FieldByName('LineasPosicion').AsString) + '", ' +
      '"PreparacionId":' + Q.FieldByName('PreparacionId').AsString + ', ' +
      '"IdentificadorExpedicion":' + Q.FieldByName('IdentificadorExpedicion').AsString + ', ' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '", ' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '", ' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '", ' +
      '"CodigoCliente":"' + JSON_Str(Q.FieldByName('CodigoCliente').AsString) + '", ' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '", ' +
      '"Unidades":' + SQL_FloatToStr(Q.FieldByName('unidades').AsFloat) + ', ' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '", ' +
      '"CajaId":' + Q.FieldByName('cajaId').AsString + ', ' +
      '"CajaRef":"' + JSON_Str(Q.FieldByName('cajaRef').AsString) + '", ' +
      '"PaletId":' + Q.FieldByName('cajaId').AsString + ', ' +
      '"PaletRef":"' + JSON_Str(Q.FieldByName('paletRef').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1codigoArticuloAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1codigoArticuloAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoArticulo := request.contentfields.values['CodigoArticulo'];

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUbicacion := request.contentfields.values['CodigoUbicacion'];

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Almacenes ( ' + IntToStr(CodigoEmpresa) + ' ) ';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      FreeAndNil(Q);
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  CodigoEmpresa, CodigoAlmacen, Almacen, Domicilio, CodigoPostal, Municipio, Provincia ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Almacenes ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'ORDER BY ' +
          '  CodigoEmpresa, CodigoAlmacen ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      FreeAndNil(Q);
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ', ' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"Almacen":"' + JSON_Str(Q.FieldByName('Almacen').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '"' +
      '}';

    Q.Next;
  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1contenidoUbicacionInventarioAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  EmpresaOrigen: Integer;
  InventarioId: Integer;
  CodigoUbicacion: String;
  CodigoAlmacen: String;
  CodigoPasillo: String;
  CodigoEstanteria: String;
  Altura: String;
  Fondo: String;
  TipoUbicacion: String;
  Data, Articulos: String;
  Desglose: String;
  lJSonValue: TJSonValue;
  sMsg: String;
  bErr: Boolean;
  CodigoArticulo: String;
  Partida: String;
  UnidadMedida: String;
  UnidadesSaldo: Double;
  dFechaCaduca: TDate;
  FechaCaduca: String;
  CodigoUsuario: Integer;
  bAdded: Boolean;
  TipoUbicaciones: String;
  iNum: Integer;
  sIDCall: String;
  iTotalRegs, iNumRegs: Integer;
  listArticulos: String;
  iPages: Integer;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1updateInventarioUbicacionAction: ' + Request.RemoteAddr , sIDCall );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  InventarioId := StrToIntDef(request.contentfields.Values['InventarioId'], 0 );
  if InventarioId=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de inventario no especificado","Data":[]}';
    Exit;
  end;

  sSQL := 'SELECT ' +
          '  Inventario_TipoUbicaciones ' +
          'FROM ' +
          '  FS_SGA_Inventario WITH (NOLOCK) ' +
          'WHERE ' +
          '  Inventario_Id = ' + IntToStr(InventarioId);
  TipoUbicaciones := SQL_Execute ( Conn, sSQL );

  // Tipus d'ubicació (TODAS,PENDIENTES,VERIFICADAS)
  CodigoUbicacion := trim(request.contentfields.Values['CodigoUbicacion']);

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de ubicación incorrecto o no especificado","Data":[]}';
    Exit;
  end;

  // Verifiquem que la ubicació pertany a l'inventari
  if TipoUbicaciones<>'LIBRE' then begin

    sSQL := 'SELECT ' +
            '  COUNT(*) ' +
            'FROM ' +
            '  FS_SGA_Inventario_Detalle WITH (NOLOCK) ' +
            'WHERE ' +
            '  Inventario_Id = ' + IntToStr(InventarioId) + ' AND ' +
            '  CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + ''' ';
    iNum := SQL_Execute ( Conn, sSQL );
    if iNum=0 then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La ubicación no está incluida en este inventario","Data":[]}';
      Exit;
    end;

  end;

  // Verifiquem que la ubicació pertany al magatzem
  FS_SGA_UBICACION_Desglosar ( CodigoUbicacion, CodigoAlmacen, CodigoPasillo, CodigoEstanteria, Altura, Fondo );
  sSQL := 'SELECT ' +
          '  Inventario_CodigoAlmacen ' +
          'FROM ' +
          '  FS_SGA_Inventario WITH (NOLOCK) ' +
          'WHERE ' +
          '  Inventario_Id = ' + IntToStr(InventarioId);
  if CodigoAlmacen<>SQL_Execute(Conn,sSQL) then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La ubicación del almacén no está incluida en este inventario","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT DISTINCT ' +
          '  fsid.CodigoEmpresa, fsid.Inventario_Id, fsid.CodigoAlmacen, fsid.CodigoUbicacion, ' +
          '  fsid.Verificada, fsid.UsuarioId, fsu.NombreUsuario, MAX(fsid.FechaHoraValidacion) AS FechaHoraValidacion, ' +
          '  fstu.CodigoAlternativo ' +
          'FROM ' +
          '  FS_SGA_Inventario_Detalle fsid WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  FS_SGA_Usuarios fsu WITH (NOLOCK) ' +
          'ON ' +
          '  fsid.UsuarioId = fsu.CodigoUsuario ' +
          'LEFT JOIN ' +
          '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) fstu ' +
          'ON ' +
          '  fstu.CodigoUbicacion = fsid.CodigoUbicacion ' +
          'WHERE ' +
          '  fsid.Inventario_Id = ' + IntToStr(InventarioId) + ' AND ' +
          '  fstu.CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + ''' ' +
          'GROUP BY ' +
          '  fsid.CodigoEmpresa, fsid.Inventario_Id, fsid.CodigoAlmacen, fsid.CodigoUbicacion, ' +
          '  fsid.Verificada, fsid.UsuarioId, fsu.NombreUsuario,  fstu.CodigoAlternativo ' +
          'ORDER BY ' +
          '  fsid.CodigoUbicacion';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  Q2 := SQL_PrepareQuery ( Conn );

  iTotalRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"",';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    sSQL := 'SELECT DISTINCT ' +
            '  fsid.Inventario_UbicacionId, fsid.CodigoArticulo, art.DescripcionArticulo, fsid.Partida, ' +
            '  fsid.UnidadMedida, fsid.UnidadesSaldo, fsid.UsuarioId, fsid.FechaHoraValidacion, ' +
            '  fsu.NombreUsuario, fsid.FechaCaduca, fsta.UnidadesSaldo as UnidadesStock, ' +
            '  art.TratamientoPartidas ' +
            'FROM ' +
            '  FS_SGA_Inventario_Detalle fsid WITH (NOLOCK) ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
            'ON ' +
            '  fsid.CodigoArticulo = art.CodigoArticulo ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsta ' +
            'ON ' +
            '  fsid.CodigoUbicacion = fsta.CodigoUbicacion AND ' +
            '  fsid.UnidadMedida = fsta.UnidadMedida AND ' +
            '  fsid.CodigoArticulo = fsta.CodigoArticulo AND ' +
            '  fsid.Partida = fsta.Partida AND ' +
            '  fsta.Periodo = 99 ' +
            'LEFT JOIN ' +
            '  FS_SGA_Usuarios fsu WITH (NOLOCK) ' +
            'ON ' +
            '  fsid.UsuarioId = fsu.CodigoUsuario ' +
            'WHERE ' +
            '  fsid.Inventario_Id = ' + IntToStr(InventarioId) + ' AND ' +
            '  fsid.CodigoUbicacion = ''' + SQL_Str(Q.FieldByName('CodigoUbicacion').AsString) + ''' AND ' +
            '  fsid.CodigoArticulo <> '''' ' +
            'ORDER BY ' +
            '  CodigoArticulo, Partida';
    Q2.Close;
    Q2.SQL.Text := sSQL;
    try
      Q2.Open;
      iTotalRegs := Q2.RecordCount;
      Result := Result + '"NumRecords":' + IntToStr(iTotalRegs) + ',"Data":[';
      iNumRegs := 0;
    except
      on E:Exception do begin
        gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
        Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
        FreeAndNil(Q2);
        FreeAndNil(Q);
        Exit;
      end;
    end;

    listArticulos := '';

    while not Q2.EOF do begin

      if listArticulos<>'' then
        listArticulos := listArticulos + ',';

      listArticulos := listArticulos +
        '{' +
        '"Inventario_UbicacionId":"' + Q2.FieldByName('Inventario_UbicacionId').AsString + '",' +
        '"CodigoArticulo":"' + Q2.FieldByName('CodigoArticulo').AsString + '",' +
        '"DescripcionArticulo":"' + Q2.FieldByName('DescripcionArticulo').AsString + '",' +
        '"TratamientoPartidas":' + Q2.FieldByName('TratamientoPartidas').AsString + ',' +
        '"Partida":"' + Q2.FieldByName('Partida').AsString + '",' +
        '"UnidadMedida":"' + Q2.FieldByName('UnidadMedida').AsString + '",' +
        '"UnidadesStock":' + SQL_FloatToStr(Q2.FieldByName('UnidadesStock').AsFloat) + ',' +
        '"UnidadesSaldo":' + SQL_FloatToStr(Q2.FieldByName('UnidadesSaldo').AsFloat) + ',' +
        '"FechaCaduca":"' + FormatDateTime('dd/mm/yyyy', Q2.FieldByName('FechaCaduca').AsDateTime) + '"' +
        '}';

      Q2.Next;

    end;

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"Inventario_Id":' + Q.FieldByName('Inventario_Id').AsString + ',' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"CodigoUbicacion":"' + Q.FieldByName('CodigoUbicacion').AsString + '",' +
      '"CodigoUbicacionAlternativo":"' + Q.FieldByName('CodigoAlternativo').AsString + '",' +
      '"Verificada":' + SQL_BooleanToStr (Q.FieldByName('Verificada').AsBoolean) + ',' +
      '"UsuarioId":"' + Q.FieldByName('UsuarioId').AsString + '",' +
      '"NombreUsuario":"' + Q.FieldByName('NombreUsuario').AsString + '",' +
      '"FechaHoraValidacion":"' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Q.FieldByName('FechaHoraValidacion').AsDateTime) + '",' +
      '"Articulos":[' + listArticulos + ']' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q2.Close;
  FreeAndNil(Q2);

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1dashboardAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  EmpresaOrigen: Integer;
  iArticulosCaducados: Integer;
  iArticulosTotal: Integer;
  fPorcentajeCaducados: Double;
  CodigoAlmacen: String;
  iUbicacionesTotales: Integer;
  iUbicacionesVacias: Integer;
  fPorcentajeVacias: Double;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1dashboardAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := trim(request.contentfields.Values['CodigoAlmacen']);
  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  {$REGION '-- Caducidades'}
  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.fS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  FechaCaduca < GETDATE()';
  iArticulosCaducados := SQL_Execute ( Conn, sSQL );

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.fS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) ';
  iArticulosTotal := SQL_Execute ( Conn, sSQL );

  if iArticulosTotal=0 then
    fPorcentajeCaducados := 0
  else
    fPorcentajeCaducados := Round(10*(iArticulosCaducados/iArticulosTotal)*100) / 10;
  {$ENDREGION}

  {$REGION '-- Ubicaciones'}
  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ';
  if CodigoAlmacen<>'' then
    sSQL := sSQL + 'WHERE CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';
  iUbicacionesTotales := SQL_Execute ( Conn, sSQL );

  sSQL := 'SELECT ' +
          '  COUNT(fstu.CodigoUbicacion) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) fstu ' +
          'INNER JOIN ' +
          '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fstas ' +
          'ON ' +
          '  fstu.CodigoAlmacen = fstas.CodigoAlmacen AND ' +
          '  fstu.CodigoUbicacion = fstas.CodigoUbicacion ';
  if CodigoAlmacen<>'' then
    sSQL := sSQL + 'WHERE fstu.CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';

  iUbicacionesVacias := iUbicacionesTotales - SQL_Execute ( Conn, sSQL );

  if iUbicacionesTotales=0 then
    fPorcentajeVacias := 0
  else
    fPorcentajeVacias := Round(10*(iUbicacionesVacias/iUbicacionesTotales)*100) / 10;
  {$ENDREGION}

  {$REGION '-- Reubicaciones'}
  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Movimientos ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  Fecha = ' + SQL_DateToStr ( Date() ) + ' ';

  if CodigoAlmacen<>'' then
    sSQL := sSQL + 'WHERE CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';
  iUbicacionesTotales := SQL_Execute ( Conn, sSQL );

  sSQL := 'SELECT ' +
          '  COUNT(fstu.CodigoUbicacion) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) fstu ' +
          'INNER JOIN ' +
          '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fstas ' +
          'ON ' +
          '  fstu.CodigoAlmacen = fstas.CodigoAlmacen AND ' +
          '  fstu.CodigoUbicacion = fstas.CodigoUbicacion ';
  if CodigoAlmacen<>'' then
    sSQL := sSQL + 'WHERE fstu.CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';

  iUbicacionesVacias := iUbicacionesTotales - SQL_Execute ( Conn, sSQL );

  if iUbicacionesTotales=0 then
    fPorcentajeVacias := 0
  else
    fPorcentajeVacias := Round(10*(iUbicacionesVacias/iUbicacionesTotales)*100) / 10;
  {$ENDREGION}

  Result := '{"Result":"OK","Error":"","Data":{';
  Result := Result + '' +
    '"Caducidades":{' +
      '"TotalArticulos":' + IntToStr(iArticulosTotal) + ', ' +
      '"TotalCaducados":' + IntToStr(iArticulosCaducados) + ', ' +
      '"Porcentaje":' + SQL_FloatToStr(fPorcentajeCaducados) +
    '}' +
    '"UbicacionesVacias":{' +
      '"UbicacionesTotales":' + IntToStr(iUbicacionesTotales) + ', ' +
      '"UbicacionesVacias":' + IntToStr(iUbicacionesVacias) + ', ' +
      '"Porcentaje":' + SQL_FloatToStr(fPorcentajeVacias) +
    '}' +
  '}';

  Result := Result + '}';

  {$ENDREGION}

  Response.Content := Result;


end;

procedure WebModule1DefaultHandlerAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );
begin

  Response.Content := '{"Result":"OK","Error":"","Data":"SGA - Servidor web v0.1"}';

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ DETALLS D'UNA PREPARACIÓ                                              │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1desgloseRecepcionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  RecepcionId: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRechazos: String;
  RecepcionIdLinea: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1desgloseRecepcionAction: ' + Request.RemoteAddr , sIDCall );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  RecepcionId := StrToIntDef(request.contentfields.values['RecepcionId'],0);
  if RecepcionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  RecepcionIdLinea := StrToIntDef(request.contentfields.values['RecepcionIdLinea'],0);
  CodigoArticulo   := Trim(request.contentfields.values['CodigoArticulo']);
  CodigoUsuario    := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcion,         CodigoUbicacionRecepcion, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcionRechazos, CodigoUbicacionRechazos, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Recepciones_Lineas_Detalle fsrld WITH (NOLOCK) ' +
          'INNER JOIN ' +
          '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) stu ' +
          'ON ' +
          '  stu.CodigoUbicacion = fsrld.CodigoUbicacion ' +
          'LEFT JOIN ' +
          '  FS_SGA_TABLE_Incidencias ( ' + IntToStr(EmpresaOrigen) + ', ''R'' ) fsi ' +
          'ON ' +
          '  fsi.IdIncidencia = fsrld.AnomaliaId ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  art.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' ' +
          'WHERE ' +
          '  fsrld.RecepcionIdLinea = ' + IntToStr(RecepcionIdLinea) + ' AND ' +
          '  fsrld.RecepcionId = ' + IntToStr(RecepcionId);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
            '  fsrld.*, stu.CodigoAlternativo, fsi.NombreIncidencia, fsrld.Unidades * art.PesoBrutoUnitario_ as PesoBruto, ' +
            '  fsrld.Unidades * art.PesoNetoUnitario_ as PesoNeto, fsrld.Unidades * art.VolumenUnitario_ as Volumen ' +
            'FROM ' +
            '  FS_SGA_Recepciones_Lineas_Detalle fsrld WITH (NOLOCK) ' +
            'INNER JOIN ' +
            '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) stu ' +
            'ON ' +
            '  stu.CodigoUbicacion = fsrld.CodigoUbicacion ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_Incidencias ( ' + IntToStr(EmpresaOrigen) + ', ''R'' ) fsi ' +
            'ON ' +
            '  fsi.IdIncidencia = fsrld.AnomaliaId ' +
            'LEFT JOIN ' +
            '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
            'ON ' +
            '  art.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' ' +
            'WHERE ' +
            '  fsrld.RecepcionIdLinea = ' + IntToStr(RecepcionIdLinea) + ' AND ' +
            '  fsrld.RecepcionId = ' + IntToStr(RecepcionId) +
            'ORDER BY ' +
            '  fsrld.RecepcionIdLineaDetalle';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
                       '"RecepcionId":"' + Q.FieldByName('RecepcionId').AsString + '",' +
                       '"RecepcionIdLinea":"' + Q.FieldByName('RecepcionIdLinea').AsString + '",' +
                       '"RecepcionIdLineaDetalle":"' + Q.FieldByName('RecepcionIdLineaDetalle').AsString + '",' +
                       '"CodigoAlmacen":"' + Q.FieldByName('CodigoAlmacen').AsString + '",' +
                       '"CodigoUbicacion":"' + Q.FieldByName('CodigoUbicacion').AsString + '",' +
                       '"CodigoUbicacionAlternativo":"' + Q.FieldByName('CodigoAlternativo').AsString + '",' +
                       '"CodigoAlmacenRechazos":"' + Q.FieldByName('CodigoAlmacenRechazos').AsString + '",' +
                       '"CodigoUbicacionRechazos":"' + Q.FieldByName('CodigoUbicacionRechazos').AsString + '",' +
                       '"Caja":"' + JSON_Str(Q.FieldByName('Caja').AsString) + '",' +
                       '"Palet":"' + JSON_Str(Q.FieldByName('Palet').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"FechaCaducidad":"' + Q.FieldByName('FechaCaducidad').AsString + '",' +
                       '"Verificacion":"' + JSON_Str(Q.FieldByName('Verificacion').AsString) + '",' +
                       '"IdIncidencia":"' + JSON_Str(Q.FieldByName('AnomaliaId').AsString) + '",' +
                       '"NombreIncidencia":"' + JSON_Str(Q.FieldByName('NombreIncidencia').AsString) + '",' +
                       '"Precio":' + SQL_FloatToStr(Q.FieldByName('Precio').AsFloat) + ',' +
                       '"UnidadesEntrada":' + SQL_FloatToStr(Q.FieldByName('UnidadesEntrada').AsFloat) + ',' +
                       '"CantidadErrorEntrada":' + SQL_FloatToStr(Q.FieldByName('CantidadErrorEntrada').AsFloat) + ',' +
                       '"TotalEntrada":' + SQL_FloatToStr(Q.FieldByName('TotalEntrada').AsFloat) +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1detalleDevolucionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  DevolucionId: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionDevolucion: String;
  CodigoUbicacionDevolucionRechazos: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detalleDevolucionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  DevolucionId := StrToIntDef(request.contentfields.values['DevolucionId'],0);
  if DevolucionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de devolución no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );
  OrdenarPor    := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden     := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy      := '';

  if OrdenarPor='PEDIDO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsdl.EjercicioPedido DESC, fsdl.SeriePedido DESC, fsdl.NumeroPedido DESC, fsdl.OrdenLineaPedido ';
    end else begin
      sOrderBy := 'fsdl.EjercicioPedido, fsdl.SeriePedido, fsdl.NumeroPedido, fsdl.OrdenLineaPedido ';
    end;
  end else if OrdenarPor='ESTADO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsdl.UdSaldo DESC ';
    end else begin
      sOrderBy := 'fsdl.UdSaldo ';
    end;
  end else if OrdenarPor='ARTICULO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsdl.CodigoArticulo DESC, fsdl.Partida DESC ';
    end else begin
      sOrderBy := 'fsdl.CodigoArticulo, fsdl.Partida ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsdl.DevolucionIdLinea DESC ';
    end else begin
      sOrderBy := 'fsdl.DevolucionIdLinea ';
    end;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionDevolucion,         CodigoUbicacionDevolucion, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionDevolucionRechazos, CodigoUbicacionDevolucionRechazos, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Devoluciones_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  DevolucionId = ' + IntToStr(DevolucionId);

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fsdl.*, art.TratamientoPartidas, art.CodigoAlternativo AS CodigoArticuloAlternativo ' +
          'FROM ' +
          '  FS_SGA_Devoluciones_Lineas fsdl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  fsdl.CodigoArticulo = art.CodigoArticulo ' +
          'WHERE ' +
          '  fsdl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsdl.DevolucionId = ' + IntToStr(DevolucionId) + ' ' +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  Q2 := SQL_PrepareQuery ( Conn );

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    sSQL := 'SELECT ' +
            '  fsdld.*, stu.CodigoAlternativo AS CodigoUbicacionAlternativo, fsi.NombreIncidencia, fsdld.Unidades * art.PesoBrutoUnitario_ as PesoBruto, ' +
            '   fsdld.Unidades * art.PesoNetoUnitario_ as PesoNeto, fsdld.Unidades * art.VolumenUnitario_ as Volumen ' +
            'FROM ' +
            '  FS_SGA_Devoluciones_Lineas_Detalle fsdld WITH (NOLOCK) ' +
            'INNER JOIN ' +
            '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) stu ' +
            'ON ' +
            '  stu.CodigoUbicacion = fsdld.CodigoUbicacion ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_Incidencias ( ' + IntToStr(EmpresaOrigen) + ', ''R'' ) fsi ' +
            'ON ' +
            '  fsi.IdIncidencia = fsdld.AnomaliaId ' +
            'LEFT JOIN ' +
            '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
            'ON ' +
            '  art.CodigoArticulo = ''' + SQL_Str(Q.FieldByName('CodigoArticulo').AsString) + ''' ' +
            'WHERE ' +
            '  fsdld.DevolucionIdLinea = ' + IntToStr(Q.FieldByName('DevolucionIdLinea').AsInteger) + ' AND ' +
            '  fsdld.DevolucionId = ' + IntToStr(DevolucionId) +
            'ORDER BY ' +
            '  fsdld.DevolucionIdLineaDetalle';

    Q2.Close;
    Q2.SQL.Text := sSQL;
    try
      Q2.Open;
    except
      on E:Exception do begin
        gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
        Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
        FreeAndNil(Q);
        FreeAndNil(Q2);
        Exit;
      end;
    end;

    sDesglose := '';

    while not Q2.EOF do begin

      if sDesglose<>'' then
        sDesglose := sDesglose + ',';

      sDesglose := sDesglose + '{' +
                               '"DevolucionId":"' + Q2.FieldByName('DevolucionId').AsString + '",' +
                               '"DevolucionIdLinea":"' + Q2.FieldByName('DevolucionIdLinea').AsString + '",' +
                               '"DevolucionIdLineaDetalle":"' + Q2.FieldByName('DevolucionIdLineaDetalle').AsString + '",' +
                               '"CodigoAlmacen":"' + Q2.FieldByName('CodigoAlmacen').AsString + '",' +
                               '"CodigoUbicacion":"' + Q2.FieldByName('CodigoUbicacion').AsString + '",' +
                               '"CodigoUbicacionAlternativo":"' + Q2.FieldByName('CodigoUbicacionAlternativo').AsString + '",' +
                               '"CodigoAlmacenRechazos":"' + Q2.FieldByName('CodigoAlmacenRechazos').AsString + '",' +
                               '"CodigoUbicacionRechazos":"' + Q2.FieldByName('CodigoUbicacionRechazos').AsString + '",' +
                               '"Caja":"' + JSON_Str(Q2.FieldByName('Caja').AsString) + '",' +
                               '"Palet":"' + JSON_Str(Q2.FieldByName('Palet').AsString) + '",' +
                               '"Partida":"' + JSON_Str(Q2.FieldByName('Partida').AsString) + '",' +
                               '"FechaCaducidad":"' + Q2.FieldByName('FechaCaducidad').AsString + '",' +
                               '"Verificacion":"' + JSON_Str(Q2.FieldByName('Verificacion').AsString) + '",' +
                               '"IdIncidencia":"' + JSON_Str(Q2.FieldByName('AnomaliaId').AsString) + '",' +
                               '"NombreIncidencia":"' + JSON_Str(Q2.FieldByName('NombreIncidencia').AsString) + '",' +
                               '"Precio":' + SQL_FloatToStr(Q2.FieldByName('Precio').AsFloat) + ',' +
                               '"UnidadesEntrada":' + SQL_FloatToStr(abs(Q2.FieldByName('UnidadesEntrada').AsFloat)) + ',' +
                               '"CantidadErrorEntrada":' + SQL_FloatToStr(abs(Q2.FieldByName('CantidadErrorEntrada').AsFloat)) + ',' +
                               '"TotalEntrada":' + SQL_FloatToStr(abs(Q2.FieldByName('TotalEntrada').AsFloat)) +
                               '}';

      Q2.Next;

    end;

    Q2.Close;

    sDesglose := sDesglose + '';

    Result := Result + '{' +
                       '"DevolucionId":"' + Q.FieldByName('DevolucionId').AsString + '",' +
                       '"DevolucionIdLinea":"' + Q.FieldByName('DevolucionIdLinea').AsString + '",' +
                       '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
                       '"EjercicioPedido":"' + Q.FieldByName('EjercicioPedido').AsString + '",' +
                       '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
                       '"NumeroPedido":"' + Q.FieldByName('NumeroPedido').AsString + '",' +
                       '"OrdenLineaPedido":"' + Q.FieldByName('OrdenLineaPedido').AsString + '",' +
                       '"LineasPosicion":"' + Q.FieldByName('LineasPosicion').AsString + '",' +
                       '"UdPedidas":"' + SQL_FloatToStr(abs(Q.FieldByName('UdPedidas').AsFloat)) + '",' +
                       '"UdRecibidas":"' + SQL_FloatToStr(abs(Q.FieldByName('UdRecibidas').AsFloat)) + '",' +
                       '"UdSaldo":"' + SQL_FloatToStr(abs(Q.FieldByName('UdSaldo').AsFloat)) + '",' +
                       '"Precio":"' + SQL_FloatToStr(Q.FieldByName('Precio').AsFloat) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoArticuloAlternativo').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
                       '"CodigoCliente":"' + JSON_Str(Q.FieldByName('CodigoCliente').AsString) + '",' +
                       '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
                       '"IdAlbaranCli":"' + JSON_Str(Q.FieldByName('IdAlbaranCli').AsString) + '",' +
                       '"Albaran":"' + JSON_Str(Q.FieldByName('Albaran').AsString) + '",' +
                       '"FechaRecepcion":"' + Q.FieldByName('FechaRecepcion').AsString + '",' +
                       '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida1_').AsString) + '",' +
                       '"Desglose":[' + sDesglose + ']' +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q2.Close;
  FreeAndNil(Q2);
  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1detalleExpedicion2Action(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoArticulo: String;
  sFiltro: string;
  IdentificadorExp: string;
  t: TStringList;
  EjercicioPedido: Integer;
  NumeroPedido: Integer;
  SeriePedido: string;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detalleExpedicion2Action: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  sFiltro := '';

  CodigoArticulo   := Trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo<>'' then begin
    sFiltro := sFiltro + 'AND fsppl.CodigoArticulo=''' + SQL_Str(CodigoArticulo) + ''' ';
  end;

  IdentificadorExp := Trim(request.contentfields.values['IdentificadorExpedicion']);
  if IdentificadorExp<>'' then begin
    t := TStringList.Create;
    t.Delimiter := '.';
    t.DelimitedText := IdentificadorExp;
    if t.Count=2 then begin
      if StrToIntDef(t[0],0)=IdPreparacion then begin
        sFiltro := sFiltro + 'AND fsppl.IdentificadorExpedicion=' + SQL_Str(t[1]) + ' ';
        FreeAndNil(t);
      end else begin
        FreeAndNil(t);
        Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de expedición no válido","Data":[]}';
        Response.Content := Result;
        Exit;
      end;
    end else begin
      FreeAndNil(t);
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de expedición no válido","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  EjercicioPedido := StrToIntDef(request.contentfields.values['EjercicioPedido'],0);
  if (EjercicioPedido<>0) then begin
    sFiltro := sFiltro + 'AND fsppl.EjercicioPedido=' + IntToStr(EjercicioPedido) + ' ';
  end;

  NumeroPedido := StrToIntDef(request.contentfields.values['NumeroPedido'],0);
  if (NumeroPedido<>0) then begin
    sFiltro := sFiltro + 'AND fsppl.NumeroPedido=' + IntToStr(NumeroPedido) + ' ';
  end;

  if request.ContentFields.IndexOfName('SeriePedido')>=0 then begin
    SeriePedido := Trim(request.contentfields.values['SeriePedido']);
    sFiltro := sFiltro + 'AND fsppl.SeriePedido=''' + SQL_Str(SeriePedido) + ''' ';
  end;

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='ARTICULO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsppl.CodigoArticulo DESC, fsppl.Partida DESC ';
    end else begin
      sOrderBy := 'fsppl.CodigoArticulo, fsppl.Partida ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsppl.CodigoArticulo DESC, fsppl.Partida DESC ';
    end else begin
      sOrderBy := 'fsppl.CodigoArticulo DESC, fsppl.Partida ';
    end;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'WHERE ' +
          '  fsppl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsppl.PreparacionId = ' + IntToStr(IdPreparacion) + ' ' +
          sFiltro;

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      FreeAndNil(Q);
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  sSQL := 'SELECT ' +
          '  fsppl.EjercicioPedido, fsppl.SeriePedido, fsppl.NumeroPedido, fsppl.PreparacionId, fsppl.PickingId, ' +
          '  fsppl.CodigoEmpresa, fsppl.LineasPosicion, fsppl.CodigoArticulo, fsppl.UnidadMedida, fsppl.DescripcionArticulo, fsppl.CodigoAlmacen, fsppl.UnidadMedida, Partida, ' +
          '  art.TratamientoPartidas, fsppl.UdNecesarias, fsppl.UdSaldo, fsppl.UdRetiradas, fsppl.UdExpedidas, fsppl.IdentificadorExpedicion, ' +
          '  art.CodigoAlternativo AS CodigoArticuloAlternativo ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  fsppl.CodigoArticulo = art.CodigoArticulo ' +
          'WHERE ' +
          '  fsppl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsppl.PreparacionId = ' + IntToStr(IdPreparacion) + ' ' +
          sFiltro +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
                       '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
                       '"PreparacionId":"' + Q.FieldByName('PreparacionId').AsString + '",' +
                       '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
                       '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
                       '"PickingId":' + Q.FieldByName('PickingId').AsString + ',' +
                       '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
                       '"LineasPosicion":"' + JSON_Str(Q.FieldByName('LineasPosicion').AsString) + '",' +
                       '"IdentificadorExpedicion":"' + Q.FieldByName('IdentificadorExpedicion').AsString + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoArticuloAlternativo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
                       '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
                       '"UdNecesarias":' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + ',' +
                       '"UdRetiradas":' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + ',' +
                       '"UdExpedidas":' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) + ',' +
                       '"UdSaldo":' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1detalleExpedicionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoArticulo: String;
  sFiltro: string;
  IdentificadorExp: string;
  t: TStringList;
  TratamientoPartidas: Boolean;
  Partida: String;
  bHasData: Boolean;
  fUnidadesExpedidas: Double;
  sIDCall: String;
  sFilterPartida: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detalleExpedicionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  sFiltro := '';

  CodigoArticulo := Trim(request.contentfields.values['CodigoArticulo']);
  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );
  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo inválido","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  TratamientoPartidas := ARTICULO_TratamientoPartida ( Conn, CodigoEmpresa, CodigoArticulo );
  Partida := Trim(request.contentfields.values['Partida']);

  if TratamientoPartidas then
  begin
    sFilterPartida := 'AND Preparacion.PartidaSel = ''' + SQL_Str(Partida) + ''' ';
  end else begin
    sFilterPartida := '';
  end;

  (*
  if TratamientoPartidas and (Partida='') then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El artículo tiene tratamiento de partidas pero no se ha especificado ninguna","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if (not TratamientoPartidas) and (Partida<>'') then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El artículo no tiene tratamiento de partidas pero se ha especificado una","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  *)

  IdentificadorExp := Trim(request.contentfields.values['IdentificadorExpedicion']);
  if IdentificadorExp<>'' then begin
    t := TStringList.Create;
    t.Delimiter := '.';
    t.DelimitedText := IdentificadorExp;
    if (t.Count>=2) then begin
      if StrToIntDef(t[0],0)=IdPreparacion then begin
        sFiltro := sFiltro + 'AND fsppl.IdentificadorExpedicion=' + SQL_Str(t[1]) + ' ';
        FreeAndNil(t);
      end else begin
        FreeAndNil(t);
        Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de expedición no válido","Data":[]}';
        Response.Content := Result;
        Exit;
      end;
    end else begin
      FreeAndNil(t);
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de expedición no válido","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  sSQL := 'SELECT ' +
          '  fsppl.EjercicioPedido, fsppl.SeriePedido, fsppl.NumeroPedido, fsppl.PreparacionId, fsppl.PickingId, ' +
          '  fsppl.CodigoEmpresa, fsppl.LineasPosicion, fsppl.CodigoArticulo, fsppl.UnidadMedida, fsppl.DescripcionArticulo, fsppl.CodigoAlmacen, fsppl.UnidadMedida, Partida, ' +
          '  ISNULL(PartidaSel,'''') AS PartidaSel, art.TratamientoPartidas, fsppl.UdNecesarias, fsppl.UdSaldo, fsppl.UdRetiradas, fsppl.UdExpedidas, fsppl.IdentificadorExpedicion, ' +
          '  art.CodigoAlternativo AS CodigoArticuloAlternativo, fsppl.RazonSocial, fsppl.CodigoCliente, ' +
          '  MIN (ISNULL(Preparacion.CantidadPreparada,0)) AS CantidadPendienteExpedir ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'LEFT JOIN  ' +
          '( SELECT  ' +
          '    IdPreparacion, CodigoArticulo,	Partida AS PartidaSel, SUM(Cantidad) AS CantidadPreparada  ' +
          '  FROM  ' +
          '    dbo.FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          '  WHERE  ' +
          '    LineaPedidoCliente = ''00000000-0000-0000-0000-000000000000''  ' +
          '  GROUP BY  ' +
          '    IdPreparacion, CodigoArticulo, Partida ' +
          ') as Preparacion  ' +
          'ON   ' +
          '  Preparacion.CodigoArticulo = fsppl.CodigoArticulo AND  ' +
          '  Preparacion.IdPreparacion = fsppl.PreparacionId  ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  fsppl.CodigoArticulo = art.CodigoArticulo ' +
          'WHERE ' +
          '  fsppl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsppl.PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  fsppl.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' ' +
          sFilterPartida +
          'GROUP BY ' +
          '  fsppl.EjercicioPedido, fsppl.SeriePedido, fsppl.NumeroPedido, fsppl.PreparacionId, fsppl.PickingId, ' +
          '  fsppl.CodigoEmpresa, fsppl.LineasPosicion, fsppl.CodigoArticulo, fsppl.UnidadMedida, Partida, PartidaSel, ' +
          '  fsppl.DescripcionArticulo, fsppl.CodigoAlmacen, ' +
          '  art.TratamientoPartidas, fsppl.UdNecesarias, fsppl.UdSaldo, fsppl.UdRetiradas, fsppl.UdExpedidas, fsppl.IdentificadorExpedicion, ' +
          '  art.CodigoAlternativo, fsppl.RazonSocial, fsppl.CodigoCliente ' +
          'ORDER BY ' +
          '  IdentificadorExpedicion';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":1,"NumPages":1,"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;
  bHasData := FALSE;

  if not Q.EOF then begin
    bHasData := TRUE;
    Result := Result + '{' +
                       '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
                       '"PreparacionId":"' + Q.FieldByName('PreparacionId').AsString + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoArticuloAlternativo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
                       '"Detalle":[';
  end;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    sSQL := 'SELECT ' +
            '  SUM(Cantidad) ' +
            'FROM ' +
            '  FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
            'WHERE ' +
            '  IdPreparacion = ' + IntToStr(IdPreparacion) + ' AND ' +
            '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
            '  Partida = ''' + SQL_Str(Partida) + ''' AND ' +
            '  LineaPedidoCliente = ''' + SQL_Str(Q.FieldByName('LineasPosicion').AsString) + ''' ';
    fUnidadesExpedidas := SQL_Execute ( Conn, sSQL );

    Result := Result + '{' +
                       '"PickingId":' + Q.FieldByName('PickingId').AsString + ',' +
                       '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
                       '"CodigoCliente":"' + JSON_Str(Q.FieldByName('CodigoCliente').AsString) + '",' +
                       '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
                       '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
                       '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
                       '"LineasPosicion":"' + JSON_Str(Q.FieldByName('LineasPosicion').AsString) + '",' +
                       '"IdentificadorExpedicion":"' + Q.FieldByName('IdentificadorExpedicion').AsString + '",' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +

                       '"UnidadesNecesariasTotales":' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + ',' +
                       '"UnidadesRetiradasTotales":' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + ',' +
                       '"UnidadesExpedidasTotales":' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) + ',' +
                       '"UnidadesPendientesPreparar":' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat - Q.FieldByName('UdRetiradas').AsFloat) + ',' +
                       '"UnidadesPendientesExpedir":' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat - Q.FieldByName('UdExpedidas').AsFloat) + ',' +

                       '"UnidadesRetiradasPartida":' + SQL_FloatToStr(fUnidadesExpedidas + Q.FieldByName('CantidadPendienteExpedir').AsFloat) + ',' +
                       '"UnidadesExpedidasPartida":' + SQL_FloatToStr(fUnidadesExpedidas) + ',' +

                       '"UdNecesarias":' + SQL_FloatToStr(fUnidadesExpedidas + Q.FieldByName('CantidadPendienteExpedir').AsFloat) + ',' +
                       '"UdNecesariasTotales":' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + ',' +
                       '"UdRetiradas":' + SQL_FloatToStr(Q.FieldByName('CantidadPendienteExpedir').AsFloat) + ',' +
                       '"UdRetiradas2":' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + ',' +
                       '"UdSaldo":' + SQL_FloatToStr(Q.FieldByName('UdSaldo').AsFloat) + ',' +
                       '"UdExpedidasLinea":' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) + ',' +
                       '"UdExpedidas":' + SQL_FloatToStr(fUnidadesExpedidas) +
                       '}';

    Q.Next;

  end;

  if bHasData then begin
    Result := Result + ']}';
  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1detallePreparacionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detallePreparacionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='ARTICULO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo, Partida ';
    end;
  end else if OrdenarPor='CODIGOUBICACION' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacion DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacion ';
    end;
  end else if OrdenarPor='CODIGOUBICACIONALTERNATIVO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacionAlternativo DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacionAlternativo ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo DESC, Partida ';
    end;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  sSQL := 'SELECT ' +
          '  fsppl.PreparacionId, fsppl.CodigoEmpresa, fsppl.CodigoArticulo, fsppl.UnidadMedida, art.DescripcionArticulo, fsppl.CodigoAlmacen, fsppl.UnidadMedida, Partida, ' +
          '  art.TratamientoPartidas, SUM(fsppl.UdNecesarias) as UdNecesarias, MIN(fsppl.UdRetiradas) as UdRetiradas, ' +
          '  SUM(fsppl.UdExpedidas) as UdExpedidas, ' +
          '  ( ' +
          '    SELECT ' +
          '      ISNULL(SUM(UnidadesSaldo),0) ' +
          '    FROM ' +
          '      dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          '    WHERE ' +
          '      CodigoAlmacen = fsppl.CodigoAlmacen AND ' +
          '      CodigoArticulo = fsppl.CodigoArticulo AND ' +
          '      Partida = fsppl.Partida AND ' +
          '      Periodo = 99 AND ' +
          '      Ejercicio = ' + IntToStr(YY) + ' AND ' +
          '      UnidadMedida = fsppl.UnidadMedida ' +
          '  ) AS UnidadesStock, ' +
          '  ( ' +
          '    SELECT TOP 1 ' +
          '      CodigoUbicacion ' +
          '    FROM ' +
          '      FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          '    WHERE ' +
          '      CodigoAlmacen = fsppl.CodigoAlmacen AND ' +
          '      CodigoArticulo = fsppl.CodigoArticulo AND ' +
//          '      Partida = fsppl.Partida AND ' +
          '      Periodo = 99 AND ' +
          '      Ejercicio = ' + IntToStr(YY) + ' AND ' +
          '      UnidadMedida = fsppl.UnidadMedida AND ' +
          '      UnidadesSaldo > 0 ' +
          '    ORDER BY ' +
          '      FechaCaduca DESC, Partida ' +
          '    ) AS CodigoUbicacion, ' +
          '  ( ' +
          '    SELECT TOP 1 ' +
          '      CodigoUbicacionAlternativo ' +
          '    FROM ' +
          '      FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          '    WHERE ' +
          '      CodigoAlmacen = fsppl.CodigoAlmacen AND ' +
          '      CodigoArticulo = fsppl.CodigoArticulo AND ' +
//          '      Partida = fsppl.Partida AND ' +
          '      Periodo = 99 AND ' +
          '      Ejercicio = ' + IntToStr(YY) + ' AND ' +
          '      UnidadMedida = fsppl.UnidadMedida AND ' +
          '      UnidadesSaldo > 0 ' +
          '    ORDER BY ' +
          '      FechaCaduca DESC, Partida ' +
          '    ) AS CodigoUbicacionAlternativo ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  fsppl.CodigoArticulo = art.CodigoArticulo ' +
          'WHERE ' +
          '  fsppl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsppl.PreparacionId = ' + IntToStr(IdPreparacion) + ' ' +
          'GROUP BY ' +
          '  fsppl.PreparacionId, fsppl.CodigoEmpresa, fsppl.CodigoArticulo, fsppl.UnidadMedida, art.DescripcionArticulo, fsppl.CodigoAlmacen, fsppl.UnidadMedida, Partida, art.TratamientoPartidas ' +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
                       '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
                       '"UdNecesarias":"' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + '",' +
                       '"UdRetiradas":"' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + '",' +
                       '"UdExpedidas":"' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"PreparacionId":"' + Q.FieldByName('PreparacionId').AsString + '",' +
                       '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                       '"UnidadesStock":"' + SQL_FloatToStr(Q.FieldByName('UnidadesStock').AsFloat) + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
                       '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
                       '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoUbicacionAlternativo').AsString) + '"' +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1detallePreparacionOrdenOldAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  iTotalStock: Double;
  Result: String;
  sSQL: String;
  sSQL1: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  Indice: Integer;
  MostrarPartidas: Integer;
  sTable: string;
  CodigoAlmacen: String;
  CodigoArticulo: String;
  sUbicaciones: String;
  Partida: String;
  bError: Boolean;
  Pendientes: Integer;
  SoloConStock: Integer;
  Direccion: Integer;
  CodigoUbicacionExpedicion: String;
  sIDCall: String;
  sMsg: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detallePreparacionOrdenAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  sSQL1           := Trim(request.ContentFields.Values['SQL']);
  Indice          := StrToIntDef(request.contentfields.values['Indice'],0);
  MostrarPartidas := 1; //StrToIntDef(request.contentfields.values['MostrarPartidas'],0);
  Pendientes      := StrToIntDef(request.contentfields.values['Pendientes'],0);
  SoloConStock    := StrToIntDef(request.contentfields.values['SoloConStock'],0);
  Direccion       := StrToIntDef(request.contentfields.values['Direccion'],1);
  CodigoAlmacen   := Trim(request.ContentFields.Values['CodigoAlmacen']);

  // Temporal
  //if CodigoAlmacen='' then
    CodigoAlmacen := 'ALM1';

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';
  sOperation := '>';

  if Direccion=0 then begin
    sOperation := '=';
    Direccion := 1;
  end else begin
    if Direccion<0 then begin
      sOperation := '<';
    end;
  end;

  if OrdenarPor='ARTICULO' then begin
    if Direccion<0 then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo, Partida ';
    end;
  end else if OrdenarPor='CODIGOUBICACION' then begin
    if Direccion<0 then begin
      sOrderBy := 'CodigoUbicacion DESC, rn DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacion, rn ';
    end;
  end else if OrdenarPor='CODIGOUBICACIONALTERNATIVO' then begin
    if Direccion<0 then begin
      sOrderBy := 'CodigoUbicacion DESC, rn DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacion, rn ';
    end;
  end else begin
    if Direccion<0 then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo DESC, Partida ';
    end;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, EmpresaOrigen );

  if CodigoAlmacen='' then begin
    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacionExpedicion );
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  if MostrarPartidas=0 then sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo'
  else sTable := 'FS_SGA_TABLE_PreparacionDetallesPartidaPeriodo';

  sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo';

  sSQL := 'SELECT TOP ' + IntToStr(Abs(Direccion)) + ' * ' +
          'FROM ( ' +
          '  SELECT ' +
          '    ROW_NUMBER() OVER ( ORDER BY CASE WHEN CodigoUbicacion IN ( ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ) OR CodigoUbicacion IS NULL THEN ''zzz'' ELSE CodigoUbicacion END ) AS rn, * ' +
          '  FROM ' +
          sTable + ' ( ' + IntToStr(EmpresaOrigen) + ', ' + IntToStr(IdPreparacion) + ', ''' + SQL_Str(CodigoUbicacionExpedicion) + ''', ' + IntToStr(YY) + ', ''' + SQL_Str(CodigoAlmacen) + ''' ) ' +
          '  ) q ' +
          'WHERE '+
          '  rn ' + sOperation + ' ' + IntToStr(Indice) + '  AND ' +
          '  CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ) ';

  if Pendientes=1 then
     sSQL := sSQL + 'AND UdNecesarias > Udretiradas ';

  if SoloConStock=1 then
     sSQL := sSQL + 'AND CodigoUbicacion IS NOT NULL ';

  sSQL := sSQL + 'ORDER BY ' + sOrderBy;

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"SQL1":"' + JSON_Str(sSQL1) + '","SQL":"' + JSON_Str(sSQL) + '","Result":"OK","Error":"","TotalRecords":1,"NumPages":1,"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  if not Q.Eof then begin

    Q.Last;

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    CodigoAlmacen  := FS_SGA_CodigoAlmacen ( Q.FieldByName('CodigoUbicacion').AsString );
    CodigoArticulo := Q.FieldByName('CodigoArticulo').AsString;
    Partida        := Q.FieldByName('Partida').AsString;

    sUbicaciones := FS_SGA_ObtenerUbicaciones (
      Conn,
      EmpresaOrigen,
      CodigoArticulo,
      Partida,
      CodigoAlmacen,
      MostrarPartidas,
      bError,
      iTotalStock );

    if not bError then begin

      Result := Result + '{' +
                         '"Indice":"' + Q.FieldByName('rn').AsString + '",' +
                         '"CodigoEmpresa":"' + IntToStr(CodigoEmpresa) + '",' +
                         '"UdNecesarias":"' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + '",' +
                         '"UdRetiradas":"' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + '",' +
                         '"UdExpedidas":"' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) + '",' +
                         '"CodigoArticulo":"' + JSON_Str(CodigoArticulo) + '",' +
                         '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoArticuloAlternativo').AsString) + '",' +
                         '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                         '"Partida":"' + JSON_Str(Partida) + '",' +
                         '"CodigoAlmacen":"' + JSON_Str(CodigoAlmacen) + '",' +
                         '"PreparacionId":"' + Q.FieldByName('PreparacionId').AsString + '",' +
                         '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                         '"UnidadesStock":"' + SQL_FloatToStr(Q.FieldByName('UnidadesStock').AsFloat) + '",' +
                         '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
                         '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
                         '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoUbicacionAlternativo').AsString) + '",' +
                         sUbicaciones +
                         '}';

    end;

  end;

  if not bError then
    Result := Result + ']}'
  else
    Result := sUbicaciones;

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;



procedure WebModule1detallePreparacionPedidoAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detallePreparacionPedidoAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  FS_SGA_AcumuladoPendiente fsap WITH (NOLOCK) ' +
          'ON ' +
          '  fsap.CodigoEmpresa = fsppl.CodigoEmpresa AND ' +
          '  fsap.codigoarticulo = fsppl.CodigoArticulo AND ' +
          '  fsap.IdPreparacion = fsppl.PreparacionId ' +
          'WHERE ' +
          '  fsppl.PreparacionId = ' + IntToStr(IdPreparacion);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  sSQL := 'SELECT ' +
          '  fsppl.PickingId, fsppl.CodigoEmpresa, fsppl.EjercicioPedido, fsppl.SeriePedido, ' +
          '  fsppl.NumeroPedido, fsppl.OrdenLineaPedido, fsppl.LineasPosicion, fsppl.UnidadMedida, ' +
          '  fsppl.UdNecesarias, fsppl.UdRetiradas, fsppl.CodigoArticulo, fsppl.DescripcionArticulo, ' +
          '  fsppl.Partida, fsppl.PreparacionId, fsap.Partida AS PartidaPreparada, ' +
          '  fsap.Cantidad, art.TratamientoPartidas, art.CodigoAlternativo ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  FS_SGA_AcumuladoPendiente fsap WITH (NOLOCK) ' +
          'ON ' +
          '  fsap.CodigoEmpresa = fsppl.CodigoEmpresa AND ' +
          '  fsap.codigoarticulo = fsppl.CodigoArticulo AND ' +
          '  fsap.IdPreparacion = fsppl.PreparacionId ' +
          'LEFT JOIN ' +
          '  FS_COMMON_TABLE_Articulos ( ' + IntToStr(EmpresaOrigen) + ' ) art ' +
          'ON ' +
          '  fsppl.codigoarticulo = art.codigoarticulo ' +
          'WHERE ' +
          '  fsppl.PreparacionId = ' + IntToStr(IdPreparacion) + ' ' +
          'ORDER BY ' +
          '  fsppl.OrdenLineaPedido, fsppl.Codigoarticulo, fsap.Partida ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
                       '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
                       '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
                       '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
                       '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
                       '"Orden":' + Q.FieldByName('OrdenLineaPedido').AsString + ',' +
                       '"LineasPosicion":"' + JSON_Str(Q.FieldByName('LineasPosicion').AsString) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"PartidaPreparada":"' + JSON_Str(Q.FieldByName('PartidaPreparada').AsString) + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
                       '"UdNecesarias":' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + ',' +
                       '"UdRetiradasTotales":' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + ',' +
                       '"UdRetiradas":' + SQL_FloatToStr(Q.FieldByName('Cantidad').AsFloat) + '' +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;


end;

procedure WebModule1detallePreparacionOrdenAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  sSQL1: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  Indice: Integer;
  MostrarPartidas: Integer;
  sTable: string;
  CodigoAlmacen: String;
  CodigoArticulo: String;
  sUbicaciones: String;
  Partida: String;
  bError: Boolean;
  Pendientes: Integer;
  SoloConStock: Integer;
  iStockTotal: Double;
  Direccion: Integer;
  CodigoUbicacionExpedicion: String;
  CodigoUbicacionesExcluidas: String;
  sMsg: String;
  sIDCall: String;
  bIsBuilding: Boolean;
{$ENDREGION}

begin

  if request.contentfields.Values['LogID']<>'' then
    sIDCall := request.contentfields.Values['LogID'];

  if Length(sIDCall)<>12 then
    sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detallePreparacionOrdenAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  gaLogFile.Write ( 'EmpresaOrigen = ' + IntToStr(EmpresaOrigen), sIDCall  );

  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );
  gaLogFile.Write ( 'CodigoEmpresa = ' + IntToStr(CodigoEmpresa), sIDCall  );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );
  gaLogFile.Write ( 'YY = ' + IntToStr(YY), sIDCall  );

  sSQL1           := Trim(request.ContentFields.Values['SQL']);
  Indice          := StrToIntDef(request.contentfields.values['Indice'],0);
  MostrarPartidas := 1; //StrToIntDef(request.contentfields.values['MostrarPartidas'],0);
  Pendientes      := StrToIntDef(request.contentfields.values['Pendientes'],0);
  SoloConStock    := StrToIntDef(request.contentfields.values['SoloConStock'],0);
  Direccion       := StrToIntDef(request.contentfields.values['Direccion'],1);
  CodigoAlmacen   := Trim(request.ContentFields.Values['CodigoAlmacen']);

  // Temporal
  //if CodigoAlmacen='' then
  //  CodigoAlmacen := 'ALM1';

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  gaLogFile.Write ( 'IdPreparacion = ' + IntToStr(IdPreparacion), sIDCall  );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';
  sOperation := '>';

  if Direccion=0 then begin
    sOperation := '=';
    Direccion := 1;
  end else begin
    if Direccion<0 then begin
      sOperation := '<';
    end;
  end;

  if OrdenarPor='ARTICULO' then begin
    if Direccion<0 then begin
      sOrderBy := 'fspo.CodigoArticulo DESC, fspo.Partida DESC ';
    end else begin
      sOrderBy := 'fspo.CodigoArticulo, fspo.Partida ';
    end;
  end else if OrdenarPor='CODIGOUBICACION' then begin
    if Direccion<0 then begin
      sOrderBy := 'fspo.CodigoUbicacion DESC, fspo.rn DESC ';
    end else begin
      sOrderBy := 'fspo.CodigoUbicacion, rn ';
    end;
  end else if OrdenarPor='CODIGOUBICACIONALTERNATIVO' then begin
    if Direccion<0 then begin
      sOrderBy := 'fspo.rn DESC ';
    end else begin
      sOrderBy := 'fspo.rn ';
    end;
  end else begin
    if Direccion<0 then begin
      sOrderBy := 'fspo.CodigoArticulo DESC, fspo.Partida DESC ';
    end else begin
      sOrderBy := 'fspo.CodigoArticulo DESC, fspo.Partida ';
    end;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, EmpresaOrigen );
  gaLogFile.Write ( 'CodigoUbicacionExpedicion = ' + CodigoUbicacionExpedicion, sIDCall  );

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionesExcluidasExpedicion, CodigoUbicacionesExcluidas, EmpresaOrigen );
  gaLogFile.Write ( 'CodigoUbicacionesExcluidas = ' + CodigoUbicacionesExcluidas, sIDCall  );

  if (CodigoUbicacionesExcluidas='') or (CodigoUbicacionesExcluidas='0') then
    CodigoUbicacionesExcluidas := '''''';

  if CodigoAlmacen='' then begin
    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacionExpedicion );
  end;

  gaLogFile.Write ( 'CodigoAlmacen = ' + CodigoAlmacen, sIDCall  );

  {$ENDREGION}

  {$REGION 'Ens assegurem que tenim creada la taula amb l´ordenació creada'}
  sSQL := 'SELECT COUNT(*) FROM FS_SGA_ActualizarRuta WITH (NOLOCK) WHERE PreparacionId=' + IntToStr(IdPreparacion);
  if SQL_Execute(Conn,sSQL)>0 then
  begin
    gaLogFile.Write ( 'Before SGA_Check_PreparacionOrdenada Manual', sIDCall  );
    SGA_Check_PreparacionOrdenada ( gsPath, Conn, EmpresaOrigen, YY, IdPreparacion, CodigoAlmacen, CodigoUbicacionExpedicion, sMsg, TRUE, bIsBuilding );
    gaLogFile.Write ( 'After SGA_Check_PreparacionOrdenada Manual: ' + sMsg, sIDCall  );
  end else begin
    gaLogFile.Write ( 'Before SGA_Check_PreparacionOrdenada', sIDCall  );
    SGA_Check_PreparacionOrdenada ( gsPath, Conn, EmpresaOrigen, YY, IdPreparacion, CodigoAlmacen, CodigoUbicacionExpedicion, sMsg, FALSE, bIsBuilding );
    gaLogFile.Write ( 'After SGA_Check_PreparacionOrdenada: ' + sMsg, sIDCall  );
  end;

  if bIsBuilding then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Se está calculando la ruta. Volver a intentar en unos segundos","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo';

  sSQL := 'SELECT TOP 1 ' +
          '  fssa.UnidadesSaldo, fspo.* ' +
          'FROM ' +
          '  FS_SGA_PreparacionOrdenada fspo WITH (NOLOCK) ' +
          'INNER JOIN ' +
          '( ' +
          '  SELECT ' +
          '    CodigoUbicacion, CodigoArticulo, SUM(UnidadesSaldo) AS UnidadesSaldo  ' +
          '  FROM ' +
          '    FS_SGA_TABLE_AcumuladoStockActual ( ' + IntToStr(CodigoEmpresa) + ', ' + IntToStr(YY) + ' ) ' +
          '  GROUP BY ' +
          '    CodigoUbicacion, CodigoArticulo ' +
          ') fssa ' +
          'ON ' +
          '  fssa.CodigoUbicacion = fspo.CodigoUbicacion AND ' +
          '  fssa.CodigoArticulo = fspo.CodigoArticulo AND ' +
          '  fssa.CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ) ' +
          'WHERE ' +
          '  fspo.PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  fspo.rn ' + sOperation + ' ' + IntToStr(Indice) + '  AND ' +
          '  fspo.CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ) AND ' +
          '  fspo.CodigoUbicacion NOT IN ( ' + CodigoUbicacionesExcluidas + ' )';

  if Pendientes=1 then
     sSQL := sSQL + 'AND fspo.UdNecesarias > fspo.Udretiradas ';

  if SoloConStock=1 then
     sSQL := sSQL + 'AND fspo.CodigoUbicacion IS NOT NULL ';

  sSQL := sSQL + 'ORDER BY ' + sOrderBy;

  Q := SQL_PrepareQuery ( Conn, sSQL );
  gaLogFile.Write(sSQL, sIDCall );

  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"SQL1":"' + JSON_Str(sSQL1) + '","SQL":"' + JSON_Str(sSQL) + '","Result":"OK","Error":"","TotalRecords":1,"NumPages":1,"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  if not Q.Eof then begin

    Q.Last;

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    CodigoAlmacen  := FS_SGA_CodigoAlmacen ( Q.FieldByName('CodigoUbicacion').AsString );
    CodigoArticulo := Q.FieldByName('CodigoArticulo').AsString;
    Partida        := Q.FieldByName('Partida').AsString;

    sUbicaciones := FS_SGA_ObtenerUbicaciones (
      Conn,
      EmpresaOrigen,
      CodigoArticulo,
      Partida,
      CodigoAlmacen,
      MostrarPartidas,
      bError,
      iStockTotal );

    if not bError then begin

      Result := Result + '{' +
                         '"Indice":"' + Q.FieldByName('rn').AsString + '",' +
                         '"CodigoEmpresa":"' + IntToStr(CodigoEmpresa) + '",' +
                         '"UdNecesarias":"' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + '",' +
                         '"UdRetiradas":"' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + '",' +
                         '"UdExpedidas":"' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) + '",' +
                         '"CodigoArticulo":"' + JSON_Str(CodigoArticulo) + '",' +
                         '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoArticuloAlternativo').AsString) + '",' +
                         '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                         '"Partida":"' + JSON_Str(Partida) + '",' +
                         '"CodigoAlmacen":"' + JSON_Str(CodigoAlmacen) + '",' +
                         '"PreparacionId":"' + Q.FieldByName('PreparacionId').AsString + '",' +
                         '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                         '"UnidadesStock2":"' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat) + '",' +
                         '"UnidadesStock":"' + SQL_FloatToStr(iStockTotal) + '",' +
                         '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
                         '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
                         '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoUbicacionAlternativo').AsString) + '",' +
                         sUbicaciones +
                         '}';

    end;

  end;

  if not bError then
    Result := Result + ']}'
  else
    Result := sUbicaciones;

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;



// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ DETALLS D'UNA RECEPCIÓ                                                │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1detalleRecepcionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  RecepcionId: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRechazos: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1detalleRecepcionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  RecepcionId := StrToIntDef(request.contentfields.values['RecepcionId'],0);
  if RecepcionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );
  OrdenarPor    := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden     := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy      := '';

  if OrdenarPor='PEDIDO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.EjercicioPedido DESC, fsrl.SeriePedido DESC, fsrl.NumeroPedido DESC, fsrl.OrdenLineaPedido ';
    end else begin
      sOrderBy := 'fsrl.EjercicioPedido, fsrl.SeriePedido, fsrl.NumeroPedido, fsrl.OrdenLineaPedido ';
    end;
  end else if OrdenarPor='ESTADO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.UdSaldo DESC ';
    end else begin
      sOrderBy := 'fsrl.UdSaldo ';
    end;
  end else if OrdenarPor='ARTICULO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.CodigoArticulo DESC, fsrl.Partida DESC ';
    end else begin
      sOrderBy := 'fsrl.CodigoArticulo, fsrl.Partida ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.RecepcionIdLinea DESC ';
    end else begin
      sOrderBy := 'fsrl.RecepcionIdLinea ';
    end;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcion,         CodigoUbicacionRecepcion, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcionRechazos, CodigoUbicacionRechazos, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Recepciones_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  RecepcionId = ' + IntToStr(RecepcionId);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fsrl.*, art.TratamientoPartidas, art.CodigoAlternativo ' +
          'FROM ' +
          '  FS_SGA_Recepciones_Lineas fsrl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  fsrl.CodigoArticulo = art.CodigoArticulo ' +
          'WHERE ' +
          '  fsrl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsrl.RecepcionId = ' + IntToStr(RecepcionId) + ' ' +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  Q2 := SQL_PrepareQuery ( Conn );

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    sSQL := 'SELECT ' +
            '  fsrld.*, stu.CodigoAlternativo, fsi.NombreIncidencia, fsrld.Unidades * art.PesoBrutoUnitario_ as PesoBruto, ' +
            '   fsrld.Unidades * art.PesoNetoUnitario_ as PesoNeto, fsrld.Unidades * art.VolumenUnitario_ as Volumen ' +
            'FROM ' +
            '  FS_SGA_Recepciones_Lineas_Detalle fsrld WITH (NOLOCK) ' +
            'INNER JOIN ' +
            '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) stu ' +
            'ON ' +
            '  stu.CodigoUbicacion = fsrld.CodigoUbicacion ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_Incidencias ( ' + IntToStr(EmpresaOrigen) + ', ''R'' ) fsi ' +
            'ON ' +
            '  fsi.IdIncidencia = fsrld.AnomaliaId ' +
            'LEFT JOIN ' +
            '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
            'ON ' +
            '  art.CodigoArticulo = ''' + SQL_Str(Q.FieldByName('CodigoArticulo').AsString) + ''' ' +
            'WHERE ' +
            '  fsrld.RecepcionIdLinea = ' + IntToStr(Q.FieldByName('RecepcionIdLinea').AsInteger) + ' AND ' +
            '  fsrld.RecepcionId = ' + IntToStr(RecepcionId) +
            'ORDER BY ' +
            '  fsrld.RecepcionIdLineaDetalle';

    Q2.Close;
    Q2.SQL.Text := sSQL;
    try
      Q2.Open;
    except
      on E:Exception do begin
        gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
        Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
        FreeAndNil(Q2);
        FreeAndNil(Q);
        Exit;
      end;
    end;

    sDesglose := '';

    while not Q2.EOF do begin

      if sDesglose<>'' then
        sDesglose := sDesglose + ',';

      sDesglose := sDesglose + '{' +
                               '"RecepcionId":"' + Q2.FieldByName('RecepcionId').AsString + '",' +
                               '"RecepcionIdLinea":"' + Q2.FieldByName('RecepcionIdLinea').AsString + '",' +
                               '"RecepcionIdLineaDetalle":"' + Q2.FieldByName('RecepcionIdLineaDetalle').AsString + '",' +
                               '"CodigoAlmacen":"' + Q2.FieldByName('CodigoAlmacen').AsString + '",' +
                               '"CodigoUbicacion":"' + Q2.FieldByName('CodigoUbicacion').AsString + '",' +
                               '"CodigoArticuloAlternativo":"' + Q2.FieldByName('CodigoAlternativo').AsString + '",' +
                               '"CodigoAlmacenRechazos":"' + Q2.FieldByName('CodigoAlmacenRechazos').AsString + '",' +
                               '"CodigoUbicacionRechazos":"' + Q2.FieldByName('CodigoUbicacionRechazos').AsString + '",' +
                               '"Caja":"' + JSON_Str(Q2.FieldByName('Caja').AsString) + '",' +
                               '"Palet":"' + JSON_Str(Q2.FieldByName('Palet').AsString) + '",' +
                               '"Partida":"' + JSON_Str(Q2.FieldByName('Partida').AsString) + '",' +
                               '"FechaCaducidad":"' + Q2.FieldByName('FechaCaducidad').AsString + '",' +
                               '"Verificacion":"' + JSON_Str(Q2.FieldByName('Verificacion').AsString) + '",' +
                               '"IdIncidencia":"' + JSON_Str(Q2.FieldByName('AnomaliaId').AsString) + '",' +
                               '"NombreIncidencia":"' + JSON_Str(Q2.FieldByName('NombreIncidencia').AsString) + '",' +
                               '"Precio":' + SQL_FloatToStr(Q2.FieldByName('Precio').AsFloat) + ',' +
                               '"UnidadesEntrada":' + SQL_FloatToStr(Q2.FieldByName('UnidadesEntrada').AsFloat) + ',' +
                               '"CantidadErrorEntrada":' + SQL_FloatToStr(Q2.FieldByName('CantidadErrorEntrada').AsFloat) + ',' +
                               '"TotalEntrada":' + SQL_FloatToStr(Q2.FieldByName('TotalEntrada').AsFloat) +
                               '}';

      Q2.Next;

    end;

    Q2.Close;

    sDesglose := sDesglose + '';

    Result := Result + '{' +
                       '"RecepcionId":"' + Q.FieldByName('RecepcionId').AsString + '",' +
                       '"RecepcionIdLinea":"' + Q.FieldByName('RecepcionIdLinea').AsString + '",' +
                       '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
                       '"EjercicioPedido":"' + Q.FieldByName('EjercicioPedido').AsString + '",' +
                       '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
                       '"NumeroPedido":"' + Q.FieldByName('NumeroPedido').AsString + '",' +
                       '"OrdenLineaPedido":"' + Q.FieldByName('OrdenLineaPedido').AsString + '",' +
                       '"LineasPosicion":"' + Q.FieldByName('LineasPosicion').AsString + '",' +
                       '"UdPedidas":"' + SQL_FloatToStr(Q.FieldByName('UdPedidas').AsFloat) + '",' +
                       '"UdRecibidas":"' + SQL_FloatToStr(Q.FieldByName('UdRecibidas').AsFloat) + '",' +
                       '"UdSaldo":"' + SQL_FloatToStr(Q.FieldByName('UdSaldo').AsFloat) + '",' +
                       '"Precio":"' + SQL_FloatToStr(Q.FieldByName('Precio').AsFloat) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
                       '"CodigoProveedor":"' + JSON_Str(Q.FieldByName('CodigoProveedor').AsString) + '",' +
                       '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
                       '"IdAlbaranPro":"' + JSON_Str(Q.FieldByName('IdAlbaranPro').AsString) + '",' +
                       '"Albaran":"' + JSON_Str(Q.FieldByName('Albaran').AsString) + '",' +
                       '"FechaRecepcion":"' + Q.FieldByName('FechaRecepcion').AsString + '",' +
                       '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida1_').AsString) + '",' +
                       '"Desglose":[' + sDesglose + ']' +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q2.Close;
  FreeAndNil(Q2);
  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1diagnosticsAction (
  Conn: TADOConnection;
  sParams: String;
  var statusCode: Integer;
  var statusText: String;
  var Result: String
);

{$REGION 'Declaració de variables'}
var
  EmpresaOrigen: Integer;
  CodigoEmpresa: Integer;
  sSQL: String;
  Q: TADOQuery;
  CodigoUsuario: Integer;
  iNumOperacionesPendientes: Integer;
  contentfields: TStringList;
{$ENDREGION}

begin

  {$REGION 'Recuperació de paràmetres'}

  REQUEST_Split ( sParams, contentfields );

  EmpresaOrigen := StrToIntDef(contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(sParams) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(contentfields.Values['CodigoUsuario'], 0 );

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  FS_SGA_VIEW_DIAGNOSTICS WITH (NOLOCK) ' +
          'WHERE ' +
          '  oper_CodigoEmpresa = ' + IntToStr(EmpresaOrigen);

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_Operations WITH (NOLOCK) ' +
          'WHERE '+
          '  oper_status = 0';

  iNumOperacionesPendientes := SQL_Execute ( Conn, sSQL );

  Result := '{"Result":"OK","Error":"","Data":[{' +
    '"NumOperacionesPendientes":' + IntToStr(iNumOperacionesPendientes) +
    '}]}';

  {$ENDREGION}

end;

{$ENDREGION}


{$REGION '--- FUNCIONS D´EMPRESES'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE TOTES LES EMPRESES ACTIVES A SAGE                          │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listCabeceraAlbaranClienteAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoCliente: String;
  EjercicioAlbaran: Integer;
  sAndWhere: String;
  EmpresaOrigen: Integer;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listCabeceraAlbaranClienteAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoCliente    := trim(request.contentfields.values['CodigoCliente']);
  EjercicioAlbaran := StrToIntDef(request.contentfields.Values['EjercicioAlbaran'], 0 );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='PEDIDO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioAlbaran DESC, SerieAlbaran DESC, NumeroAlbaran DESC ';
    end else begin
      sOrderBy := 'EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end;
  end else if OrdenarPor='CLIENTE' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'RazonSocial DESC, EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end else begin
      sOrderBy := 'RazonSocial, EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioAlbaran DESC, SerieAlbaran DESC, NumeroAlbaran DESC ';
    end else begin
      sOrderBy := 'EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if CodigoCliente<>'' then begin
    sAndWhere := sAndWhere + 'AND CodigoCliente=''' + SQL_Str(CodigoCliente) + ''' ';
  end;

  if EjercicioAlbaran<>0 then begin
    sAndWhere := sAndWhere + 'AND EjercicioAlbaran=' + IntToStr(EjercicioAlbaran) + ' ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  CabeceraAlbaranCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + //+ ' AND ' +
          '  AND FechaAlbaran >= DATEADD(day,-30,GETDATE()) ' +
          //'  Estado <> 2 ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  CabeceraAlbaranCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + //' AND ' +
          '  AND FechaAlbaran >= DATEADD(day,-30,GETDATE()) ' +
          //'  Estado <> 2 ' +
          sAndWhere + ' ' +
          'ORDER BY ' +
          sOrderBy + ' ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"EjercicioAlbaran":' + Q.FieldByName('EjercicioAlbaran').AsString + ',' +
      '"SerieAlbaran":"' + Q.FieldByName('SerieAlbaran').AsString + '",' +
      '"NumeroAlbaran":' + Q.FieldByName('NumeroAlbaran').AsString + ',' +
      '"FechaAlbaran":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaAlbaran').AsDateTime ) + '",' +
      '"CodigoCliente":"' + Q.FieldByName('CodigoCliente').AsString + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"Nombre":"' + JSON_Str(Q.FieldByName('Nombre').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '",' +
      '"Nacion":"' + JSON_Str(Q.FieldByName('Nacion').AsString) + '",' +
      '"NumeroLineas":' + Q.FieldByName('NumeroLineas').AsString + ',' +
      '"PesoBruto_":' + SQL_FloatToStr(Q.FieldByName('PesoBruto_').AsFloat) + ',' +
      '"PesoNeto_":' + SQL_FloatToStr(Q.FieldByName('PesoNeto_').AsFloat) + ',' +
      '"Volumen_":' + SQL_FloatToStr(Q.FieldByName('Volumen_').AsFloat) + ',' +
      '"IdAlbaranCli":"' + Q.FieldByName('IdAlbaranCli').AsString + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1listCabeceraAlbaranCompraAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoProveedor: String;
  EjercicioAlbaran: Integer;
  sAndWhere: String;
  EmpresaOrigen: Integer;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listCabeceraAlbaranCompraAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoProveedor  := trim(request.contentfields.values['CodigoProveedor']);
  EjercicioAlbaran := StrToIntDef(request.contentfields.Values['EjercicioAlbaran'], 0 );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='PEDIDO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioAlbaran DESC, SerieAlbaran DESC, NumeroAlbaran DESC ';
    end else begin
      sOrderBy := 'EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end;
  end else if OrdenarPor='PROVEEDOR' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'RazonSocial DESC, EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end else begin
      sOrderBy := 'RazonSocial, EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioAlbaran DESC, SerieAlbaran DESC, NumeroAlbaran DESC ';
    end else begin
      sOrderBy := 'EjercicioAlbaran, SerieAlbaran, NumeroAlbaran ';
    end;
  end;{$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if CodigoProveedor<>'' then begin
    sAndWhere := sAndWhere + 'AND CodigoProveedor=''' + SQL_Str(CodigoProveedor) + ''' ';
  end;

  if EjercicioAlbaran<>0 then begin
    sAndWhere := sAndWhere + 'AND EjercicioAlbaran=' + IntToStr(EjercicioAlbaran) + ' ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  CabeceraAlbaranProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' ' +
          '  AND FechaAlbaran >= DATEADD(day,-30,GETDATE()) ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  CabeceraAlbaranProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' ' +
          '  AND FechaAlbaran >= DATEADD(day,-30,GETDATE()) ' +
          sAndWhere + ' ' +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"EjercicioAlbaran":' + Q.FieldByName('EjercicioAlbaran').AsString + ',' +
      '"SerieAlbaran":"' + Q.FieldByName('SerieAlbaran').AsString + '",' +
      '"NumeroAlbaran":' + Q.FieldByName('NumeroAlbaran').AsString + ',' +
      '"FechaAlbaran":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaAlbaran').AsDateTime ) + '",' +
      '"NumeroLineas":' + Q.FieldByName('NumeroLineas').AsString + ',' +
      '"CodigoProveedor":"' + Q.FieldByName('CodigoProveedor').AsString + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"Nombre":"' + JSON_Str(Q.FieldByName('Nombre').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '",' +
      '"Nacion":"' + JSON_Str(Q.FieldByName('Nacion').AsString) + '",' +
      '"IdAlbaranPro":"' + Q.FieldByName('IdAlbaranPro').AsString + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE CLIENTS D'UNA EMPRESA                                      │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listClientesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  Filter: String;
  sAndWhere: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listClientesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  Filter := trim(request.ContentFields.Values['Filtro']);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if Filter<>'' then begin
    sAndWhere := sAndWhere + 'AND ( ' +
                             '  c.Nombre LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.RazonSocial LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Domicilio LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.CodigoCliente LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.CodigoPostal LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Municipio LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Provincia LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Telefono LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Telefono2 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Telefono3 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Email1 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.Email2 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.CifDni LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  c.CifEuropeo LIKE ''%' + SQL_Str(Filter) + '%'' ' +
                             ')';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  Clientes c WITH (NOLOCK) ' +
          'WHERE ' +
          '  c.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  c.FechaBajaLc IS NULL ' +
          sAndWhere;


  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  c.* ' +
          'FROM ' +
          '  Clientes c WITH (NOLOCK) ' +
          'WHERE ' +
          '  c.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  c.FechaBajaLc IS NULL ' +
          sAndWhere +
          'ORDER BY ' +
          '  c.CodigoEmpresa, c.RazonSocial ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"CodigoCliente":"' + Q.FieldByName('CodigoCliente').AsString + '",' +
      '"CifEuropeo":"' + JSON_Str(Q.FieldByName('CifEuropeo').AsString) + '",' +
      '"Nombre":"' + JSON_Str(Q.FieldByName('Nombre').AsString) + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '",' +
      '"Nacion":"' + JSON_Str(Q.FieldByName('Nacion').AsString) + '",' +
      '"Telefono":"' + JSON_Str(Q.FieldByName('Telefono').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'EMPRESES                                                    │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listCompaniesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  sSQL: String;
  Q: TADOQuery;
  Result: String;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listCompaniesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  Empresas ' +
          'WHERE ' +
          '  FechaBaja IS NULL';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  CodigoEmpresa, Empresa ' +
          'FROM ' +
          '  Empresas WITH (NOLOCK) ' +
          'WHERE ' +
          '  FechaBaja IS NULL ' +
          'ORDER BY ' +
          '  CodigoEmpresa ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ', ' +
      '"Empresa":"' + JSON_Str(Q.FieldByName('Empresa').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1listDevolucionesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Tipo: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  Filter: String;
  sAndWhere: String;
  sSort: String;
  sSortType: String;
  CodigoUsuario: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listDevolucionesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );
  Tipo := StrToIntDef(request.contentfields.values['Tipo'],0);

  sSort := AnsiLowerCase(trim(request.contentfields.Values['OrdenarPor']));
  sSortType := AnsiLowerCase(trim(request.contentfields.Values['TipoOrden']));

  if (sSort='fecha') then
    sSort := ' d.Fecha '
  else if (sSort='cliente') then
    sSort := ' d.CodigoCliente '
  else if (sSort='lineas') then
    sSort := ' 1 '
  else
    sSort := ' d.DevolucionId ';

  if sSortType='desc' then
    sSort := sSort + ' DESC ';

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if (Tipo=0) or (Tipo=1) then
    sAndWhere := sAndWhere + 'AND Estado IN (0,1) '
  else
    sAndWhere := sAndWhere + 'AND Estado = ' + IntToStr(Tipo) + ' ';

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Devoluciones WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  ( ' +
          '    SELECT ' +
          '      COUNT(*) ' +
          '    FROM ' +
          '      FS_SGA_Devoluciones_Lineas dl WITH (NOLOCK) ' +
          '    WHERE ' +
          '      d.CodigoEmpresa = dl.CodigoEmpresa AND ' +
          '      d.DevolucionId = dl.DevolucionId ' +
          '  ) AS NumLineasTotales, ' +
          '  ( ' +
          '    SELECT ' +
          '      COUNT(*) ' +
          '    FROM ' +
          '      FS_SGA_Devoluciones_Lineas dl WITH (NOLOCK) ' +
          '    WHERE ' +
          '      d.CodigoEmpresa = dl.CodigoEmpresa AND ' +
          '      d.DevolucionId = dl.DevolucionId AND ' +
          '      dl.UdSaldo<>0 ' +
          '  ) AS NumLineasPendientes, ' +
          '  d.* ' +
          'FROM ' +
          '  FS_SGA_Devoluciones d WITH (NOLOCK) ' +
          'WHERE ' +
          '  d.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) +
          sAndWhere +
          'ORDER BY ' +
          sSort +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"DevolucionId":' + Q.FieldByName('DevolucionId').AsString + ',' +
      '"Fecha":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('Fecha').AsDateTime) + '",' +
      '"CodigoCliente":"' + JSON_Str(Q.FieldByName('CodigoCliente').AsString) + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"IdAlbaranCli":"' + JSON_Str(Q.FieldByName('IdAlbaranCli').AsString) + '",' +
      '"Albaran":"' + JSON_Str(Q.FieldByName('Albaran').AsString) + '",' +
      '"Observaciones":"' + JSON_Str(Q.FieldByName('Observaciones').AsString) + '",' +
      '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
      '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
      '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
      '"FechaInicioRecepcion":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('FechaInicioRecepcion').AsDateTime) + '",' +
      '"FechaFinRecepcion":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('FechaFinRecepcion').AsDateTime) + '",' +
      '"Estado":' + Q.FieldByName('Estado').AsString + ',' +
      '"NumLineasTotales":' + Q.FieldByName('NumLineasTotales').AsString + ',' +
      '"NumLineasPendientes":' + Q.FieldByName('NumLineasPendientes').AsString + ',' +
      '"NumLineasRealizadas":' + IntToStr(Q.FieldByName('NumLineasTotales').AsInteger-Q.FieldByName('NumLineasPendientes').AsInteger) +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;


end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'ESTANTERIES D'UN PASSADÍS                                   │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listEstanteriasAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  CodigoPasillo: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listEstanteriasAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  CodigoPasillo := request.contentfields.values['CodigoPasillo'];
  if CodigoPasillo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de pasillo no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT CodigoEstanteria) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  CodigoPasillo = ''' + SQL_Str(CodigoPasillo) + ''' ';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  DISTINCT CodigoEstanteria ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  CodigoPasillo = ''' + SQL_Str(CodigoPasillo) + ''' ' +
          'ORDER BY ' +
          '  CodigoEstanteria ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoEstanteria":"' + JSON_Str(Q.FieldByName('CodigoEstanteria').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE FAMÍLIES D'ARTICLES                                        │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listFamiliasAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  Filtro: String;
  sAndWhere: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listFamiliasAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Familias' );

  Filtro := Trim(request.contentfields.values['Filtro']);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if Filtro<>'' then begin
    sAndWhere := sAndWhere + 'AND ( ' +
      'CodigoFamilia LIKE ''%' + SQL_Str(Filtro) + '%'' OR ' +
      'Descripcion LIKE ''%' + SQL_Str(Filtro) + '%'' ' +
      ' ) ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT CodigoFamilia) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Familias ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoSubfamilia = ''**********'' ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  DISTINCT CodigoFamilia, Descripcion ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Familias ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoSubfamilia = ''**********'' ' +
          sAndWhere +
          'ORDER BY ' +
          '  CodigoFamilia ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
      '"Descripcion":"' + JSON_Str(Q.FieldByName('Descripcion').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE FONDOS D'UNA UBICACIÓ                                      │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listFondosAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  CodigoPasillo: String;
  CodigoEstanteria: String;
  Altura: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listFondosAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  CodigoPasillo := request.contentfields.values['CodigoPasillo'];
  if CodigoPasillo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de pasillo no especificado","Data":[]}';
    Exit;
  end;

  CodigoEstanteria := request.contentfields.values['CodigoEstanteria'];
  if CodigoEstanteria='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de estantería no especificado","Data":[]}';
    Exit;
  end;

  Altura := request.contentfields.values['Altura'];
  if Altura='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Altura no especificada","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT Fondo) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  CodigoPasillo = ''' + SQL_Str(CodigoPasillo) + ''' AND ' +
          '  CodigoEstanteria = ''' + SQL_Str(CodigoEstanteria) + ''' AND ' +
          '  Altura = ''' + SQL_Str(Altura) + ''' ';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  DISTINCT Fondo ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  CodigoPasillo = ''' + SQL_Str(CodigoPasillo) + ''' AND ' +
          '  CodigoEstanteria = ''' + SQL_Str(CodigoEstanteria) + ''' AND ' +
          '  Altura = ''' + SQL_Str(Altura) + ''' ' +
          'ORDER BY ' +
          '  Fondo ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"Fondo":"' + JSON_Str(Q.FieldByName('Fondo').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1listIndicenciasAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Tipo: String;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  Result: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listIndicenciasAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  Tipo := AnsiUpperCase(Trim(request.contentfields.Values['TipoIncidencia']));
  if Tipo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado el tipo de incidencia","Data":[]}';
    Exit;
  end;

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='NOMBRE' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'NombreIncidencia DESC ';
    end else begin
      sOrderBy := 'NombreIncidencia ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'IdIncidencia DESC ';
    end else begin
      sOrderBy := 'IdIncidencia ';
    end;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Incidencias ( ' + IntToStr(EmpresaOrigen) + ', ''' + SQL_Str(Tipo) + ''' ) ';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Incidencias ( ' + IntToStr(EmpresaOrigen) + ', ''' + SQL_Str(Tipo) + ''' ) ' +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"IdIncidencia":' + Q.FieldByName('IdIncidencia').AsString + ',' +
      '"TipoIncidencia":"' + JSON_Str(Q.FieldByName('TipoIncidencia').AsString) + '",' +
      '"NombreIncidencia":"' + JSON_Str(Q.FieldByName('NombreIncidencia').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1listInformesAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Ejercicio: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  Tipo: Integer;
  sWhere: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listInformesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  Tipo := StrToIntDef(request.contentfields.Values['Tipo'], 0);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_InformesPredefinidos WITH (NOLOCK) ' +
          'WHERE ' +
          '  (CodigoEmpresa = ' + IntToStr(CodigoEmpresa) + ' OR ' +
          '  CodigoEmpresa = 0 ) AND ' +
          '  Tipo = ' + IntToStr(Tipo) + ' AND ' +
          '  Activo <> 0';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  dbo.FS_SGA_InformesPredefinidos WITH (NOLOCK) ' +
          'WHERE ' +
          '  (CodigoEmpresa = ' + IntToStr(CodigoEmpresa) + ' OR ' +
          '  CodigoEmpresa = 0 ) AND ' +
          '  Tipo = ' + IntToStr(Tipo) + ' AND ' +
          '  Activo <> 0 ' +
          'ORDER BY ' +
          '  Id ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"Id":' + Q.FieldByName('Id').AsString + ',' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"Nombre":"' + JSON_Str(Q.FieldByName('Nombre').AsString) + '",' +
      '"Descripcion":"' + JSON_Str(Q.FieldByName('Descripcion').AsString) + '",' +
      '"NombreCalculo":"' + JSON_Str(Q.FieldByName('Nombre_Calculo').AsString) + '",' +
      '"Parametros":"' + JSON_Str(Q.FieldByName('Parametros').AsString) + '",' +
      '"Tipo":' + Q.FieldByName('Tipo').AsString +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;
end;

procedure WebModule1listInventariosAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Ejercicio: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  Estado: String;
  sWhere: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listInventariosAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  Ejercicio := StrToIntDef(request.contentfields.Values['Ejercicio'], YearOf(Now()) );

  Estado    := Trim(request.contentfields.Values['Estado']);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  if Estado='PENDIENTE' then sWhere := ' AND Inventario_Finalizado=0 '
  else if Estado='FINALIZADO' then sWhere := ' AND Inventario_Finalizado=1 '
  else sWhere := '';

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Inventario ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  Ejercicio = ' + IntToStr(Ejercicio) + ' AND ' +
          '  Inventario_TipoUbicaciones <> ''EXCEL'' ' +
          sWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fsti.*, ISNULL(fsu.NombreUsuario,''???'') AS NombreUsuario ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Inventario ( ' + IntToStr(CodigoEmpresa) + ' ) fsti ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_Usuarios fsu WITH (NOLOCK) ' +
          'ON ' +
          '  fsti.Inventario_UsuarioId = fsu.CodigoUsuario ' +
          'WHERE ' +
          '  fsti.Ejercicio = ' + IntToStr(Ejercicio) + ' AND ' +
          '  fsti.Inventario_TipoUbicaciones <> ''EXCEL'' ' +
          sWhere +
          'ORDER BY ' +
          '  fsti.Inventario_Id DESC ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"Inventario_Id":' + Q.FieldByName('Inventario_Id').AsString + ',' +
      '"Ejercicio":"' + Q.FieldByName('Ejercicio').AsString + '",' +
      '"CodigoAlmacen":"' + Q.FieldByName('Inventario_CodigoAlmacen').AsString + '",' +
      '"InventarioFinalizado":"' + Q.FieldByName('Inventario_Finalizado').AsString + '",' +
      '"Inventario_Nombre":"' + SQL_Str(Q.FieldByName('Inventario_Nombre').AsString) + '",' +
      '"Inventario_Fecha":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('Inventario_Fecha').AsDateTime ) + '",' +
      '"Inventario_FechaInicio":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('Inventario_FechaInicio').AsDateTime ) + '",' +
      '"Inventario_FechaFin":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('Inventario_FechaFin').AsDateTime ) + '",' +
      '"Inventario_NumUbicaciones":"' + Q.FieldByName('Inventario_NumUbicaciones').AsString + '",' +
      '"Inventario_NumCompletadas":"' + Q.FieldByName('Inventario_NumCompletadas').AsString + '",' +
      '"Inventario_Porcentaje":"' + Q.FieldByName('Inventario_Porcentaje').AsString + '",' +
      '"Inventario_Aplicado":"' + Q.FieldByName('Inventario_Aplicado').AsString + '",' +
      '"Inventario_FechaAplicacion":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('Inventario_FechaAplicacion').AsDateTime ) + '",' +
      '"Inventario_UsuarioId":' + SQL_VariantNull(Q.FieldByName('Inventario_UsuarioId').AsString) + ',' +
      '"NombreUsuario":"' + Q.FieldByName('NombreUsuario').AsString + '",' +
      '"TipoUbicaciones":"' + Q.FieldByName('Inventario_TipoUbicaciones').AsString + '",' +
      '"InventarioPadre":' + SQL_VariantNull(Q.FieldByName('Inventario_Padre').AsString) +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1listInventarioUbicacionesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  InventarioId: Integer;
  TipoUbicacion: String;
  listArticulos: String;
  sTipo: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listInventarioUbicacionesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  InventarioId := StrToIntDef(request.contentfields.Values['InventarioId'], 0 );
  if InventarioId=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de inventario no especificado","Data":[]}';
    Exit;
  end;

  // Tipus d'ubicació (TODAS,PENDIENTES,VERIFICADAS)
  TipoUbicacion := trim(request.contentfields.Values['TipoUbicacion']);
  if TipoUbicacion='' then
    TipoUbicacion := 'TODAS';

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT CodigoUbicacion) ' +
          'FROM ' +
          '  FS_SGA_Inventario_Detalle WITH (NOLOCK) ' +
          'WHERE ' +
          '  Inventario_Id = ' + IntToStr(InventarioId) + ' ';
  if TipoUbicacion='PENDIENTES' then
    sSQL := sSQL + ' AND Verificada = 0'
  else if TipoUbicacion='VERIFICADAS' then
    sSQL := sSQL + ' AND Verificada <> 0';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT DISTINCT ' +
          '  fsid.CodigoEmpresa, fsid.Inventario_Id, fsid.CodigoAlmacen, fsid.CodigoUbicacion, ' +
          '  fsid.Verificada, fsid.UsuarioId, fsu.NombreUsuario, MAX(fsid.FechaHoraValidacion) AS FechaHoraValidacion, ' +
          '  fstu.CodigoAlternativo ' +
          'FROM ' +
          '  FS_SGA_Inventario_Detalle fsid WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  FS_SGA_Usuarios fsu WITH (NOLOCK) ' +
          'ON ' +
          '  fsid.UsuarioId = fsu.CodigoUsuario ' +
          'LEFT JOIN ' +
          '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) fstu ' +
          'ON ' +
          '  fstu.CodigoUbicacion = fsid.CodigoUbicacion ' +
          'WHERE ' +
          '  fsid.Inventario_Id = ' + IntToStr(InventarioId) + ' ';

  if TipoUbicacion='PENDIENTES' then
    sSQL := sSQL + ' AND fsid.Verificada = 0 '
  else if TipoUbicacion='VERIFICADAS' then
    sSQL := sSQL + ' AND fsid.Verificada <> 0 ';

  sSQL := sSQL + 'GROUP BY ' +
                 '  fsid.CodigoEmpresa, fsid.Inventario_Id, fsid.CodigoAlmacen, fsid.CodigoUbicacion, ' +
                 '  fsid.Verificada, fsid.UsuarioId, fsu.NombreUsuario,  fstu.CodigoAlternativo ' +
                 'ORDER BY ' +
                 '  fsid.CodigoUbicacion DESC ' +
                 'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
                 'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  Q2 := SQL_PrepareQuery ( Conn );

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    (*
    sSQL := 'SELECT DISTINCT ' +
            '  fsid.Inventario_UbicacionId, fsid.CodigoArticulo, art.DescripcionArticulo, fsid.Partida, ' +
            '  fsid.UnidadMedida, fsid.UnidadesSaldo, fsid.UsuarioId, fsid.FechaHoraValidacion, ' +
            '  fsu.NombreUsuario, fsta.FechaCaduca, fsta.UnidadesSaldo as UnidadesStock ' +
            'FROM ' +
            '  FS_SGA_Inventario_Detalle fsid WITH (NOLOCK) ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
            'ON ' +
            '  fsid.CodigoArticulo = art.CodigoArticulo ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsta ' +
            'ON ' +
            '  fsid.CodigoUbicacion = fsta.CodigoUbicacion AND ' +
            '  fsid.UnidadMedida = fsta.UnidadMedida AND ' +
            '  fsid.CodigoArticulo = fsta.CodigoArticulo AND ' +
            '  fsid.Partida = fsta.Partida AND ' +
            '  fsta.Periodo = 99 ' +
            'LEFT JOIN ' +
            '  FS_SGA_Usuarios fsu WITH (NOLOCK) ' +
            'ON ' +
            '  fsid.UsuarioId = fsu.CodigoUsuario ' +
            'WHERE ' +
            '  fsid.Inventario_Id = ' + IntToStr(InventarioId) + ' AND ' +
            '  fsid.CodigoUbicacion = ''' + SQL_Str(Q.FieldByName('CodigoUbicacion').AsString) + ''' AND ' +
            '  fsid.CodigoArticulo <> '''' ' +
            'ORDER BY ' +
            '  CodigoArticulo, Partida';
    Q2.Close;
    Q2.SQL.Text := sSQL;
    try
      Q2.Open;
    except
      on E:Exception do begin
        gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
        Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
        FreeAndNil(Q2);
        FreeAndNil(Q);
        Exit;
      end;
    end;

    listArticulos := '';

    while not Q2.EOF do begin

      if listArticulos<>'' then
        listArticulos := listArticulos + ',';

      listArticulos := listArticulos +
        '{' +
        '"Inventario_UbicacionId":"' + Q2.FieldByName('Inventario_UbicacionId').AsString + '",' +
        '"CodigoArticulo":"' + Q2.FieldByName('CodigoArticulo').AsString + '",' +
        '"DescripcionArticulo":"' + Q2.FieldByName('DescripcionArticulo').AsString + '",' +
        '"Partida":"' + Q2.FieldByName('Partida').AsString + '",' +
        '"UnidadMedida":"' + Q2.FieldByName('UnidadMedida').AsString + '",' +
        '"UnidadesStock":' + SQL_FloatToStr(Q2.FieldByName('UnidadesStock').AsFloat) + ',' +
        '"UnidadesSaldo":' + SQL_FloatToStr(Q2.FieldByName('UnidadesSaldo').AsFloat) + ',' +
        '"FechaCaduca":"' + FormatDateTime('dd/mm/yyyy', Q2.FieldByName('FechaCaduca').AsDateTime) + '"' +
        '}';

      Q2.Next;

    end;

    *)

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"Inventario_Id":' + Q.FieldByName('Inventario_Id').AsString + ',' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"CodigoUbicacion":"' + Q.FieldByName('CodigoUbicacion').AsString + '",' +
      '"CodigoUbicacionAlternativo":"' + Q.FieldByName('CodigoAlternativo').AsString + '",' +
      '"Verificada":' + SQL_BooleanToStr (Q.FieldByName('Verificada').AsBoolean) + ',' +
      '"UsuarioId":"' + Q.FieldByName('UsuarioId').AsString + '",' +
      '"NombreUsuario":"' + Q.FieldByName('NombreUsuario').AsString + '",' +
      '"FechaHoraValidacion":"' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Q.FieldByName('FechaHoraValidacion').AsDateTime) + '"' +
      //'"Articulos":[' + listArticulos + ']' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q2.Close;
  FreeAndNil(Q2);

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1listLineasAlbaranProveedorAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EjercicioAlbaran: Integer;
  SerieAlbaran: String;
  NumeroAlbaran: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listLineasAlbaranProveedorAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  EjercicioAlbaran := StrToIntDef(request.contentfields.Values['EjercicioAlbaran'], 0 );
  if EjercicioAlbaran=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Ejercicio del albarán no especificado","Data":[]}';
    Exit;
  end;

  SerieAlbaran := trim(request.contentfields.Values['SerieAlbaran']);

  NumeroAlbaran := StrToIntDef(request.contentfields.Values['NumeroAlbaran'], 0 );
  if NumeroAlbaran=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Número del albarán no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  LineasAlbaranProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioAlbaran = ' + IntToStr(EjercicioAlbaran) + ' AND ' +
          '  SerieAlbaran = ''' + SQL_Str(SerieAlbaran) + ''' AND ' +
          '  NumeroAlbaran = ' + IntToStr(NumeroAlbaran );

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  LineasAlbaranProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioAlbaran = ' + IntToStr(EjercicioAlbaran) + ' AND ' +
          '  SerieAlbaran = ''' + SQL_Str(SerieAlbaran) + ''' AND ' +
          '  NumeroAlbaran = ' + IntToStr(NumeroAlbaran ) + ' ' +
          'ORDER BY ' +
          '  Orden ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"EjercicioAlbaran":' + Q.FieldByName('EjercicioAlbaran').AsString + ',' +
      '"SerieAlbaran":"' + Q.FieldByName('SerieAlbaran').AsString + '",' +
      '"NumeroAlbaran":' + Q.FieldByName('NumeroAlbaran').AsString + ',' +
      '"Orden":' + Q.FieldByName('Orden').AsString + ',' +
      '"LineasPosicion":"' + Q.FieldByName('LineasPosicion').AsString + '",' +
      '"LineaPedido":"' + Q.FieldByName('LineaPedido').AsString + '",' +
      '"FechaRegistro":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaRegistro').AsDateTime) + '",' +
      '"CodigoArticulo":"' + Q.FieldByName('CodigoArticulo').AsString + '",' +
      '"CodigoAlmacen":"' + Q.FieldByName('CodigoAlmacen').AsString + '",' +
      '"Partida":"' + Q.FieldByName('Partida').AsString + '",' +
      '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
      '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"UnidadesRecibidas":' + SQL_FloatToStr(Q.FieldByName('UnidadesRecibidas').AsFloat) + ',' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida1_').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1listLineasAlbaranVentaAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EjercicioAlbaran: Integer;
  SerieAlbaran: String;
  NumeroAlbaran: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listLineasAlbaranVentaAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  EjercicioAlbaran := StrToIntDef(request.contentfields.Values['EjercicioAlbaran'], 0 );
  if EjercicioAlbaran=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Ejercicio del albarán no especificado","Data":[]}';
    Exit;
  end;

  SerieAlbaran := trim(request.contentfields.Values['SerieAlbaran']);

  NumeroAlbaran := StrToIntDef(request.contentfields.Values['NumeroAlbaran'], 0 );
  if NumeroAlbaran=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Número del albarán no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  LineasAlbaranCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioAlbaran = ' + IntToStr(EjercicioAlbaran) + ' AND ' +
          '  SerieAlbaran = ''' + SQL_Str(SerieAlbaran) + ''' AND ' +
          '  NumeroAlbaran = ' + IntToStr(NumeroAlbaran );

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  LineasAlbaranCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioAlbaran = ' + IntToStr(EjercicioAlbaran) + ' AND ' +
          '  SerieAlbaran = ''' + SQL_Str(SerieAlbaran) + ''' AND ' +
          '  NumeroAlbaran = ' + IntToStr(NumeroAlbaran ) + ' ' +
          'ORDER BY ' +
          '  Orden ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"EjercicioAlbaran":' + Q.FieldByName('EjercicioAlbaran').AsString + ',' +
      '"SerieAlbaran":"' + JSON_Str(Q.FieldByName('SerieAlbaran').AsString) + '",' +
      '"NumeroAlbaran":' + Q.FieldByName('NumeroAlbaran').AsString + ',' +
      '"Orden":' + Q.FieldByName('Orden').AsString + ',' +
      '"LineasPosicion":"' + JSON_Str(Q.FieldByName('LineasPosicion').AsString) + '",' +
      '"LineaPedido":"' + JSON_Str(Q.FieldByName('LineaPedido').AsString) + '",' +
      '"FechaRegistro":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaRegistro').AsDateTime) + '",' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
      '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"SuPedido":"' + JSON_Str(Q.FieldByName('SuPedido').AsString) + '",' +
      '"Unidades":' + SQL_FloatToStr(Q.FieldByName('Unidades').AsFloat) + ',' +
      '"UnidadesServidas":' + SQL_FloatToStr(Q.FieldByName('UnidadesServidas').AsFloat) + ',' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida1_').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1listLineasPedidoCompraAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EjercicioPedido: Integer;
  SeriePedido: String;
  NumeroPedido: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listLineasPedidoCompraAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Albaranes' );

  EjercicioPedido := StrToIntDef(request.contentfields.Values['EjercicioPedido'], 0 );
  if EjercicioPedido=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Ejercicio del pedido no especificado","Data":[]}';
    Exit;
  end;

  SeriePedido := trim(request.contentfields.Values['SeriePedido']);

  NumeroPedido := StrToIntDef(request.contentfields.Values['NumeroPedido'], 0 );
  if NumeroPedido=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Número del pedido no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  LineasPedidoProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioPedido = ' + IntToStr(EjercicioPedido) + ' AND ' +
          '  SeriePedido = ''' + SQL_Str(SeriePedido) + ''' AND ' +
          '  NumeroPedido = ' + IntToStr(NumeroPedido );

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  LineasPedidoProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioPedido = ' + IntToStr(EjercicioPedido) + ' AND ' +
          '  SeriePedido = ''' + SQL_Str(SeriePedido) + ''' AND ' +
          '  NumeroPedido = ' + IntToStr(NumeroPedido ) + ' ' +
          'ORDER BY ' +
          '  Orden ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
      '"SeriePedido":"' + Q.FieldByName('SeriePedido').AsString + '",' +
      '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
      '"Orden":' + Q.FieldByName('Orden').AsString + ',' +
      '"LineasPosicion":"' + Q.FieldByName('LineasPosicion').AsString + '",' +
      '"LineaPedidoCli":"' + Q.FieldByName('LineaPedidoCli').AsString + '",' +
      '"FechaRegistro":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaRegistro').AsDateTime) + '",' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"CodigoAlmacen":"' + Q.FieldByName('CodigoAlmacen').AsString + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
      '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"Estado":' + Q.FieldByName('Estado').AsString + ',' +
      '"FechaRecepcion":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaRecepcion').AsDateTime) + '",' +
      '"UnidadesPedidas":' + SQL_FloatToStr(Q.FieldByName('UnidadesPedidas').AsFloat) + ',' +
      '"UnidadesRecibidas":' + SQL_FloatToStr(Q.FieldByName('UnidadesRecibidas').AsFloat) + ',' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida1_').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1listLineasPedidoVentaAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EjercicioPedido: Integer;
  SeriePedido: String;
  NumeroPedido: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listLineasPedidoVentaAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  EjercicioPedido := StrToIntDef(request.contentfields.Values['EjercicioPedido'], 0 );
  if EjercicioPedido=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Ejercicio del pedido no especificado","Data":[]}';
    Exit;
  end;

  SeriePedido := trim(request.contentfields.Values['SeriePedido']);

  NumeroPedido := StrToIntDef(request.contentfields.Values['NumeroPedido'], 0 );
  if NumeroPedido=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Número del pedido no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  LineasPedidoCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioPedido = ' + IntToStr(EjercicioPedido) + ' AND ' +
          '  SeriePedido = ''' + SQL_Str(SeriePedido) + ''' AND ' +
          '  NumeroPedido = ' + IntToStr(NumeroPedido );

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  LineasPedidoCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  EjercicioPedido = ' + IntToStr(EjercicioPedido) + ' AND ' +
          '  SeriePedido = ''' + SQL_Str(SeriePedido) + ''' AND ' +
          '  NumeroPedido = ' + IntToStr(NumeroPedido ) + ' ' +
          'ORDER BY ' +
          '  Orden ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
      '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
      '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
      '"Orden":' + Q.FieldByName('Orden').AsString + ',' +
      '"LineasPosicion":"' + JSON_Str(Q.FieldByName('LineasPosicion').AsString) + '",' +
      '"FechaRegistro":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaRegistro').AsDateTime) + '",' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
      '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"CodigodelCliente":"' + JSON_Str(Q.FieldByName('CodigodelCliente').AsString) + '",' +
      '"CodigoProveedor":"' + JSON_Str(Q.FieldByName('CodigoProveedor').AsString) + '",' +
      '"FechaEntrega":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaEntrega').AsDateTime) + '",' +
      '"SuPedido":"' + JSON_Str(Q.FieldByName('SuPedido').AsString) + '",' +
      '"Estado":' + Q.FieldByName('Estado').AsString + ',' +
      '"CodigoColor_":"' + JSON_Str(Q.FieldByName('CodigoColor_').AsString) + '",' +
      '"GrupoTalla_":"' + JSON_Str(Q.FieldByName('GrupoTalla_').AsString) + '",' +
      '"CodigoTalla01_":"' + JSON_Str(Q.FieldByName('CodigoTalla01_').AsString) + '",' +
      '"UnidadesPedidas":' + SQL_FloatToStr(Q.FieldByName('UnidadesPedidas').AsFloat) + ',' +
      '"UnidadesServidas":' + SQL_FloatToStr(Q.FieldByName('UnidadesServidas').AsFloat) + ',' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida1_').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

{$ENDREGION}


{$REGION '--- FUNCIONS DE MAGATZEM'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE MAGATEMS D'UNA EMPRESA                                     │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listAlmacenesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listAlmacenesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Almacenes ( ' + IntToStr(CodigoEmpresa) + ' ) ';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  CodigoEmpresa, CodigoAlmacen, Almacen, Domicilio, CodigoPostal, Municipio, Provincia ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Almacenes ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'ORDER BY ' +
          '  CodigoEmpresa, CodigoAlmacen ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ', ' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"Almacen":"' + JSON_Str(Q.FieldByName('Almacen').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'ALTURES D'UNA ESTANTERIA                                    │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listAlturasAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  CodigoPasillo: String;
  CodigoEstanteria: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listAlturasAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  CodigoPasillo := request.contentfields.values['CodigoPasillo'];
  if CodigoPasillo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de pasillo no especificado","Data":[]}';
    Exit;
  end;

  CodigoEstanteria := request.contentfields.values['CodigoEstanteria'];
  if CodigoEstanteria='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de estantería no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT Altura) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  CodigoPasillo = ''' + SQL_Str(CodigoPasillo) + ''' AND ' +
          '  CodigoEstanteria = ''' + SQL_Str(CodigoEstanteria) + ''' ';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  DISTINCT Altura ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  CodigoPasillo = ''' + SQL_Str(CodigoPasillo) + ''' AND ' +
          '  CodigoEstanteria = ''' + SQL_Str(CodigoEstanteria) + ''' ' +
          'ORDER BY ' +
          '  Altura ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"Altura":"' + JSON_Str(Q.FieldByName('Altura').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'ARTICLES D'UNA EMPRESA                                      │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listArticulosAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  Filtro: String;
  Ejercicio: Integer;
  sAndWhere: String;
  CodigoFamilia: String;
  CodigoSubfamilia: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listArticulosAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  CodigoFamilia    := Trim(request.contentfields.values['CodigoFamilia']);
  CodigoSubfamilia := Trim(request.contentfields.values['CodigoSubfamilia']);
  Filtro           := Trim(request.contentfields.values['Filtro']);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if CodigoFamilia<>'' then begin
    sAndWhere := sAndWhere + 'AND ' +
      'CodigoFamilia=''' + SQL_Str(CodigoFamilia) + ''' ';
  end;

  if Codigosubfamilia<>'' then begin
    sAndWhere := sAndWhere + 'AND ' +
      'CodigoSubfamilia=''' + SQL_Str(CodigoSubfamilia) + ''' ';
  end;

  if Filtro<>'' then begin
    sAndWhere := sAndWhere + 'AND ( ' +
      'CodigoArticulo LIKE ''%' + SQL_Str(Filtro) + '%'' OR ' +
      'DescripcionArticulo LIKE ''%' + SQL_Str(Filtro) + '%'' ' +
      ' ) ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  TipoArticulo = ''M'' ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  1 = 1 ' +
          sAndWhere +
          'ORDER BY ' +
          '  CodigoArticulo ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
      '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
      '"TratamientoPartidas":' + Q.FieldByName('TratamientoPartidas').AsString +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'ARTICLES D'UNA RECEPCIÓ                                     │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listArticulosRecepcionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  RecepcionId: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRechazos: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listArticulosRecepcionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  RecepcionId := StrToIntDef(request.contentfields.values['RecepcionId'],0);
  if RecepcionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );
  OrdenarPor    := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden     := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy      := '';

  if OrdenarPor='PEDIDO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.EjercicioPedido DESC, fsrl.SeriePedido DESC, fsrl.NumeroPedido DESC, fsrl.OrdenLineaPedido ';
    end else begin
      sOrderBy := 'fsrl.EjercicioPedido, fsrl.SeriePedido, fsrl.NumeroPedido, fsrl.OrdenLineaPedido ';
    end;
  end else if OrdenarPor='ESTADO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.UdSaldo DESC ';
    end else begin
      sOrderBy := 'fsrl.UdSaldo ';
    end;
  end else if OrdenarPor='ARTICULO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.CodigoArticulo DESC, fsrl.Partida DESC ';
    end else begin
      sOrderBy := 'fsrl.CodigoArticulo, fsrl.Partida ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsrl.RecepcionIdLinea DESC ';
    end else begin
      sOrderBy := 'fsrl.RecepcionIdLinea ';
    end;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcion,         CodigoUbicacionRecepcion, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcionRechazos, CodigoUbicacionRechazos, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Recepciones_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  RecepcionId = ' + IntToStr(RecepcionId);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fsrl.*, ' +
          '  art.TratamientoPartidas, art.CodigoAlternativo ' +
          'FROM ' +
          '  FS_SGA_Recepciones_Lineas fsrl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  fsrl.CodigoArticulo = art.CodigoArticulo ' +
          'WHERE ' +
          '  fsrl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsrl.RecepcionId = ' + IntToStr(RecepcionId) + ' ' +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
                       '"RecepcionId":"' + Q.FieldByName('RecepcionId').AsString + '",' +
                       '"RecepcionIdLinea":"' + Q.FieldByName('RecepcionIdLinea').AsString + '",' +
                       '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
                       '"EjercicioPedido":"' + Q.FieldByName('EjercicioPedido').AsString + '",' +
                       '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
                       '"NumeroPedido":"' + Q.FieldByName('NumeroPedido').AsString + '",' +
                       '"OrdenLineaPedido":"' + Q.FieldByName('OrdenLineaPedido').AsString + '",' +
                       '"LineasPosicion":"' + Q.FieldByName('LineasPosicion').AsString + '",' +
                       '"UdPedidas":"' + SQL_FloatToStr(Q.FieldByName('UdPedidas').AsFloat) + '",' +
                       '"UdRecibidas":"' + SQL_FloatToStr(Q.FieldByName('UdRecibidas').AsFloat) + '",' +
                       '"UdSaldo":"' + SQL_FloatToStr(Q.FieldByName('UdSaldo').AsFloat) + '",' +
                       '"Precio":"' + SQL_FloatToStr(Q.FieldByName('Precio').AsFloat) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
                       '"CodigoProveedor":"' + JSON_Str(Q.FieldByName('CodigoProveedor').AsString) + '",' +
                       '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
                       '"IdAlbaranPro":"' + JSON_Str(Q.FieldByName('IdAlbaranPro').AsString) + '",' +
                       '"Albaran":"' + JSON_Str(Q.FieldByName('Albaran').AsString) + '",' +
                       '"FechaRecepcion":"' + Q.FieldByName('FechaRecepcion').AsString + '",' +
                       '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida1_').AsString) + '"' +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ RETORNA EL LLISTAT D'UBICACIONS D'UN ARTICLE                          │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listUbicacionesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  sCodigoArticulo: String;
  YY: WORD;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoAlmacen: String;
  sAndWhere: String;
  Partida: string;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listUbicacionesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  sCodigoArticulo := request.contentfields.values['CodigoArticulo'];

  // Conversió al codi d'article real
  sCodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, sCodigoArticulo );

  if sCodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  (*
  CodigoAlmacen := trim(request.contentfields.values['CodigoAlmacen']);
  if CodigoAlmacen='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  *)

  Partida := trim(request.contentfields.values['Partida']);
  YY      := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if (CodigoAlmacen<>'') and (CodigoAlmacen<>'-1') then begin
    sAndWhere := sAndWhere + ' AND fsas.CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';
  end;

  if Partida<>'' then begin
    sAndWhere := sAndWhere + ' AND fsas.Partida=''' + SQL_Str(Partida) + ''' ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsas ' +
          'INNER JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) a ' +
          'ON ' +
          '  fsas.CodigoArticulo = a.CodigoArticulo ' +
          'WHERE ' +
          '  fsas.CodigoArticulo = ''' + SQL_Str(sCodigoArticulo) + ''' AND ' +
          '  fsas.Periodo = 99 AND ' +
          '  fsas.Ejercicio = ' + IntToStr(YY) + ' ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          ' fsas.*, a.DescripcionArticulo, u.CodigoZona, u.NombreZona  ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsas ' +
          'INNER JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' )  a ' +
          'ON ' +
          '  fsas.CodigoArticulo = a.CodigoArticulo ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) u ' +
          'ON ' +
          '  u.CodigoAlmacen = fsas.CodigoAlmacen AND ' +
          '  u.CodigoUbicacion = fsas.CodigoUbicacion ' +
          'WHERE ' +
          '  fsas.CodigoArticulo = ''' + SQL_Str(sCodigoArticulo) + ''' AND ' +
          '  fsas.Periodo = 99 AND ' +
          '  fsas.Ejercicio = ' + IntToStr(YY) + ' ' +
          sAndWhere +
          'ORDER BY ' +
          '  fsas.CodigoAlmacen, fsas.CodigoUbicacion, fsas.Partida ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ', ' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"CodigoZona":"' + JSON_Str(Q.FieldByName('CodigoZona').AsString) + '",' +
      '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
      '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoUbicacionAlternativo').AsString) + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"UnidadesSaldo":' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat ) + ',' +
      '"FechaPrimeraEntrada":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaPrimeraEntrada').AsDateTime ) + '",' +
      '"FechaUltimaSalida":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaUltimaSalida').AsDateTime ) + '",' +
      '"FechaCaduca":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaCaduca').AsDateTime ) + '",' +
      '"TratamientoPartidas":"' + JSON_Str(Q.FieldByName('TratamientoPartidas').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1listUbicacionesFavoritasAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Tipo: String;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  Result: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listUbicacionesFavoritasAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_UbicacionesFavoritas ( ' + IntToStr(CodigoEmpresa) + ' ) ';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fsuf.*, fstu.CodigoAlternativo, fstu.CodigoAlmacen ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_UbicacionesFavoritas ( ' + IntToStr(CodigoEmpresa) + ' ) fsuf ' +
          'INNER JOIN ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) fstu ' +
          'ON ' +
          '  fsuf.ubifav_CodigoUbicacion = fstu.CodigoUbicacion ' +
          'ORDER BY ' +
          '  ubifav_order ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('ubifav_CodigoUbicacion').AsString) + '",' +
      '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
      '"Descripcion":"' + JSON_Str(Q.FieldByName('ubifav_Descripcion').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ RETORNA EL LLISTAT DE MOVIMENTS D'UN ARTICLE                          │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1movimientosArticuloAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  CodigoArticulo: String;
  YY: WORD;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoAlmacen: String;
  sAndWhere: String;
  EmpresaOrigen: Integer;
  Partida: String;
  CodigoUbicacion: String;
  aUbicacion: TSGAUbicacion;
  TipoMovimiento: Integer;
  CodigoUsuario: Integer;
  Fecha: TDate;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1movimientosArticuloAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoArticulo := trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo<>'' then begin
    if SGA_ALMACEN_ArticuloCorrecto ( Conn, EmpresaOrigen, CodigoArticulo )<>CodigoArticulo then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo incorrecto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  CodigoAlmacen := trim(request.contentfields.values['CodigoAlmacen']);
  if CodigoAlmacen<>'' then begin
    if SGA_ALMACEN_AlmacenCorrecto ( Conn, EmpresaOrigen, CodigoAlmacen )<>CodigoAlmacen then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén incorrecto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  CodigoUbicacion := trim(request.contentfields.values['CodigoUbicacion']);

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion<>'' then begin
    aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacion );
    if aUbicacion.CodigoUbicacion='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación incorrecto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  CodigoUsuario  := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );
  TipoMovimiento := StrToIntDef(request.contentfields.values['TipoMovimiento'], 0 );
  Partida        := trim(request.contentfields.values['Partida']);
  Fecha          := StrToDateDef(request.contentfields.Values['Fecha'], 0);
  YY             := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if CodigoAlmacen<>'' then begin
    sAndWhere := sAndWhere + 'AND CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';
  end;

  if CodigoUbicacion<>'' then begin
    sAndWhere := sAndWhere + 'AND CodigoUbicacion=''' + SQL_Str(CodigoUbicacion) + ''' ';
  end;

  if CodigoArticulo<>'' then begin
    sAndWhere := sAndWhere + 'AND CodigoArticulo=''' + SQL_Str(CodigoArticulo) + ''' ';
  end;

  if Partida<>'' then begin
    sAndWhere := sAndWhere + 'AND Partida=''' + SQL_Str(Partida) + ''' ';
  end;

  if CodigoUsuario<>0 then begin
    sAndWhere := sAndWhere + 'AND CodigoUsuario = ' + IntToStr(CodigoUsuario) + ' ';
  end;

  if TipoMovimiento<>0 then begin
    sAndWhere := sAndWhere + 'AND TipoMovimiento = ' + IntToStr(TipoMovimiento) + ' ';
  end;

  if Fecha<>0 then begin
    sAndWhere := sAndWhere + 'AND Fecha = ' + SQL_DateToStr ( Fecha ) + ' ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Movimientos ( ' + IntToStr(CodigoEmpresa) + ' ) fsma ' +
          'WHERE ' +
          '  fsma.Periodo BETWEEN 1 AND 12 AND ' +
          '  fsma.Ejercicio = ' + IntToStr(YY) + ' ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  *  ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Movimientos ( ' + IntToStr(CodigoEmpresa) + ' ) fsma ' +
          'WHERE ' +
          '  fsma.Periodo BETWEEN 1 AND 12 AND ' +
          '  fsma.Ejercicio = ' + IntToStr(YY) + ' ' +
          sAndWhere +
          'ORDER BY ' +
          '  fsma.FechaHora DESC ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"IdMovimiento":' + Q.FieldByName('IdMovimiento').AsString + ', ' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ', ' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"CodigoZona":"' + JSON_Str(Q.FieldByName('CodigoZona').AsString) + '",' +
      '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
      '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoArticuloAlternativo').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"Fecha":"' + JSON_Str(FormatDateTime('dd/mm/yyyy', Trunc(Q.FieldByName('FechaHora').AsDateTime) )) + '",' +
      '"FechaRegistro":"' + JSON_Str(FormatDateTime('dd/mm/yyyy hh:nn:ss', Q.FieldByName('FechaHora').AsDateTime )) + '",' +
      '"TipoMovimiento":' + Q.FieldByName('TipoMovimiento').AsString + ',' +
      '"OrigenMovimiento":"' + JSON_Str(Q.FieldByName('OrigenMovimiento').AsString) + '",' +
      '"Unidades":' + SQL_FloatToStr(Q.FieldByName('Unidades').AsFloat ) + ',' +
      '"CodigoUsuario":' + Q.FieldByName('CodigoUsuario').AsString + ',' +
      '"NombreUsuario":"' + JSON_Str(Q.FieldByName('NombreUsuario').AsString) + '",' +
      '"Comentario":"' + JSON_Str(Q.FieldByName('Comentario').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'UBICACIONS AMB STOCK PER PREPARAR UNA LÍNIA DE COMANDA      │
// │ JUNTAMENT AMB LES UBICACIONS BUIDES PERÒ QUE S'HAN FET SERVIR         │
// │ PER PREPARAR LA MATEIXA LÍNIA DE COMANDA                              │
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1preparacionCalcularIndiceAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  Indice: Integer;
  MostrarPartidas: Integer;
  sTable: string;
  CodigoAlmacen: String;
  CodigoArticulo: String;
  sUbicaciones: String;
  Partida: String;
  bError: Boolean;
  Pendientes: Integer;
  SoloConStock: Integer;
  CodigoUbicacion: String;
  CodigoUbicacionExpedicion: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1preparacionCalcularIndiceAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  MostrarPartidas := 1; // StrToIntDef(request.contentfields.values['MostrarPartidas'],0);
  Pendientes      := StrToIntDef(request.contentfields.values['Pendientes'],0);
  SoloConStock    := StrToIntDef(request.contentfields.values['SoloConStock'],0);

  CodigoUbicacion := Trim(request.contentfields.values['CodigoUbicacion']);
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  OrdenarPor    := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden     := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy      := '';
  CodigoAlmacen := Trim(request.ContentFields.Values['CodigoAlmacen']);

  // Temporal
  //if CodigoAlmacen='' then
  //  CodigoAlmacen := 'ALM1';

  if OrdenarPor='ARTICULO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo, Partida ';
    end;
  end else if OrdenarPor='CODIGOUBICACION' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacion DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacion ';
    end;
  end else if OrdenarPor='CODIGOUBICACIONALTERNATIVO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacionAlternativo DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacionAlternativo ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo DESC, Partida ';
    end;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, EmpresaOrigen );

  if CodigoAlmacen='' then begin
    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacionExpedicion );
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  if MostrarPartidas=0 then sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo'
  else sTable := 'FS_SGA_TABLE_PreparacionDetallesPartidaPeriodo';

  sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo';

  sSQL := 'SELECT TOP 1 rn ' +
          'FROM FS_SGA_PreparacionOrdenada WITH (NOLOCK) ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  ISNULL(CodigoUbicacion,''zzzzzzzzzz'') >= ''' + SQL_Str(CodigoUbicacion) + ''' ';

  if Pendientes=1 then
     sSQL := sSQL + 'AND UdNecesarias >= Udretiradas ';

  if SoloConStock=1 then
     sSQL := sSQL + 'AND CodigoUbicacion IS NOT NULL ';

  sSQL := sSQL + 'ORDER BY ' + sOrderBy;

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"SQL":"' + JSON_Str(sSQL) + '","Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  if Q.EOF then Indice := 0
  else begin

    //if CodigoUbicacion=Q.FieldByName('CodigoUbicacion').AsString then
      Indice := Q.FieldByName('rn').AsInteger - 1
   // else
   //  Indice := Q.FieldByName('rn').AsInteger;

  end;

  Q.Close;
  FreeAndNil(Q);

  Request.QueryFields.AddPair('Indice', IntToStr(Indice) );
  Request.ContentFields.AddPair('Indice', IntToStr(Indice) );
  Request.ContentFields.AddPair('LogID', sIDCall );

  Request.QueryFields.AddPair('SQL', sSQL );
  Request.ContentFields.AddPair('SQL', sSQL );

  WebModule1detallePreparacionOrdenAction ( Sender, Request, Response, Handled );
  Exit;

  {$ENDREGION}

end;


(*
procedure WebModule1preparacionCalcularIndiceActionOld(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  Indice: Integer;
  MostrarPartidas: Integer;
  sTable: string;
  CodigoAlmacen: String;
  CodigoArticulo: String;
  sUbicaciones: String;
  Partida: String;
  bError: Boolean;
  Pendientes: Integer;
  SoloConStock: Integer;
  CodigoUbicacion: String;
  CodigoUbicacionExpedicion: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1preparacionCalcularIndiceAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  MostrarPartidas := 1; // StrToIntDef(request.contentfields.values['MostrarPartidas'],0);
  Pendientes      := StrToIntDef(request.contentfields.values['Pendientes'],0);
  SoloConStock    := StrToIntDef(request.contentfields.values['SoloConStock'],0);

  CodigoUbicacion := Trim(request.contentfields.values['CodigoUbicacion']);
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  OrdenarPor    := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden     := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy      := '';
  CodigoAlmacen := Trim(request.ContentFields.Values['CodigoAlmacen']);

  // Temporal
  //if CodigoAlmacen='' then
  //  CodigoAlmacen := 'ALM1';

  if OrdenarPor='ARTICULO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo, Partida ';
    end;
  end else if OrdenarPor='CODIGOUBICACION' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacion DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacion ';
    end;
  end else if OrdenarPor='CODIGOUBICACIONALTERNATIVO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacionAlternativo DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacionAlternativo ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoArticulo DESC, Partida DESC ';
    end else begin
      sOrderBy := 'CodigoArticulo DESC, Partida ';
    end;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, EmpresaOrigen );

  if CodigoAlmacen='' then begin
    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacionExpedicion );
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  if MostrarPartidas=0 then sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo'
  else sTable := 'FS_SGA_TABLE_PreparacionDetallesPartidaPeriodo';

  sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo';

  sSQL := 'SELECT TOP 1 * ' +
          'FROM ( ' +
          '  SELECT ' +
          '    ROW_NUMBER() OVER ( ORDER BY CASE WHEN CodigoUbicacion IN ( ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ) OR CodigoUbicacion IS NULL THEN ''zzz'' ELSE CodigoUbicacion END ) AS rn, * ' +
          '  FROM ' +
          sTable + ' ( ' + IntToStr(EmpresaOrigen) + ', ' + IntToStr(IdPreparacion) + ', ''' + SQL_Str(CodigoUbicacionExpedicion) + ''', ' + IntToStr(YY) + ', ''' + SQL_Str(CodigoAlmacen) + ''' ) ' +
          '  ) q ' +
          'WHERE '+
          '  CodigoUbicacion >= ''' + SQL_Str(CodigoUbicacion) + ''' ';

  if Pendientes=1 then
     sSQL := sSQL + 'AND UdNecesarias >= Udretiradas ';

  if SoloConStock=1 then
     sSQL := sSQL + 'AND CodigoUbicacion IS NOT NULL ';

  sSQL := sSQL + 'ORDER BY ' + sOrderBy;

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"SQL":"' + JSON_Str(sSQL) + '","Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  if Q.EOF then Indice := 0
  else begin

    //if CodigoUbicacion=Q.FieldByName('CodigoUbicacion').AsString then
      Indice := Q.FieldByName('rn').AsInteger - 1
   // else
   //  Indice := Q.FieldByName('rn').AsInteger;

  end;

  Q.Close;
  FreeAndNil(Q);

  Request.QueryFields.AddPair('Indice', IntToStr(Indice) );
  Request.ContentFields.AddPair('Indice', IntToStr(Indice) );

  Request.QueryFields.AddPair('SQL', sSQL );
  Request.ContentFields.AddPair('SQL', sSQL );

  WebModule1detallePreparacionOrdenAction ( Sender, Request, Response, Handled );
  Exit;

  {$ENDREGION}

end;
*)

procedure WebModule1preparacionUbicacionesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  PickingId: Integer;
  MostrarAlmacenes: Integer;
  MostrarPartidas: Integer;
  sMostrarAlmacenes: String;
  sMostrarPartidas: String;
  CodigoAlmacen: String;
  Partida: String;
  YY: WORD;
  sFechaUltimaEntrada: string;
  FechaUltimaEntrada: TDateTime;
  FechaCaduca: TDateTime;
  sFechaCaduca: string;
  TratamientoPartidas: Boolean;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1preparacionUbicacionesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoArticulo := Trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  TratamientoPartidas := ARTICULO_TratamientoPartida ( Conn, CodigoEmpresa, CodigoArticulo );

  Partida := Trim(request.contentfields.values['Partida']);
  if (Partida='') and (TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de partida no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoAlmacen := Trim(request.contentfields.values['CodigoAlmacen']);
  if (CodigoAlmacen='') and (TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if (Partida<>'') and (not TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no requiere partida","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  YY               := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );
  MostrarAlmacenes := StrToIntDef(request.contentfields.values['MostrarAlmacenes'],0);
  MostrarPartidas  := StrToIntDef(request.contentfields.values['MostrarPartidas'],0);
  OrdenarPor       := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden        := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy         := '';

  if OrdenarPor='CANTIDAD' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'UnidadesSaldo DESC ';
    end else begin
      sOrderBy := 'UnidadesSaldo ';
    end;
  end else if OrdenarPor='UBICACION' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacion DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacion ';
    end;
  end else if OrdenarPor='PARTIDA' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'Partida DESC ';
    end else begin
      sOrderBy := 'Partida ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'CodigoUbicacion DESC ';
    end else begin
      sOrderBy := 'CodigoUbicacion ';
    end;
  end;

  sMostrarAlmacenes := '';
  MostrarAlmacenes  := 0;
  if MostrarAlmacenes<>1 then begin
    sMostrarAlmacenes := 'AND CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';
  end;

  sMostrarPartidas := '';
  if MostrarPartidas<>1 then begin
    sMostrarPartidas := 'AND Partida=''' + SQL_Str(Partida) + ''' ';
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals i dades'}

  sSQL := 'SELECT ' +
          '  CodigoAlmacen, Almacen, CodigoZona, NombreZona, CodigoUbicacion, CodigoPasillo, ' +
          '  DescripcionPasillo, CodigoEstanteria, Altura, Fondo, Picking, Bloqueada, Inactiva, ' +
          '  MultiRef, MultiLote, Rotacion, CodigoArticulo, Partida, ' +
          '  CodigoFamilia, CodigoSubfamilia, CodigoAlternativo, codigoUbicacionAlternativo, ' +
          '  CodigoAlternativo2, TratamientoPartidas, ' +
          '  SUM(UnidadesSaldo) AS UnidadesSaldo, SUM(UnidadesUsadas) AS UnidadesUsadas, ' +
          '  MIN(FechaPrimeraEntrada) AS FechaPrimeraEntrada, MIN(FechaUltimaEntrada) AS FechaUltimaEntrada, ' +
          '  MAX(FechaUltimaSalida) AS FechaUltimaSalida, MIN(FechaCaduca) AS FechaCaduca ' +
          'FROM ' +
          '  FS_SGA_TABLE_UbicacionsPickingPedidos ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  Ejercicio = ' + IntToStr ( YY ) + ' AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' ' +
          sMostrarAlmacenes +
          sMostrarPartidas +
          'GROUP BY ' +
          '  CodigoAlmacen, Almacen, CodigoZona, NombreZona, CodigoUbicacion, CodigoPasillo, ' +
          '  DescripcionPasillo, CodigoEstanteria, Altura, Fondo, Picking, Bloqueada, Inactiva, ' +
          '  MultiRef, MultiLote, Rotacion, CodigoArticulo, Partida, ' +
          '  CodigoFamilia, CodigoSubfamilia, CodigoAlternativo, codigoUbicacionAlternativo, ' +
          '  CodigoAlternativo2, TratamientoPartidas ';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
    iTotalRegs := Q.RecordCount;
  except
    on E:Exception do begin
      FreeAndNil(Q);
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  sSQL := sSQL + 'ORDER BY ' +
                 sOrderBy +
                 'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
                 'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q.Close;
  Q.SQL.Text := sSQL;
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    FechaUltimaEntrada := Q.FieldByName('FechaUltimaEntrada').AsDateTime;
    if FechaUltimaEntrada=0 then
      FechaUltimaEntrada := Q.FieldByName('FechaPrimeraEntrada').AsDateTime;
    if FechaUltimaEntrada=0 then
      sFechaUltimaEntrada := ''
    else
      sFechaUltimaEntrada := FormatDateTime('dd/mm/yyyy',FechaUltimaEntrada);

    FechaCaduca := Q.FieldByName('FechaCaduca').AsDateTime;
    if FechaCaduca=0 then
      sFechaCaduca := ''
    else
      sFechaCaduca := FormatDateTime('dd/mm/yyyy',FechaCaduca);

    Result := Result + '{' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
                       '"Almacen":"' + JSON_Str(Q.FieldByName('Almacen').AsString) + '",' +
                       '"CodigoZona":"' + JSON_Str(Q.FieldByName('CodigoZona').AsString) + '",' +
                       '"NombreZona":"' + JSON_Str(Q.FieldByName('NombreZona').AsString) + '",' +
                       '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
                       '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('codigoUbicacionAlternativo').AsString) + '",' +
                       '"CodigoPasillo":"' + JSON_Str(Q.FieldByName('CodigoPasillo').AsString) + '",' +
                       '"DescripcionPasillo":"' + JSON_Str(Q.FieldByName('DescripcionPasillo').AsString) + '",' +
                       '"CodigoEstanteria":"' + JSON_Str(Q.FieldByName('CodigoEstanteria').AsString) + '",' +
                       '"Altura":"' + JSON_Str(Q.FieldByName('Altura').AsString) + '",' +
                       '"Fondo":"' + JSON_Str(Q.FieldByName('Fondo').AsString) + '",' +
                       '"Picking":"' + SQL_BooleanToStr(Q.FieldByName('Picking').AsBoolean) + '",' +
                       '"Bloqueada":"' + SQL_BooleanToStr(Q.FieldByName('Bloqueada').AsBoolean) + '",' +
                       '"Inactiva":"' + SQL_BooleanToStr(Q.FieldByName('Inactiva').AsBoolean) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"UnidadesSaldo":"' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat) + '",' +
                       '"FechaUltimaEntrada":"' + sFechaUltimaEntrada + '",' +
                       '"FechaCaduca":"' + sFechaCaduca + '",' +
                       '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
                       '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
                       '"TratamientoPartidas":"' + JSON_Str(Q.FieldByName('TratamientoPartidas').AsString) + '",' +
                       '"UnidadesUsadas":"' + SQL_FloatToStr(Q.FieldByName('UnidadesUsadas').AsFloat) + '"' +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1prepareServirPrepAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  sIDCall: String;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  IdPreparacion: Integer;
  CodigoUsuario: Integer;
  UnidadesExpedidas: Integer;
  SP: TServirPreparacion;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1prepareServirPrepAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de preparación no es correcto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  // Verifiquem que hi hagi quantitats expedides
  UnidadesExpedidas := FS_SGA_UnidadesExpedidas ( Conn, IdPreparacion );
  if UnidadesExpedidas <= 0 then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No hay ninguna unidad expedida en la preparación","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if not FS_SGA_GetServirPrepStats ( Conn, IdPreparacion, SP ) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha podido recuperar la información de la preparación","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  Result := '{"Result":"OK","Error":"","Data":[{' +
    '"LineasAPreparar":' + IntToStr(SP.LineasAPreparar) + ',' +
    '"LineasPreparadas":' + IntToStr(SP.LineasPreparadas) + ',' +
    '"LineasAExpedir":' + IntToStr(SP.LineasAExpedir) + ',' +
    '"LineasExpedidas":' + IntToStr(SP.LineasExpedidas) + ',' +
    '"Cajas":' + IntToStr(SP.Cajas) + ',' +
    '"Palets":' + IntToStr(SP.Palets) + '}]}';

  Response.Content := Result;

end;

procedure WebModule1prepareServirRecAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  sIDCall: String;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  IdRecepcion: Integer;
  CodigoUsuario: Integer;
  UnidadesExpedidas: Integer;
  SR: TServirRecepcion;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1prepareServirRecAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  IdRecepcion := StrToIntDef(request.contentfields.values['IdRecepcion'],0);
  if IdRecepcion=0 then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de recepción no es correcto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  if not FS_SGA_GetServirRecStats ( Conn, IdRecepcion, SR ) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha podido recuperar la información de la recepción","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  Result := '{"Result":"OK","Error":"","Data":[{' +
    '"Articulos":' + IntToStr(SR.Articulos) + ',' +
    '"LineasARecibir":' + IntToStr(SR.LineasARecibir) + ',' +
    '"LineasRecibidas":' + IntToStr(SR.LineasRecibidas) + ',' +
    '"Cajas":' + IntToStr(SR.Cajas) + ',' +
    '"Palets":' + IntToStr(SR.Palets) + '}]}';

  Response.Content := Result;

end;

procedure WebModule1generarInformeAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  sIDCall: String;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  IdInforme: Integer;
  IdObjeto: Integer;
  CodigoUsuario: Integer;
  sParams: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1generarInformeAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  IdInforme := StrToIntDef(request.contentfields.values['Informe'],0);
  if IdInforme=0 then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de informe no es correcto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  IdObjeto := StrToIntDef(request.contentfields.values['Objeto'],0);
  if IdObjeto=0 then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de objeto no es correcto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  {$ENDREGION}

  {$REGION 'Enviem l'operació al LicenseServer'}

  sParams := '{' +
    '"CodigoEmpresa":' + IntToStr(CodigoEmpresa) + ',' +
    '"Informe":' + IntToStr(IdInforme) + ',' +
    '"Objeto":' + IntToStr(IdObjeto) + ',' +
    '"Usuario":' + IntToStr(CodigoUsuario) +
  '}';

  sSQL := 'INSERT INTO ' +
          '  FS_Operations ( oper_product_code, oper_name, oper_ip_address, oper_datetime,' +
          '  oper_params, oper_CodigoEmpresa ) ' +
          'VALUES ( ' +
          '''' + SQL_Str(CONST_SGAWEBSERVICE) + ''', ' +
          '''GENERARINFORME'', ' +
          '''' + SQL_Str(Request.RemoteAddr) + ''', ' +
          SQL_DateTimeToStr ( Now() ) + ', ' +
          '''' + sParams + ''', ' +
          IntToStr(CodigoEmpresa) + ' )';

  try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(E.Message) + '","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  {$ENDREGION}

  Result := '{"Result":"OK","Error":"","Data":[]}';
  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'ARTICLES D'UNA UBICACIÓ DEL MAGATZEM                        │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1getArticuloDetailsAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoArticulo: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  EmpresaOrigen: Integer;
  JSonUnidadesMedida: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1getArticuloDetailsAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  CodigoArticulo := request.contentfields.values['CodigoArticulo'];

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  // Recuperem les unitats de mesura

  JSonUnidadesMedida := SGA_FS_ARTICULO_Obtener_UnidadesMedida ( Conn, CodigoEmpresa, CodigoArticulo );

  sSQL := 'SELECT ' +
          '  art.* ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'WHERE ' +
          '  (art.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' OR ' +
          '  art.CodigoAlternativo = ''' + SQL_Str(CodigoArticulo) + ''' OR ' +
          '  art.CodigoAlternativo2 = ''' + SQL_Str(CodigoArticulo) + ''') ';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  Result := '{"Result":"OK","Error":"","Data":[';

  if not Q.Eof then begin

    Result := Result +
      '{' +
      '"Tipo":1,' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"TratamientoPartidas":' + Q.FieldByName('TratamientoPartidas').AsString + ',' +
      JSonUnidadesMedida +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'ARTICLES D'UNA UBICACIÓ DEL MAGATZEM                        │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1getArticulosAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoUbicacion: string;
  Ejercicio: Integer;
  EmpresaOrigen: Integer;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  CodigoArticulo: string;
  sFiltre: string;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1getArticulosAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  CodigoUbicacion := trim(request.contentfields.values['CodigoUbicacion']);

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );
  if CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
    Exit;
  end;

  CodigoArticulo := trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  if CodigoArticulo<>'' then begin
    CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );
    if CodigoArticulo='' then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo especificado incorrecto","Data":[]}';
      Exit;
    end;
  end;

  Ejercicio := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='FECHAENTRADA' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsas.FechaUltimaEntrada DESC, fsas.CodigoArticulo DESC, fsas.Partida DESC ';
    end else begin
      sOrderBy := 'fsas.FechaUltimaEntrada, fsas.CodigoArticulo, fsas.Partida ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'fsas.CodigoArticulo DESC, fsas.Partida DESC ';
    end else begin
      sOrderBy := 'fsas.CodigoArticulo, fsas.Partida ';
    end;
  end;

  sFiltre := '';
  if CodigoArticulo<>'' then begin
    sFiltre := 'AND fsas.CodigoArticulo=''' + SQL_Str(CodigoArticulo) + ''' ';
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsas ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + ''' AND ' +
          '  Ejercicio = ' + IntToStr(Ejercicio) + ' AND ' +
          '  Periodo = 99 AND ' +
          '  UnidadesSaldo <> 0 ' +
          sFiltre;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fsas.CodigoArticulo, fsas.Partida, fsas.UnidadesSaldo, a.DescripcionArticulo, a.TratamientoPartidas, ' +
          '  fsas.FechaUltimaEntrada, fsas.CodigoAlternativo, fsas.UnidadMedida, fsas.FechaCaduca ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsas ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) a ' +
          'ON ' +
          '  fsas.CodigoArticulo = a.CodigoArticulo ' +
          'WHERE ' +
          '  fsas.CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' AND ' +
          '  fsas.CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + ''' AND ' +
          '  fsas.Ejercicio = ' + IntToStr(Ejercicio) + ' AND ' +
          '  fsas.Periodo = 99 AND ' +
          '  fsas.UnidadesSaldo <> 0 ' +
          sFiltre +
          'ORDER BY ' +
          sOrderBy +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"SQL":"' + JSON_Str(sSQL) + '",' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
      '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
      '"FechaCaducidad":"' + JSON_Str(Q.FieldByName('FechaCaduca').AsString) + '",' +
      '"FechaUltimaEntrada":"' + JSON_Str(Q.FieldByName('FechaUltimaEntrada').AsString) + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"UnidadesSaldo":' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat) + ',' +
      '"TratamientoPartidas":' + Q.FieldByName('TratamientoPartidas').AsString +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE PASSADISSOS D'UN MAGATZEM                                  │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1getPasilloAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  CodigoZona: String;
  sAndWhere: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1getPasilloAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  CodigoZona := trim(request.contentfields.values['CodigoZona']);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if CodigoZona<>'' then begin
    sAndWhere := sAndWhere + ' AND u.CodigoZona = ''' + SQL_Str(CodigoZona) + ''' ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT p.CodigoPasillo) '+
          'FROM ' +
          ' 	FS_SGA_TABLE_ESTR_Pasillos ( ' + IntToStr(CodigoEmpresa) + ') p ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) u ' +
          'ON ' +
          '  p.CodigoPasillo = u.CodigoPasillo ' +
          'WHERE ' +
          '  p.CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  DISTINCT p.CodigoEmpresa, p.CodigoAlmacen, p.CodigoPasillo, p.DescripcionPasillo, p.Tipo '+
          'FROM ' +
          ' 	FS_SGA_TABLE_ESTR_Pasillos ( ' + IntToStr(CodigoEmpresa) + ') p ' +
          'LEFT JOIN ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) u ' +
          'ON ' +
          '  p.CodigoPasillo = u.CodigoPasillo ' +
          'WHERE ' +
          '  p.CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' ' +
          sAndWhere +
          'ORDER BY ' +
          '  CodigoPasillo ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoPasillo":"' + JSON_Str(Q.FieldByName('CodigoPasillo').AsString) + '",' +
      '"Tipo":"' + JSON_Str(Q.FieldByName('Tipo').AsString) + '",' +
      '"DescripcionPasillo":"' + JSON_Str(Q.FieldByName('DescripcionPasillo').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT D'UBICACIONS D'UNA ZONA DEL MAGATZEM                          │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1getUbicacionesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  CodigoZona: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoPasillo: String;
  CodigoEstanteria: String;
  andWhere: String;
  Tipo: String;
  CodigoArticulo: String;
  Partida: String;
  EmpresaOrigen: Integer;
  Pasillo: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1getUbicacionesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := trim(request.contentfields.values['CodigoAlmacen']);
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  Tipo             := AnsiUpperCase(trim(request.contentfields.values['Tipo']));
  CodigoArticulo   := AnsiUpperCase(trim(request.contentfields.values['CodigoArticulo']));
  Partida          := AnsiUpperCase(trim(request.contentfields.values['Partida']));
  CodigoZona       := trim(request.contentfields.values['CodigoZona']);
  CodigoPasillo    := trim(request.contentfields.values['CodigoPasillo']);
  CodigoEstanteria := trim(request.contentfields.values['CodigoEstanteria']);
  Pasillo          := trim(request.contentfields.values['Pasillo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  andWhere := '';

  if CodigoZona<>'' then begin
    andWhere := andWhere + ' AND fsu.CodigoZona = ''' + SQL_Str(CodigoZona) + ''' ';
  end;

  if CodigoPasillo<>'' then begin
    andWhere := andWhere + ' AND fsu.CodigoPasillo = ''' + SQL_Str(CodigoPasillo) + ''' ';
  end;

  if CodigoEstanteria<>'' then begin
    andWhere := andWhere + ' AND fsu.CodigoEstanteria = ''' + SQL_Str(CodigoEstanteria) + ''' ';
  end;

  if Pasillo<>'' then begin
    andWhere := andWhere + ' AND fsu.CodigoAlternativo LIKE ''' + SQL_Str(Pasillo) + '%'' ';
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT fsu.CodigoUbicacion) ' +
          'FROM ' +
          '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) fsu ' +
          'LEFT JOIN ' +
          '  FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsas ' +
          'ON ' +
          '  fsu.CodigoAlmacen = fsas.CodigoAlmacen AND ' +
          '  fsu.CodigoUbicacion = fsas.CodigoUbicacion ' +
          'WHERE ' +
          '  fsu.CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' ' +
          andWhere;

  if Tipo='EMPTY' then
    sSQL := sSQL + ' AND fsas.CodigoArticulo IS NULL'
  else begin
    if CodigoArticulo<>'' then
      sSQL := sSQL + ' AND fsas.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' ';
    if Partida<>'' then
      sSQL := sSQL + ' AND fsas.Partida = ''' + SQL_Str(Partida) + ''' ';
  end;

(*
  sSQL := 'SELECT ' +
          '  COUNT( * ) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' ' +
          andWhere;
*)

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT DISTINCT ' +
          '  fsu.CodigoAlmacen, fsu.CodigoZona, fsu.CodigoUbicacion, fsu.CodigoPasillo, fsu.CodigoEstanteria, ' +
          '  fsu.Altura, fsu.Fondo, fsu.CodigoAlternativo, fsu.Bloqueada, fsu.MultiRef, fsu.MonoRef, fsu.MultiLote, ' +
          '  fsu.Picking, fsu.Rotacion, fsu.Inactiva, fsas.CodigoArticulo, fsas.Partida, fsas.UnidadesSaldo, fsas.UnidadMedida ' +
          'FROM ' +
          '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) fsu ' +
          'LEFT JOIN ' +
          '  FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsas ' +
          'ON ' +
          '  fsu.CodigoAlmacen = fsas.CodigoAlmacen AND ' +
          '  fsu.CodigoUbicacion = fsas.CodigoUbicacion ' +
          'WHERE ' +
          '  fsu.CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' ' +
          andWhere;

  if Tipo='EMPTY' then
    sSQL := sSQL + ' AND fsas.CodigoArticulo IS NULL '
  else begin
    if CodigoArticulo<>'' then
      sSQL := sSQL + ' AND fsas.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' ';
    if Partida<>'' then
      sSQL := sSQL + ' AND fsas.Partida = ''' + SQL_Str(Partida) + ''' ';
  end;

  sSQL := sSQL + 'ORDER BY ' +
                 '  fsu.CodigoAlmacen, fsu.CodigoUbicacion ' +
                 'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
                 'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

(*
  sSQL := 'SELECT ' +
          '  CodigoAlmacen, CodigoZona, CodigoUbicacion, CodigoPasillo, CodigoEstanteria, Altura, Fondo, CodigoAlternativo, Bloqueada, Picking, Inactiva ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' ' +
          andWhere +
          'ORDER BY ' +
          '  CodigoUbicacion ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';
*)

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
      '"CodigoZona":"' + JSON_Str(Q.FieldByName('CodigoZona').AsString) + '",' +
      '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
      '"CodigoPasillo":"' + JSON_Str(Q.FieldByName('CodigoPasillo').AsString) + '",' +
      '"CodigoEstanteria":"' + JSON_Str(Q.FieldByName('CodigoEstanteria').AsString) + '",' +
      '"Altura":"' + JSON_Str(Q.FieldByName('Altura').AsString) + '",' +
      '"Fondo":"' + JSON_Str(Q.FieldByName('Fondo').AsString) + '",' +
      '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
      '"Rotacion":"' + JSON_Str(Q.FieldByName('Rotacion').AsString) + '",' +
      '"MultiRef":' + SQL_BooleanToStr(Q.FieldByName('MultiRef').AsBoolean) + ',' +
      '"MultiLote":' + SQL_BooleanToStr(Q.FieldByName('MultiLote').AsBoolean) + ',' +
      '"Bloqueada":' + SQL_BooleanToStr(Q.FieldByName('Bloqueada').AsBoolean) + ',' +
      '"Picking":' + SQL_BooleanToStr(Q.FieldByName('Picking').AsBoolean) + ',' +
      '"Inactiva":' + SQL_BooleanToStr(Q.FieldByName('Inactiva').AsBoolean) + ',' +
      '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"Stock":"' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat) + '",' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE ZONES D'UN MAGATZEM                                        │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1getZonasAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1getZonasAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_ESTR_ZONA WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(CodigoEmpresa) + ' AND ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + '''';

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  CodigoZona, NombreZona ' +
          'FROM ' +
          '  FS_SGA_ESTR_ZONA WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(CodigoEmpresa) + ' AND ' +
          '  CodigoAlmacen = ''' + SQL_Str(CodigoAlmacen) + ''' ' +
          'ORDER BY ' +
          '  CodigoZona ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoZona":"' + JSON_Str(Q.FieldByName('CodigoZona').AsString) + '",' +
      '"NombreZona":"' + JSON_Str(Q.FieldByName('NombreZona').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;



// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ REGULARITZACIÓ D'STOCK D'UNA UBICACIÓ                                 │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1readBarcodeAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  Tipo: Integer;
  Barcode: String;
  newRequest: TWebRequest;
  s: string;
  t: TStringList;
  iNumPunts: Integer;
  RegExpBarcode: String;
  RegExp: TRegEx;
  options: TRegExOptions;
  match: TMatch;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1readBarcodeAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  Barcode := Trim(request.contentfields.Values['Barcode']);
  if Barcode='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de barras no especificado","Data":[]}';
    Exit;
  end;

  // 0: Automàtic
  // 1: Articles
  // 2: Ubicacions
  // 3: Identificador d'expedició
  Tipo := StrToIntDef(request.contentfields.Values['Tipo'], 0 );

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  if Tipo=0 then begin
    iNumPunts := Length(Barcode)-Length(StringReplace(Barcode, '.','', [rfReplaceAll, rfIgnoreCase]));

    if iNumPunts=2 then begin

      Tipo := 3;

    end else if iNumPunts=4 then begin

      Tipo := 2;

    end else begin

      // Verifiquem expressió regular per a les ubicacions
      PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_RegExp_CodigoUbicacion, RegExpBarcode, EmpresaOrigen );

      RegExp := TRegEx.Create ( RegExpBarcode );
      match  := RegExp.Match(Barcode);
      if match.Success then Tipo := 2
      else Tipo := 1;

    end;

  end;

  if Tipo=1 then begin
    s := Request.QueryFields.Text;
    Request.QueryFields.AddPair('CodigoArticulo', Barcode );
    Request.ContentFields.AddPair('CodigoArticulo', Barcode );
    WebModule1getArticuloDetailsAction ( Sender, Request, Response, Handled );
    Exit;
  end else if Tipo=2 then begin
    s := Request.QueryFields.Text;
    Request.QueryFields.AddPair('CodigoUbicacion', Barcode );
    Request.ContentFields.AddPair('CodigoUbicacion', Barcode );
    WebModule1validateUbicacionAction ( Sender, Request, Response, Handled );
    Exit;
  end else if Tipo=3 then begin
    t := TStringList.Create;
    t.Delimiter := '.';
    t.DelimitedText := Barcode;
    if t.Count=3 then begin
      Result := '{"Result":"OK","Error":"","Data":[{' +
        '"Tipo":3,' +
        '"IdExpedicion":' + t[0] + ',' +
        '"IdentificadorExpedicion":' + t[1] + ',' +
        '"CajaId":' + t[2] +
        '}]}';
      FreeAndNil(t);
    end else begin
      FreeAndNil(t);
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de expedición no válido","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end else begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de barras desconocido","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  Response.Content := Result;


end;


procedure WebModule1readParamAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  id: Integer;
  Resultat: Variant;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1readParamAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  id := StrToIntDef(request.contentfields.Values['id'], 0 );
  if id=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Id no especificado","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  PARAM_Read ( Conn, 'FS_SGA_Parametros', id, Resultat, EmpresaOrigen );

  Result := '{"Result":"OK","Error":"","Data":[';
  Result := Result + '{"Param":"' + VarToStr(Resultat) + '"}';
  Result := Result + ']}';

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1readParamsAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  Resultat: Variant;
  sIDCall: String;
  sParamList: String;
  lParams: TStringList;
  s: string;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1readParamsAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  sParamList := trim(request.contentfields.Values['params']);
  if sParamList='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Lista de parámetros no especificada","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  lParams := TStringList.Create;
  lParams.Delimiter := ',';
  lParams.DelimitedText := sParamList;

  if lParams.Count=0 then
  begin
    FreeAndNil(lParams);
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Lista de parámetros no especificada","Data":[]}';
    Exit;
  end;

  s := '';

  while lParams.Count>0 do
  begin

    if StrToIntDef(lParams[0],-1)<>-1 then
      PARAM_Read ( Conn, 'FS_SGA_Parametros', StrToInt(lParams[0]), Resultat, EmpresaOrigen )
    else
      PARAM_Read ( Conn, 'FS_SGA_Parametros', lParams[0], Resultat, EmpresaOrigen );

    if s<>'' then
      s := s + ',';

    s := s + '"' + lParams[0] + '":"' + VarToStr(Resultat) + '"';

    lParams.Delete(0);

  end;

  FreeAndNil(lParams);

  Result := '{"Result":"OK","Error":"","Data":';
  Result := Result + '{' + s + '}';
  Result := Result + '}';

  {$ENDREGION}

  Response.Content := Result;


end;

procedure WebModule1regularizacionStockAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  EmpresaOrigen: Integer;
  CodigoUsuario: Integer;
  CodigoAlmacen: String;
  CodigoUbicacion: String;
  Partida: String;
  PartidaAntigua: String;
  aUbicacion: TSGAUbicacion;
  Unidades: Double;
  UnidadMedida: String;
  UnidadMedidaBase: String;
  UnidadesBase: Double;
  YY, MM, DD, HH, NN, SS, MS: WORD;
  Serie: String;
  Documento: Integer;
  AlmacenContrapartida: string;
  Partida2_: string;
  CodigoColor_: string;
  GrupoTalla_: string;
  CodigoTalla01_: string;
  TipoMovimiento: Integer;
  CodigoArticulo: string;
  UnidadesSaldo: Double;
  FactorConversion_: Double;
  Comentario: string;
  CodigoCanal: string;
  CodigoCliente: string;
  CodigoProveedor: string;
  FechaCaduca: String;
  Ubicacion: string;
  OrigenMovimiento: string;
  MovOrigen: string;
  EjercicioDocumento: Word;
  NumeroSerieLc: string;
  StatusTraspasadoIME: Integer;
  TipoImportacionIME: Integer;
  DocumentoUnico: Integer;
  IdDocumento: String;
  FechaRegistro: TDateTime;
  Precio: Double;
  Importe: Double;
  MovPosicion: String;
  MovIdentificadorIME: String;
  FactorConversion: Double;
  Diff: Double;
  bErr: Boolean;
  sMsg: String;
  IdProcesoIME: String;
  iLastID: Integer;
  iStatus: Integer;
  bNuevo: Boolean;
  sStr: String;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1regularizacionStockAction: ' + Request.RemoteAddr, sIDCall  );

  sStr := 'Inici<br>';

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  CodigoUbicacion := request.contentfields.values['CodigoUbicacion'];

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
    Exit;
  end;

  CodigoArticulo := request.contentfields.values['CodigoArticulo'];

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Exit;
  end;

  FechaCaduca := Trim(request.contentfields.values['FechaCaducidad']);

  if ARTICULO_TratamientoPartida ( Conn, CodigoEmpresa, CodigoArticulo) then begin
    Partida := request.contentfields.values['Partida'];
    if Partida='' then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado la partida para este artículo","Data":[]}';
      Exit;
    end;
    PartidaAntigua := request.contentfields.values['PartidaAntigua'];
    (*
    if PartidaAntigua='' then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado la partida antigua para este artículo","Data":[]}';
      Exit;
    end;
    *)
  end;

  aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacion );
  if aUbicacion.CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de la ubicación no es válido","Data":[]}';
    Exit;
  end;

  if (not aUbicacion.MultiRef) or (not aUbicacion.MultiLote) then begin
    if not SGA_ALMACEN_Permitir_Entrada_Ubicacion ( Conn, CodigoEmpresa, aUbicacion, Codigoarticulo, Partida ) then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La ubicación no permite más de un artículo o partida distintos","Data":[]}';
      Exit;
    end;
  end;

  CodigoAlmacen := aUbicacion.CodigoAlmacen;

  if trim(request.contentfields.values['Unidades'])='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado la cantidad","Data":[]}';
    Exit;
  end;

  Unidades := StrToFloatDef ( StringReplace(request.contentfields.values['Unidades'], '.', ',', []), 0 );
  if Unidades<0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades no pueden ser negativas","Data":[]}';
    Exit;
  end;

  DecodeDateTime ( Now(), YY, MM, DD, HH, NN, SS, MS );
  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  UnidadMedida := Trim ( request.contentfields.values['UnidadMedida'] );

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  Ejercicio = ' + IntToStr(YY) + ' AND ' +
          '  Periodo = 99 AND ' +
          '  CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + ''' AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
          '  Partida = ''' + SQL_Str(PartidaAntigua) + ''' AND ' +
          '  UnidadMedida = ''' + SQL_Str(UnidadMedida) + ''' ';

  sStr := sStr + sSQL + '<br>';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  bNuevo := FALSE;
  if Q.EOF then begin
    bNuevo := TRUE;
    UnidadesSaldo := 0;
  end else begin
    UnidadesSaldo := Q.FieldByName('UnidadesSaldo').AsFloat;
  end;

  sStr := sStr + 'Unidades saldo: ' + FloatToStr(UnidadesSaldo) + '<br>';

  UnidadMedidaBase     := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );
  CodigoColor_         := Q.FieldByName('CodigoColor_').AsString;
  CodigoTalla01_       := Q.FieldByName('CodigoTalla01_').AsString;
  GrupoTalla_          := '';
  Serie                := '';
  Documento            := 0;
  AlmacenContrapartida := '';
  Partida2_            := '';
  Precio               := 0;
  Importe              := 0;
  FactorConversion_    := 1;
  Comentario           := 'Regularización de stock';
  CodigoCanal          := '';
  CodigoCliente        := '';
  CodigoProveedor      := '';
  Ubicacion            := '';
  MovOrigen            := '';
  EjercicioDocumento   := YY;
  NumeroSerieLc        := '';
  StatusTraspasadoIME  := 0;
  TipoImportacionIME   := 2;
  DocumentoUnico       := 0;
  IdDocumento          := '';
  FechaRegistro        := Now();

  bErr := FALSE;
  sMsg := '';

  if not bErr then try
    IdProcesoIME := SQL_Execute ( Conn,'select NEWID()');
    IdProcesoIME := StringReplace ( IdProcesoIME, '{', '', [] );
    IdProcesoIME := StringReplace ( IdProcesoIME, '}', '', [] );
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  // Fem el moviment de sortida de l'article antic
  TipoMovimiento   := 2;
  OrigenMovimiento := 'S';

  if UnidadMedidaBase='' then
    Unidadmedida := '';

  UnidadesBase := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                    UnidadesSaldo, UnidadMedidaBase, UnidadMedida, FactorConversion );

  if UnidadesBase<0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades de medida son incorrectas","Data":[]}';
    Exit;
  end;

  // Sortida de stock antic
  gaLogFile.Write('Regularización: Salida Artículo=' + CodigoArticulo + ', Partida=' + PartidaAntigua + ', Ubicación=' + aUbicacion.CodigoUbicacion + ' Unidades=' + FormatFloat('#,0', UnidadesSaldo), sIDCall  );

  if not bErr then try
    MovIdentificadorIME := SQL_Execute ( Conn,'select NEWID()');
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '{', '', [] );
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '}', '', [] );
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if not bErr then try
    MovPosicion := SQL_Execute ( Conn,'select NEWID()');
    MovPosicion := StringReplace ( MovPosicion, '{', '', [] );
    MovPosicion := StringReplace ( MovPosicion, '}', '', [] );
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if (IdDocumento='') or (IdDocumento='0') then begin
    IdDocumento := '00000000-0000-0000-0000-000000000000';
  end;

  if (MovOrigen='') or (MovOrigen='0') then begin
    MovOrigen := '00000000-0000-0000-0000-000000000000';
  end;

  if FechaCaduca='' then begin
    FechaCaduca := '0';
  end;

  iLastID := 0;
  iStatus := 1;

  SGA_FS_ALMACEN_PrepareMov ( gaMov );
  gaMov.CodigoEmpresa          := CodigoEmpresa;
  gaMov.EmpresaOrigen          := EmpresaOrigen;
  gaMov.CodigoUsuario          := CodigoUsuario;
  gaMov.Ejercicio              := YY;
  gaMov.Periodo                := MM;
  gaMov.Fecha                  := Date();
  gaMov.FechaHora              := Now();
  gaMov.CodigoAlmacen          := CodigoAlmacen;
  gaMov.CodigoUbicacion        := CodigoUbicacion;
  gaMov.CodigoArticulo         := CodigoArticulo;
  gaMov.Partida                := PartidaAntigua;
  gaMov.TipoMovimiento         := 2;
  gaMov.OrigenMovimiento       := 'S';
  gaMov.Unidades               := UnidadesSaldo;
  gaMov.UnidadMedida           := UnidadMedida;
  gaMov.UnidadesBase           := UnidadesBase;
  gaMov.UnidadMedidaBase       := UnidadMedidaBase;
  gaMov.FactorConversion       := FactorConversion;
  gaMov.Comentario             := 'Salida regularización';
  gaMov.IdProcesoIME           := IdProcesoIME;
  gaMov.IdDocumento            := IdDocumento;
  gaMov.Serie                  := Serie;
  gaMov.Precio                 := Precio;
  gaMov.MovOrigen              := MovOrigen;
  gaMov.CodigoProveedor        := CodigoProveedor;

  sStr := sStr + 'Movimiento salida SGA<br>';

  if UnidadesSaldo>0 then
  begin

    if not bErr then try
      bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
    except
      on E:Exception do begin
        bErr := TRUE;
        sMsg := E.Message + ' - ' + sMsg;
      end;
    end;

    sSQL := 'INSERT INTO ' +
            '  TmpIME_MovimientoStock ( ' +
            '    CodigoEmpresa, Ejercicio, Periodo, Fecha, Serie, Documento, ' +
            '    CodigoArticulo, CodigoAlmacen, AlmacenContrapartida, Partida, ' +
            '    Partida2_, CodigoColor_, GrupoTalla_, CodigoTalla01_, TipoMovimiento, ' +
            '    Unidades, UnidadMedida1_, Precio, Importe, Unidades2_, UnidadMedida2_, ' +
            '    FactorConversion_, Comentario, CodigoCanal, CodigoCliente, CodigoProveedor, ' +
            '    FechaCaduca, Ubicacion, OrigenMovimiento, EmpresaOrigen, MovOrigen, ' +
            '    EjercicioDocumento, NumeroSerieLc, IdProcesoIME, MovIdentificadorIME, ' +
            '    StatusTraspasadoIME, TipoImportacionIME, DocumentoUnico, FechaRegistro, ' +
            '    MovPosicion ' +
            '  ) ' +
            'VALUES ( ' +
            IntToStr(CodigoEmpresa) + ', ' +
            IntToStr(YY) + ', ' +
            IntToStr(MM) + ', ' +
            SQL_DateToStr ( Now() ) + ', ' +
            '''' + SQL_Str(Serie) + ''', ' +
            IntToStr(Documento) + ', ' +
            '''' + SQL_Str(CodigoArticulo) + ''', ' +
            '''' + SQL_Str(CodigoAlmacen) + ''', ' +
            '''' + SQL_Str(AlmacenContrapartida) + ''', ' +
            '''' + SQL_Str(PartidaAntigua) + ''', ' +
            '''' + SQL_Str(Partida2_) + ''', ' +
            '''' + SQL_Str(CodigoColor_) + ''', ' +
            '''' + SQL_Str(GrupoTalla_) + ''', ' +
            '''' + SQL_Str(CodigoTalla01_) + ''', ' +
            '2, ' +
            SQL_FloatToStr ( UnidadesSaldo ) + ', '+
            '''' + SQL_Str( UnidadMedida ) + ''', ' +
            SQL_FloatToStr ( Precio ) + ', ' +
            SQL_FloatToStr ( Importe ) + ', ' +
            SQL_FloatToStr ( UnidadesBase ) + ', '+
            '''' + SQL_Str( UnidadMedidaBase ) + ''', ' +
            SQL_FloatToStr ( FactorConversion_ ) + ', '+
            '''Salida regularización'', ' +
            '''' + SQL_Str( CodigoCanal ) + ''', ' +
            '''' + SQL_Str( CodigoCliente ) + ''', ' +
            '''' + SQL_Str( CodigoProveedor ) + ''', ' +
            FechaCaduca + ', ' +
            '''' + SQL_Str( Ubicacion ) + ''', ' +
            '''S'', ' +
            IntToStr(EmpresaOrigen) + ', ' +
            '''' + SQL_Str( MovOrigen ) + ''', ' +
            IntToStr(EjercicioDocumento) + ', ' +
            '''' + SQL_Str( NumeroSerieLc ) + ''', ' +
            '''' + SQL_Str( IdProcesoIME ) + ''', ' +
            '''' + SQL_Str( MovIdentificadorIME ) + ''', ' +
            IntToStr(StatusTraspasadoIME) + ', ' +
            IntToStr(TipoImportacionIME) + ', ' +
            IntToStr(DocumentoUnico) + ', ' +
            SQL_DateTimeToStr ( FechaRegistro ) + ', ' +
            '''' + SQL_Str( MovPosicion ) + ''') ';

    sStr := sStr + 'Movimiento salida Sage: ' + sSQL + '<br>';

    if not bErr then try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on E:Exception do begin
        bErr := TRUE;
        sMsg := E.Message;
      end;
    end;

  end;

  // Entrada del nou stock
  gaLogFile.Write('Regularización: Entrada Artículo=' + CodigoArticulo + ', Partida=' + Partida + ', Ubicación=' + aUbicacion.CodigoUbicacion + ' Unidades=' + FormatFloat('#,0', Unidades), sIDCall  );

  UnidadesBase := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                    UnidadesSaldo, UnidadMedidaBase, UnidadMedida, FactorConversion );

  if UnidadesBase<0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades de medida son incorrectas","Data":[]}';
    Exit;
  end;

  gaMov.Partida                := Partida;
  gaMov.TipoMovimiento         := 1;
  gaMov.OrigenMovimiento       := 'E';
  gaMov.Unidades               := Unidades;
  gaMov.UnidadesBase           := UnidadesBase;
  gaMov.FactorConversion       := FactorConversion;
  gaMov.Comentario             := 'Entrada regularización';
  gaMov.Precio                 := Precio;
  gaMov.MovOrigen              := MovOrigen;
  gaMov.CodigoProveedor        := CodigoProveedor;

  if (FechaCaduca<>'') and (FechaCaduca<>'0') then
    gaMov.FechaCaduca          := StrToDate(FechaCaduca);

  sStr := sStr + 'Movimiento entrada SGA<br>';

  if Unidades>0 then
  begin

    if not bErr then try
      bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
    except
      on E:Exception do begin
        bErr := TRUE;
        sMsg := E.Message + ' - ' + sMsg;
      end;
    end;

    if not bErr then try
      MovIdentificadorIME := SQL_Execute ( Conn,'select NEWID()');
      MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '{', '', [] );
      MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '}', '', [] );
    except
      on E:Exception do begin
        sMsg := E.Message;
        bErr := TRUE;
      end;
    end;

    if not bErr then try
      MovPosicion := SQL_Execute ( Conn,'select NEWID()');
      MovPosicion := StringReplace ( MovPosicion, '{', '', [] );
      MovPosicion := StringReplace ( MovPosicion, '}', '', [] );
    except
      on E:Exception do begin
        sMsg := E.Message;
        bErr := TRUE;
      end;
    end;

    sSQL := 'INSERT INTO ' +
            '  TmpIME_MovimientoStock ( ' +
            '    CodigoEmpresa, Ejercicio, Periodo, Fecha, Serie, Documento, ' +
            '    CodigoArticulo, CodigoAlmacen, AlmacenContrapartida, Partida, ' +
            '    Partida2_, CodigoColor_, GrupoTalla_, CodigoTalla01_, TipoMovimiento, ' +
            '    Unidades, UnidadMedida1_, Precio, Importe, Unidades2_, UnidadMedida2_, ' +
            '    FactorConversion_, Comentario, CodigoCanal, CodigoCliente, CodigoProveedor, ' +
            '    FechaCaduca, Ubicacion, OrigenMovimiento, EmpresaOrigen, MovOrigen, ' +
            '    EjercicioDocumento, NumeroSerieLc, IdProcesoIME, MovIdentificadorIME, ' +
            '    StatusTraspasadoIME, TipoImportacionIME, DocumentoUnico, FechaRegistro, ' +
            '    MovPosicion ' +
            '  ) ' +
            'VALUES ( ' +
            IntToStr(CodigoEmpresa) + ', ' +
            IntToStr(YY) + ', ' +
            IntToStr(MM) + ', ' +
            SQL_DateToStr ( Now() ) + ', ' +
            '''' + SQL_Str(Serie) + ''', ' +
            IntToStr(Documento) + ', ' +
            '''' + SQL_Str(CodigoArticulo) + ''', ' +
            '''' + SQL_Str(CodigoAlmacen) + ''', ' +
            '''' + SQL_Str(AlmacenContrapartida) + ''', ' +
            '''' + SQL_Str(Partida) + ''', ' +
            '''' + SQL_Str(Partida2_) + ''', ' +
            '''' + SQL_Str(CodigoColor_) + ''', ' +
            '''' + SQL_Str(GrupoTalla_) + ''', ' +
            '''' + SQL_Str(CodigoTalla01_) + ''', ' +
            '1, ' +
            SQL_FloatToStr ( Unidades ) + ', '+
            '''' + SQL_Str( UnidadMedida ) + ''', ' +
            SQL_FloatToStr ( Precio ) + ', ' +
            SQL_FloatToStr ( Importe ) + ', ' +
            SQL_FloatToStr ( UnidadesBase ) + ', '+
            '''' + SQL_Str( UnidadMedidaBase ) + ''', ' +
            SQL_FloatToStr ( FactorConversion_ ) + ', '+
            '''Entrada regularización'', ' +
            '''' + SQL_Str( CodigoCanal ) + ''', ' +
            '''' + SQL_Str( CodigoCliente ) + ''', ' +
            '''' + SQL_Str( CodigoProveedor ) + ''', ' +
            FechaCaduca + ', ' +
            '''' + SQL_Str( Ubicacion ) + ''', ' +
            '''E'', ' +
            IntToStr(EmpresaOrigen) + ', ' +
            '''' + SQL_Str( MovOrigen ) + ''', ' +
            IntToStr(EjercicioDocumento) + ', ' +
            '''' + SQL_Str( NumeroSerieLc ) + ''', ' +
            '''' + SQL_Str( IdProcesoIME ) + ''', ' +
            '''' + SQL_Str( MovIdentificadorIME ) + ''', ' +
            IntToStr(StatusTraspasadoIME) + ', ' +
            IntToStr(TipoImportacionIME) + ', ' +
            IntToStr(DocumentoUnico) + ', ' +
            SQL_DateTimeToStr ( FechaRegistro ) + ', ' +
            '''' + SQL_Str( MovPosicion ) + ''') ';

    sStr := sStr + 'Movimiento Sage: ' + sSQL + '<br>';

    if not bErr then try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on E:Exception do begin
        bErr := TRUE;
        sMsg := E.Message;
      end;
    end;

  end;

  sSQL := 'INSERT INTO ' +
          '  FS_Operations ( oper_product_code, oper_name, oper_datetime, oper_params, oper_CodigoEmpresa ) ' +
          'VALUES ( ' +
          '''E4E8'', ' +
          '''MOVIMIENTOSTOCK'', ' +
          SQL_DateTimeToStr(Now()) + ', ' +
          '''{"IdProcesoIME":"' + IdProcesoIME + '","MantenerDatos":"1","MantenerErrores":"1","Módulos":"4","CodigoEmpresa":"' + IntToStr(CodigoEmpresa) + '"}'', ' +
          IntToStr(CodigoEmpresa) +
          ')';

  sStr := sStr + 'FS_Operations: ' + sSQL + '<br>';

  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
    sSQL := 'SELECT IDENT_CURRENT(''FS_Operations'')';
    iLastID := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on e:exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  if bErr then begin
    // Conn.RollbackTrans;
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + sMsg + '","Data":[]}';
    Exit;
  end;

  Result := '{"Result":"OK","Error":"","Data":[';
  Result := Result + ']}';

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ REALITZAR UN MOVIMENT D'ENTRADA D'STOCK                               │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1entradaStockAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  YY, DD, MM, HH, NN, SS, MS: WORD;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  aUbicacion: TSGAUbicacion;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  CodigoArticulo: String;
  Partida: String;
  Precio: Double;
  CodigoAlmacen: String;
  AlmacenContrapartida: String;
  Comentarios: String;
  Ubicacion: String;
  OrigenMovimiento: String;
  MovOrigen: String;
  Serie: String;
  Documento: Integer;
  NumeroSerieLc: String;
  EjercicioDocumento: Integer;
  FechaCaduca: String;
  CodigoCliente: String;
  CodigoCanal: String;
  Partida2_: String;
  CodigoColor_: String;
  GrupoTalla_: String;
  CodigoTalla01_: String;
  UnidadMedida1_: String;
  TipoMovimiento: Integer;
  Importe: Double;
  FactorConversion_: Double;
  Comentario: string;
  CodigoProveedor: string;
  IdProcesoIME: string;
  TipoImportacionIME: Integer;
  DocumentoUnico: Integer;
  FechaRegistro: TDateTime;
  MovPosicion: String;
  MovIdentificadorIME: String;
  bResult: Boolean;
  iLastID: Integer;
  Mensaje: String;
  iStatus: Integer;
  CodigoUbicacion: String;
  CodigoUsuario: Integer;
  IdDocumento: String;
  StatusTraspasadoIME: Integer;
  bErr: Boolean;
  sMsg: String;
  Unidades: Double;
  UnidadMedida: String;
  UnidadesBase: Double;
  UnidadMedidaBase: String;
  FactorConversion: Double;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1entradaStockAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  sMsg := '';
  bErr := FALSE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Exit;
  end;

  CodigoUbicacion := request.contentfields.values['CodigoUbicacion'];

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
    Exit;
  end;

  CodigoArticulo := request.contentfields.values['CodigoArticulo'];

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Exit;
  end;

  if ARTICULO_TratamientoPartida ( Conn, CodigoEmpresa, CodigoArticulo) then begin
    Partida := request.contentfields.values['Partida'];
    if Partida='' then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado la partida para este artículo","Data":[]}';
      Exit;
    end;
  end;

  aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacion );
  if aUbicacion.CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de la ubicación no es válido","Data":[]}';
    Exit;
  end;

  if (not aUbicacion.MultiRef) or (not aUbicacion.MultiLote) then begin
    if not SGA_ALMACEN_Permitir_Entrada_Ubicacion ( Conn, CodigoEmpresa, aUbicacion, Codigoarticulo, Partida ) then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La ubicación no permite más de un artículo o partida distintos","Data":[]}';
      Exit;
    end;
  end;

  Unidades := StrToFloatDef ( StringReplace(request.contentfields.values['Unidades'], '.', ',', []), 0 );
  if Unidades=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades no pueden ser 0","Data":[]}';
    Exit;
  end;

  UnidadMedida     := Trim ( request.contentfields.values['UnidadMedida'] );
  UnidadMedidaBase := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );

  if UnidadMedidaBase='' then
    Unidadmedida := '';

  UnidadesBase := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                    Unidades, UnidadMedidaBase, UnidadMedida, FactorConversion );

  if UnidadesBase=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades de medida son incorrectas","Data":[]}';
    Exit;
  end;

  try
    // // Conn.BeginTrans;
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(E.Message) + '","Data":[]}';
      Exit;
    end;
  end;

  DecodeDateTime ( Now(), YY, MM, DD, HH, NN, SS, MS );

  YY                   := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );
  Serie                := request.contentfields.values['Serie'];
  Documento            := StrToIntDef ( request.contentfields.values['Documento'], 0 );
  AlmacenContrapartida := request.contentfields.values['AlmacenContrapartida'];
  Partida2_            := request.contentfields.values['Partida2_'];
  CodigoColor_         := request.contentfields.values['CodigoColor_'];
  GrupoTalla_          := request.contentfields.values['GrupoTalla_'];
  CodigoTalla01_       := request.contentfields.values['CodigoTalla01_'];
  TipoMovimiento       := StrToIntDef ( request.contentfields.values['TipoMovimiento'], 1 );
  Precio               := StrToFloatDef ( request.contentfields.values['Precio'], 0 );
  Importe              := Unidades * Precio;
  FactorConversion_    := FactorConversion; // StrToFloatDef ( request.contentfields.values['FactorConversion_'], 1.0 );
  Comentario           := request.contentfields.values['Comentario'];
  CodigoCanal          := request.contentfields.values['CodigoCanal'];
  CodigoCliente        := request.contentfields.values['CodigoCliente'];
  CodigoProveedor      := request.contentfields.values['CodigoProveedor'];
  FechaCaduca          := request.contentfields.values['FechaCaduca'];
  Ubicacion            := request.contentfields.values['Ubicacion'];
  OrigenMovimiento     := request.contentfields.values['OrigenMovimiento'];
  MovOrigen            := request.contentfields.values['MovOrigen'];
  EjercicioDocumento   := StrToIntDef ( request.contentfields.values['EjercicioDocumento'], 0 );
  NumeroSerieLc        := request.contentfields.values['NumeroSerieLc'];
  StatusTraspasadoIME  := 0;
  TipoImportacionIME   := 2;
  DocumentoUnico       := StrToIntDef ( request.contentfields.values['DocumentoUnico'], 0 );
  IdDocumento          := request.contentfields.values['IdDocumento'];
  FechaRegistro        := Now();

  if not bErr then try
    MovPosicion        := SQL_Execute ( Conn,'select NEWID()');
    MovPosicion        := StringReplace ( MovPosicion, '{', '', [] );
    MovPosicion        := StringReplace ( MovPosicion, '}', '', [] );
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if not bErr then try
    MovIdentificadorIME := SQL_Execute ( Conn,'select NEWID()');
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '{', '', [] );
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '}', '', [] );
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if not bErr then try
    IdProcesoIME := SQL_Execute ( Conn,'select NEWID()');
    IdProcesoIME := StringReplace ( IdProcesoIME, '{', '', [] );
    IdProcesoIME := StringReplace ( IdProcesoIME, '}', '', [] );
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if (IdDocumento='') or (IdDocumento='0') then begin
    IdDocumento := '00000000-0000-0000-0000-000000000000';
  end;

  if OrigenMovimiento='' then begin
    OrigenMovimiento := 'E';
  end;

  if (MovOrigen='') or (MovOrigen='0') then begin
    MovOrigen := '00000000-0000-0000-0000-000000000000';
  end;

  if FechaCaduca='' then begin
    FechaCaduca := '0';
  end;

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  iLastID := 0;
  iStatus := 1;

  SGA_FS_ALMACEN_PrepareMov ( gaMov );
  gaMov.CodigoEmpresa          := CodigoEmpresa;
  gaMov.EmpresaOrigen          := EmpresaOrigen;
  gaMov.CodigoUsuario          := CodigoUsuario;
  gaMov.Ejercicio              := YY;
  gaMov.Periodo                := MM;
  gaMov.Fecha                  := Date();
  gaMov.FechaHora              := Now();
  gaMov.CodigoAlmacen          := CodigoAlmacen;
  gaMov.CodigoUbicacion        := CodigoUbicacion;
  gaMov.CodigoArticulo         := CodigoArticulo;
  gaMov.Partida                := Partida;
  gaMov.TipoMovimiento         := TipoMovimiento;
  gaMov.OrigenMovimiento       := OrigenMovimiento;
  gaMov.Unidades               := Unidades;
  gaMov.UnidadMedida           := UnidadMedida;
  gaMov.UnidadesBase           := UnidadesBase;
  gaMov.UnidadMedidaBase       := UnidadMedidaBase;
  gaMov.FactorConversion       := FactorConversion;
  gaMov.Comentario             := Comentario;
  gaMov.IdProcesoIME           := IdProcesoIME;
  gaMov.IdDocumento            := IdDocumento;
  gaMov.Serie                  := Serie;
  gaMov.FechaCaduca            := FechaCaduca;
  gaMov.Precio                 := Precio;
  gaMov.MovOrigen              := MovOrigen;
  gaMov.CodigoProveedor        := CodigoProveedor;

  if not bErr then try
    bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  sSQL := 'INSERT INTO ' +
          '  TmpIME_MovimientoStock ( ' +
          '    CodigoEmpresa, Ejercicio, Periodo, Fecha, Serie, Documento, ' +
          '    CodigoArticulo, CodigoAlmacen, AlmacenContrapartida, Partida, ' +
          '    Partida2_, CodigoColor_, GrupoTalla_, CodigoTalla01_, TipoMovimiento, ' +
          '    Unidades, UnidadMedida1_, Precio, Importe, Unidades2_, UnidadMedida2_, ' +
          '    FactorConversion_, Comentario, CodigoCanal, CodigoCliente, CodigoProveedor, ' +
          '    FechaCaduca, Ubicacion, OrigenMovimiento, EmpresaOrigen, MovOrigen, ' +
          '    EjercicioDocumento, NumeroSerieLc, IdProcesoIME, MovIdentificadorIME, ' +
          '    StatusTraspasadoIME, TipoImportacionIME, DocumentoUnico, FechaRegistro, ' +
          '    MovPosicion ' +
          '  ) ' +
          'VALUES ( ' +
          IntToStr(CodigoEmpresa) + ', ' +
          IntToStr(YY) + ', ' +
          IntToStr(MM) + ', ' +
          SQL_DateToStr ( Now() ) + ', ' +
          '''' + SQL_Str(Serie) + ''', ' +
          IntToStr(Documento) + ', ' +
          '''' + SQL_Str(CodigoArticulo) + ''', ' +
          '''' + SQL_Str(CodigoAlmacen) + ''', ' +
          '''' + SQL_Str(AlmacenContrapartida) + ''', ' +
          '''' + SQL_Str(Partida) + ''', ' +
          '''' + SQL_Str(Partida2_) + ''', ' +
          '''' + SQL_Str(CodigoColor_) + ''', ' +
          '''' + SQL_Str(GrupoTalla_) + ''', ' +
          '''' + SQL_Str(CodigoTalla01_) + ''', ' +
          IntToStr(TipoMovimiento) + ', ' +
          SQL_FloatToStr ( Unidades ) + ', '+
          '''' + SQL_Str( UnidadMedida ) + ''', ' +
          SQL_FloatToStr ( Precio ) + ', ' +
          SQL_FloatToStr ( Importe ) + ', ' +
          SQL_FloatToStr ( UnidadesBase ) + ', '+
          '''' + SQL_Str( UnidadMedidaBase ) + ''', ' +
          SQL_FloatToStr ( FactorConversion_ ) + ', '+
          '''' + SQL_Str( Comentario ) + ''', ' +
          '''' + SQL_Str( CodigoCanal ) + ''', ' +
          '''' + SQL_Str( CodigoCliente ) + ''', ' +
          '''' + SQL_Str( CodigoProveedor ) + ''', ' +
          FechaCaduca + ', ' +
          '''' + SQL_Str( Ubicacion ) + ''', ' +
          '''' + SQL_Str( OrigenMovimiento ) + ''', ' +
          IntToStr(EmpresaOrigen) + ', ' +
          '''' + SQL_Str( MovOrigen ) + ''', ' +
          IntToStr(EjercicioDocumento) + ', ' +
          '''' + SQL_Str( NumeroSerieLc ) + ''', ' +
          '''' + SQL_Str( IdProcesoIME ) + ''', ' +
          '''' + SQL_Str( MovIdentificadorIME ) + ''', ' +
          IntToStr(StatusTraspasadoIME) + ', ' +
          IntToStr(TipoImportacionIME) + ', ' +
          IntToStr(DocumentoUnico) + ', ' +
          SQL_DateTimeToStr ( FechaRegistro ) + ', ' +
          '''' + SQL_Str( MovPosicion ) + ''') ';

  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  sSQL := 'INSERT INTO ' +
          '  FS_Operations ( oper_product_code, oper_name, oper_datetime, oper_params, oper_CodigoEmpresa ) ' +
          'VALUES ( ' +
          '''E4E8'', ' +
          '''MOVIMIENTOSTOCK'', ' +
          SQL_DateTimeToStr(Now()) + ', ' +
          '''{"IdProcesoIME":"' + IdProcesoIME + '","MantenerDatos":"1","MantenerErrores":"1","Módulos":"4","CodigoEmpresa":"' + IntToStr(CodigoEmpresa) + '"}'', ' +
          IntToStr(CodigoEmpresa) +
          ')';

  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
    sSQL := 'SELECT IDENT_CURRENT(''FS_Operations'')';
    iLastID := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  (*
  if (iLastID<>0) and (not WaitOperationDone ( Conn, iLastID, Status, Mensaje )) then begin

    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + Mensaje + '","Data":[]}';
    Exit;

  end;

  if iStatus<>1 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + Mensaje + '","Data":[';
    Result := Result + ']}';
  end else begin
    Result := '{"Result":"OK","Error":"","Data":[';
    Result := Result + ']}';
  end;
  *)

  if not bErr then try
    // Conn.CommitTrans;
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  if bErr then begin
    // Conn.RollbackTrans;
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + sMsg + '","Data":[]}';
    Exit;
  end;

  {$ENDREGION}

  Response.Content := '{"Result":"OK","Error":"","Data":[]}';

end;


procedure WebModule1expedicionDisponibleAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  LineasPosicion: string;
  UdNecesarias: Double;
  UdExpedidas: Double;
  UdSaldo: Double;
  Q1: TADOQuery;
  CodigoArticulo: string;
  DescripcionArticulo: string;
  Partida: string;
  UnidadMedida: string;
  CodigoArticuloAlternativo: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1expedicionDisponibleAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  LineasPosicion := Trim(request.contentfields.values['LineasPosicion']);
  if LineasPosicion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Posición de línea no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoArticulo := Trim(request.contentfields.values['CodigoArticulo']);
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  fsppl.CodigoArticulo, fsppl.DescripcionArticulo, fsppl.Partida, fsppl.UnidadMedida, ' +
          '  fsppl.UdNecesarias, fsppl.UdExpedidas, fsppl.UdSaldo, fsa.CodigoAlternativo AS CodigoArticuloAlternativo ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas fsppl WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  FS_SGA_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) fsa ' +
          'ON ' +
          '  fsppl.CodigoArticulo = fsa.CodigoArticulo ' +
          'WHERE ' +
          '  fsppl.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  fsppl.PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  fsppl.LineasPosicion = ''' + SQL_Str(LineasPosicion) + '''';
  Q1 := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q1.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q1);
      FreeAndNil(Q);
      Exit;
    end;
  end;

  if not Q1.Eof then begin
    CodigoArticulo            := Q1.FieldByName('CodigoArticulo').AsString;
    CodigoArticuloAlternativo := Q1.FieldByName('CodigoArticuloAlternativo').AsString;
    DescripcionArticulo       := Q1.FieldByName('DescripcionArticulo').AsString;
    Partida                   := Q1.FieldByName('Partida').AsString;
    UnidadMedida              := Q1.FieldByName('UnidadMedida').AsString;
    UdNecesarias              := Q1.FieldByName('UdNecesarias').AsFloat;
    UdExpedidas               := Q1.FieldByName('UdExpedidas').AsFloat;
    UdSaldo                   := Q1.FieldByName('UdSaldo').AsFloat;
  end else begin
    CodigoArticulo            := '';
    CodigoArticuloAlternativo := '';
    DescripcionArticulo       := '';
    Partida                   := '';
    UnidadMedida              := '';
    UdNecesarias              := 0;
    UdExpedidas               := 0;
    UdSaldo                   := 0;
  end;

  Q1.Close;
  FreeAndNil(Q1);

  sSQL := 'SELECT ' +
          '  CodigoEmpresa, IdPreparacion, Partida, UnidadMedida, ' +
          '  SUM( Cantidad ) as Cantidad, ' +
          '  SUM(CASE WHEN LineaPedidoCliente<>''00000000-0000-0000-0000-000000000000'' THEN 0 ELSE Cantidad END) AS CantidadDisponible, ' +
          '  SUM(CASE WHEN LineaPedidoCliente=''00000000-0000-0000-0000-000000000000'' THEN 0 ELSE Cantidad END) AS CantidadExpedida ' +
          'FROM ' +
          '  FS_SGA_AcumuladoPendiente WITH (NOLOCK) ' +
          'WHERE ' +
          '  IdPreparacion = ' + intToStr( IdPreparacion ) + ' AND ' +
          '  LineaPedidoCliente IN ( ''00000000-0000-0000-0000-000000000000'',''' + SQL_Str ( LineasPosicion ) + ''') AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' ' +
          'GROUP BY ' +
          '  CodigoEmpresa, IdPreparacion, Partida, UnidadMedida ' +
          'HAVING ' +
          '  SUM (Cantidad) > 0';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":';
  iNumRegs := 0;

  Result := Result + '{' +
                     '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
                     '"IdPreparacion":"' + Q.FieldByName('IdPreparacion').AsString + '",' +
                     '"CodigoArticulo":"' + JSON_Str(CodigoArticulo) + '",' +
                     '"DescripcionArticulo":"' + JSON_Str(DescripcionArticulo) + '",' +
                     '"CodigoArticuloAlternativo":"' + JSON_Str(CodigoArticuloAlternativo) + '",' +
                     '"Partida":"' + JSON_Str(Partida) + '",' +
                     '"UnidadMedida":"' + JSON_Str(UnidadMedida) + '",' +
                     '"UdNecesarias":' + SQL_FloatToStr(UdNecesarias) + ',' +
                     '"UdExpedidas":' + SQL_FloatToStr(UdExpedidas) + ',' +
                     '"UdSaldo":' + SQL_FloatToStr(UdSaldo) + ',' +
                     '"Detalles":[';


  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"Cantidad":' + SQL_FloatToStr(Q.FieldByName('Cantidad').AsFloat) + ',' +
                       '"CantidadDisponible":' + SQL_FloatToStr(Q.FieldByName('CantidadDisponible').AsFloat) + ',' +
                       '"CantidadExpedida":' + SQL_FloatToStr(Q.FieldByName('CantidadExpedida').AsFloat) + ',' +
                       '"Limite":' + SQL_FloatToStr(Q.FieldByName('CantidadDisponible').AsFloat + Q.FieldByName('CantidadExpedida').AsFloat) +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ RETORNA LES PARTIDES QUE S'HAN PREPARAT D'UN ARTICLE CONCRET          │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1expedicionPartidasArticuloAction(
  Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoArticulo: String;
  sFiltro: string;
  IdentificadorExp: string;
  t: TStringList;
  EjercicioPedido: Integer;
  NumeroPedido: Integer;
  SeriePedido: string;
  TratamientoPartidas: Boolean;
  fTotal: Double;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1expedicionPartidasArticuloAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  sFiltro := '';

  CodigoArticulo := Trim(request.contentfields.values['CodigoArticulo']);
  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );
  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo inválido","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  TratamientoPartidas := ARTICULO_TratamientoPartida ( Conn, CodigoEmpresa, CodigoArticulo );

  // Mirem si l'article forma part de la preparació o no
  sSQL := 'SELECT COUNT(*) ' +
          'FROM FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + '''';
  if SQL_Execute(Conn, sSQL)=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo inválido","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT COUNT(DISTINCT Partida) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  IdPreparacion = ' + IntToStr(IdPreparacion) + ' AND ' +
          //'  PickingId = 0 AND ' +
          //'  LineaPedidoCliente = ''00000000-0000-0000-0000-000000000000'' AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
          '  Partida<>'''' AND ' +
          '  Partida IS NOT NULL';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  if not TratamientoPartidas then begin

    Response.Content := '{"Result":"OK","Error":"","TotalRecords":0,"NumPages":0,"NumRecords":0,"Data":[]}';
    Exit;

  end;

  sSQL := 'SELECT DISTINCT ' +
          '  Partida, Cantidad ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  IdPreparacion = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  PickingId = 0 AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
          '  Partida<>'''' AND ' +
          '  Partida IS NOT NULL ' +
          'ORDER BY ' +
          '  Partida ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  sSQL := 'SELECT DISTINCT ' +
          '  Partida, ' +
          '  ( ' +
          '    SELECT ' +
          '      ISNULL(SUM(Cantidad),0) ' +
          '    FROM ' +
          '      dbo.FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) fsap1 ' +
          '    WHERE ' +
          '      fsap1.IdPreparacion = fsap.IdPreparacion AND ' +
          '    	 fsap1.CodigoArticulo = fsap.CodigoArticulo AND ' +
          '      fsap1.Partida = fsap.Partida AND ' +
          '      fsap1.LineaPedidoCliente = ''00000000-0000-0000-0000-000000000000'' ' +
          '  ) AS CantidadDisponible, ' +
          '  ( ' +
          '    SELECT ' +
          '      ISNULL(SUM(Cantidad),0) ' +
          '    FROM ' +
          '      dbo.FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) fsap2 ' +
          '    WHERE ' +
          '      fsap2.IdPreparacion = fsap.IdPreparacion AND ' +
          '    	 fsap2.CodigoArticulo = fsap.CodigoArticulo AND ' +
          '      fsap2.Partida = fsap.Partida AND ' +
          '      fsap2.LineaPedidoCliente <> ''00000000-0000-0000-0000-000000000000'' ' +
          '  ) AS CantidadExpedida ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_AcumuladoPendiente ( ' + IntToStr(CodigoEmpresa) + ' ) fsap ' +
          'WHERE ' +
          '  fsap.IdPreparacion = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  fsap.PickingId = 0 AND ' +
          '  fsap.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
          '  fsap.Partida<>'''' AND ' +
          '  fsap.Partida IS NOT NULL ' +
          'ORDER BY ' +
          '  fsap.Partida ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    fTotal := Q.FieldByName('CantidadDisponible').AsFloat + Q.FieldByName('CantidadExpedida').AsFloat;

    Result := Result + '{' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"CantidadDisponible":' + Q.FieldByName('CantidadDisponible').AsString  + ',' +
                       '"CantidadExpedida":' + Q.FieldByName('CantidadExpedida').AsString + ',' +
                       '"Cantidad":' + SQL_FloatToStr(fTotal) +
                       '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ EXPEDEIX TOTS ELS ARTICLES D'UNA PREPARACIÓ MONOCOMANDA               │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1expedirPedidoAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  sSQL: String;
  EmpresaOrigen, CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  CodigoUsuario: Integer;
  Q, Q2: TADOQuery;
  Result: String;
  sCodigoArticulo, sPartida: String;
  fCantidad, fAsignar: Double;
  bErr: Boolean;
  sMsg: String;
  iEjercicio, iPickingId, iIdExpedicion: Integer;
  sLineaPedidoCliente, sUdMedida: String;
  iMax: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1expedirPedidoAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'], 0 );
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  bErr := FALSE;
  sMsg := '';

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  FS_SGA_AcumuladoPendiente WITH (NOLOCK) ' +
          'WHERE ' +
          '  IdPreparacion = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  LineaPedidoCliente=''00000000-0000-0000-0000-000000000000'' ' +
          'ORDER BY ' +
          '  CodigoArticulo';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  if not bErr then try
    Q.Open;
    iMax := Q.RecordCount;
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  while (not bErr) and (not Q.EOF) do
  begin

    sCodigoArticulo := Q.FieldByName('CodigoArticulo').AsString;
    sPartida        := Q.FieldByName('Partida').AsString;
    fCantidad       := Q.FieldByName('Cantidad').AsFloat;
    iEjercicio      := Q.FieldByName('Ejercicio').AsInteger;

    sSQL := 'SELECT ' +
            '  * ' +
            'FROM ' +
            '  FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
            'WHERE ' +
            '  PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
            '  CodigoArticulo = ''' + SQL_Str(sCodigoArticulo) + ''' AND ' +
            '  UdSaldo > 0 ' +
            'ORDER BY ' +
            '  CodigoEmpresa, EjercicioPedido, SeriePedido, NumeroPedido';
    Q2 := SQL_PrepareQuery ( Conn, sSQL );

    if not bErr then try
      Q2.Open;
    except
      on E:Exception do begin
        sMsg := E.Message;
        bErr := TRUE;
      end;
    end;

    while (not bErr) and (fCantidad>0) and (not Q2.Eof) do begin

      fAsignar := Q2.FieldByName('UdSaldo').AsFloat;

      if (fAsignar > fCantidad) then begin
        fAsignar := fCantidad;
      end;

      iPickingId          := Q2.FieldByName('PickingId').AsInteger;
      sLineaPedidoCliente := Q2.FieldByName('LineasPosicion').AsString;
      sUdMedida           := Q2.FieldByName('UnidadMedida').AsString;
      iIdExpedicion       := Q2.FieldByName('IdentificadorExpedicion').AsInteger;

      sMsg := SGA_Reservar_stock_pedidoExpedicion(
                Conn,
                CodigoEmpresa,
                iEjercicio,
                sCodigoArticulo,
                sPartida,
                IdPreparacion,
                iPickingId,
                sLineaPedidoCliente,
                fAsignar,
                sUdMedida,
                fAsignar,
                sUdMedida,
                iIdExpedicion,
                1
              );

      if (sMsg <> '') then begin
        bErr := TRUE;
      end;

      fCantidad := fCantidad - fAsignar;

      if (not bErr) then try
        Q2.Next;
      except
        on E:Exception do begin
          sMsg := E.Message;
          bErr := TRUE;
        end;
      end;

    end;

    Q2.Close;
    FreeAndNil(Q2);

    if not bErr then try
      Q.Next;
    except
      on E:Exception do begin
        sMsg := E.Message;
        bErr := TRUE;
      end;
    end;

  end;

  Q.Close;
  FreeAndNil(Q);

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + sMsg + '","Data":[]}';
  end else begin
    Result := '{"Result":"OK","Error":"","Data":[]}';
  end;

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ REALITZAR UN MOVIMENT DE SORTIDA D'STOCK                              │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1salidaStockAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  fStock: Double;
  YY, DD, MM, HH, NN, SS, MS: WORD;
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  CodigoArticulo: String;
  Partida: String;
  Precio: Double;
  CodigoAlmacen: String;
  AlmacenContrapartida: String;
  Comentarios: String;
  Ubicacion: String;
  OrigenMovimiento: String;
  MovOrigen: String;
  Serie: String;
  Documento: Integer;
  NumeroSerieLc: String;
  EjercicioDocumento: Integer;
  EmpresaOrigen: Integer;
  FechaCaduca: String;
  CodigoCliente: String;
  CodigoCanal: String;
  Partida2_: String;
  CodigoColor_: String;
  GrupoTalla_: String;
  CodigoTalla01_: String;
  TipoMovimiento: Integer;
  Importe: Double;
  FactorConversion_: Double;
  Comentario: string;
  CodigoProveedor: string;
  IdProcesoIME: string;
  StatusTraspasadoIME: Integer;
  TipoImportacionIME: Integer;
  DocumentoUnico: Integer;
  FechaRegistro: TDateTime;
  MovPosicion: String;
  MovIdentificadorIME: String;
  bResult: Boolean;
  iLastID: Integer;
  Mensaje: String;
  iStatus: Integer;
  CodigoUbicacion: String;
  CodigoUsuario: Integer;
  IdDocumento: String;
  aUbicacion: TSGAUbicacion;
  Stock: Double;
  Unidades: Double;
  UnidadMedida: String;
  UnidadMedidaBase: String;
  UnidadesBase: Double;
  FactorConversion: Double;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1salidaStockAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUbicacion := request.contentfields.values['CodigoUbicacion'];

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacion );
  if aUbicacion.CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación incorrecto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoArticulo := request.contentfields.values['CodigoArticulo'];

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Unidades := StrToFloatDef ( StringReplace(request.contentfields.values['Unidades'], '.', ',', []), 0 );
  if Unidades=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades no pueden ser 0","Data":[]}';
    Exit;
  end;

  UnidadMedida     := trim ( request.contentfields.values['UnidadMedida'] );
  UnidadMedidaBase := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );

  if UnidadMedidaBase='' then
    Unidadmedida := '';

  UnidadesBase := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                    Unidades, UnidadMedidaBase, UnidadMedida, FactorConversion );

  if UnidadesBase=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades de medida son incorrectas","Data":[]}';
    Exit;
  end;

  Stock := SGA_ALMACEN_Stock ( Conn, CodigoEmpresa, CodigoAlmacen, CodigoUbicacion, CodigoArticulo, Partida, UnidadMedida );

  if (Unidades>Stock) then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No hay stock suficiente para realizar la salida","Data":[]}';
    Exit;
  end;

  DecodeDateTime ( Now(), YY, MM, DD, HH, NN, SS, MS );

  YY                   := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );
  Serie                := request.contentfields.values['Serie'];
  Documento            := StrToIntDef ( request.contentfields.values['Documento'], 0 );
  AlmacenContrapartida := request.contentfields.values['AlmacenContrapartida'];
  Partida              := request.contentfields.values['Partida'];
  Partida2_            := request.contentfields.values['Partida2_'];
  CodigoColor_         := request.contentfields.values['CodigoColor_'];
  GrupoTalla_          := request.contentfields.values['GrupoTalla_'];
  CodigoTalla01_       := request.contentfields.values['CodigoTalla01_'];
  TipoMovimiento       := StrToIntDef ( request.contentfields.values['TipoMovimiento'], 2 );
  Precio               := StrToFloatDef ( request.contentfields.values['Precio'], 0 );
  Importe              := Unidades * Precio;
  FactorConversion_    := FactorConversion; // StrToFloatDef ( request.contentfields.values['FactorConversion_'], 1.0 );
  Comentario           := request.contentfields.values['Comentario'];
  CodigoCanal          := request.contentfields.values['CodigoCanal'];
  CodigoCliente        := request.contentfields.values['CodigoCliente'];
  CodigoProveedor      := request.contentfields.values['CodigoProveedor'];
  FechaCaduca          := request.contentfields.values['FechaCaduca'];
  Ubicacion            := request.contentfields.values['Ubicacion'];
  OrigenMovimiento     := request.contentfields.values['OrigenMovimiento'];
  MovOrigen            := request.contentfields.values['MovOrigen'];
  EjercicioDocumento   := StrToIntDef ( request.contentfields.values['EjercicioDocumento'], 0 );
  NumeroSerieLc        := request.contentfields.values['NumeroSerieLc'];
  StatusTraspasadoIME  := 0;
  TipoImportacionIME   := 2;
  DocumentoUnico       := StrToIntDef ( request.contentfields.values['DocumentoUnico'], 0 );
  FechaRegistro        := Now();
  IdDocumento          := request.contentfields.values['IdDocumento'];

  try
    MovPosicion        := SQL_Execute ( Conn,'select NEWID()');
    MovPosicion        := StringReplace ( MovPosicion, '{', '', [] );
    MovPosicion        := StringReplace ( MovPosicion, '}', '', [] );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  try
    MovIdentificadorIME := SQL_Execute ( Conn,'select NEWID()');
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '{', '', [] );
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '}', '', [] );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  try
    IdProcesoIME := SQL_Execute ( Conn,'select NEWID()');
    IdProcesoIME := StringReplace ( IdProcesoIME, '{', '', [] );
    IdProcesoIME := StringReplace ( IdProcesoIME, '}', '', [] );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  if (IdDocumento='') or (IdDocumento='0') then begin
    IdDocumento := '00000000-0000-0000-0000-000000000000';
  end;

  if OrigenMovimiento='' then begin
    OrigenMovimiento := 'S';
  end;

  if FechaCaduca='' then begin
    FechaCaduca := 'NULL'
  end else begin
    FechaCaduca := '''' + FechaCaduca + '''';
  end;

  if (MovOrigen='') or (MovOrigen='0') then begin
    MovOrigen := '00000000-0000-0000-0000-000000000000';
  end;

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  iLastID := 0;
  iStatus := 1;

  sSQL := 'SELECT ' +
          '  sysContenidoIni ' +
          'FROM ' +
          '  lsysIni WITH (NOLOCK) ' +
          'WHERE ' +
          '  sysGrupo = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  sysFicheroIni = ''CUESTIONARIO'' AND ' +
          '  sysSeccion = ''GES'' AND ' +
          '  sysItem = ''StockNegativo'' ';
  giPermiteStockNegativo := SQL_Execute ( Conn, sSQL );

  if giPermiteStockNegativo=0 then begin

    fStock := SGA_ALMACEN_Stock ( Conn, CodigoEmpresa, CodigoAlmacen, CodigoUbicacion, CodigoArticulo, Partida, UnidadMedida );
    if fStock-Unidades<0 then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se permite stock negativo en SAGE","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

  end;

  SGA_FS_ALMACEN_PrepareMov ( gaMov );
  gaMov.CodigoEmpresa          := CodigoEmpresa;
  gaMov.EmpresaOrigen          := EmpresaOrigen;
  gaMov.CodigoUsuario          := CodigoUsuario;
  gaMov.Ejercicio              := YY;
  gaMov.Periodo                := MM;
  gaMov.Fecha                  := Date();
  gaMov.FechaHora              := Now();
  gaMov.CodigoAlmacen          := CodigoAlmacen;
  gaMov.CodigoUbicacion        := CodigoUbicacion;
  gaMov.CodigoArticulo         := CodigoArticulo;
  gaMov.Partida                := Partida;
  gaMov.TipoMovimiento         := TipoMovimiento;
  gaMov.OrigenMovimiento       := OrigenMovimiento;
  gaMov.Unidades               := Unidades;
  gaMov.UnidadMedida           := UnidadMedida;
  gaMov.UnidadesBase           := UnidadesBase;
  gaMov.UnidadMedidaBase       := UnidadMedidaBase;
  gaMov.FactorConversion       := FactorConversion;
  gaMov.Comentario             := Comentario;
  gaMov.IdProcesoIME           := IdProcesoIME;
  gaMov.IdDocumento            := IdDocumento;
  gaMov.Serie                  := Serie;
  gaMov.FechaCaduca            := FechaCaduca;
  gaMov.Precio                 := Precio;
  gaMov.MovOrigen              := MovOrigen;
  gaMov.CodigoProveedor        := CodigoProveedor;

  // Fem els moviments a les taules del SGA
  if not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, Mensaje ) then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' +  Mensaje + '","Data":[]}';
    Exit;
  end;

  sSQL := 'INSERT INTO ' +
          '  TmpIME_MovimientoStock ( ' +
          '    CodigoEmpresa, Ejercicio, Periodo, Fecha, Serie, Documento, ' +
          '    CodigoArticulo, CodigoAlmacen, AlmacenContrapartida, Partida, ' +
          '    Partida2_, CodigoColor_, GrupoTalla_, CodigoTalla01_, TipoMovimiento, ' +
          '    Unidades, UnidadMedida1_, Precio, Importe, Unidades2_, UnidadMedida2_, ' +
          '    FactorConversion_, Comentario, CodigoCanal, CodigoCliente, CodigoProveedor, ' +
          '    FechaCaduca, Ubicacion, OrigenMovimiento, EmpresaOrigen, MovOrigen, ' +
          '    EjercicioDocumento, NumeroSerieLc, IdProcesoIME, MovIdentificadorIME, ' +
          '    StatusTraspasadoIME, TipoImportacionIME, DocumentoUnico, FechaRegistro, ' +
          '    MovPosicion ' +
          '  ) ' +
          'VALUES ( ' +
          IntToStr(CodigoEmpresa) + ', ' +
          IntToStr(YY) + ', ' +
          IntToStr(MM) + ', ' +
          SQL_DateToStr ( Now() ) + ', ' +
          '''' + SQL_Str(Serie) + ''', ' +
          IntToStr(Documento) + ', ' +
          '''' + SQL_Str(CodigoArticulo) + ''', ' +
          '''' + SQL_Str(CodigoAlmacen) + ''', ' +
          '''' + SQL_Str(AlmacenContrapartida) + ''', ' +
          '''' + SQL_Str(Partida) + ''', ' +
          '''' + SQL_Str(Partida2_) + ''', ' +
          '''' + SQL_Str(CodigoColor_) + ''', ' +
          '''' + SQL_Str(GrupoTalla_) + ''', ' +
          '''' + SQL_Str(CodigoTalla01_) + ''', ' +
          IntToStr(TipoMovimiento) + ', ' +
          SQL_FloatToStr ( Unidades ) + ', '+
          '''' + SQL_Str( UnidadMedida ) + ''', ' +
          SQL_FloatToStr ( Precio ) + ', ' +
          SQL_FloatToStr ( Importe ) + ', ' +
          SQL_FloatToStr ( UnidadesBase ) + ', '+
          '''' + SQL_Str( UnidadMedidaBase ) + ''', ' +
          SQL_FloatToStr ( FactorConversion_ ) + ', '+
          '''' + SQL_Str( Comentario ) + ''', ' +
          '''' + SQL_Str( CodigoCanal ) + ''', ' +
          '''' + SQL_Str( CodigoCliente ) + ''', ' +
          '''' + SQL_Str( CodigoProveedor ) + ''', ' +
          FechaCaduca + ', ' +
          '''' + SQL_Str( Ubicacion ) + ''', ' +
          '''' + SQL_Str( OrigenMovimiento ) + ''', ' +
          IntToStr(EmpresaOrigen) + ', ' +
          '''' + SQL_Str( MovOrigen ) + ''', ' +
          IntToStr(EjercicioDocumento) + ', ' +
          '''' + SQL_Str( NumeroSerieLc ) + ''', ' +
          '''' + SQL_Str( IdProcesoIME ) + ''', ' +
          '''' + SQL_Str( MovIdentificadorIME ) + ''', ' +
          IntToStr(StatusTraspasadoIME) + ', ' +
          IntToStr(TipoImportacionIME) + ', ' +
          IntToStr(DocumentoUnico) + ', ' +
          SQL_DateTimeToStr ( FechaRegistro ) + ', ' +
          '''' + SQL_Str( MovPosicion ) + ''') ';

  try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  sSQL := 'INSERT INTO ' +
          '  FS_Operations ( oper_product_code, oper_name, oper_datetime, oper_params, oper_CodigoEmpresa ) ' +
          'VALUES ( ' +
          '''E4E8'', ' +
          '''MOVIMIENTOSTOCK'', ' +
          SQL_DateTimeToStr(Now()) + ', ' +
          '''{"IdProcesoIME":"' + IdProcesoIME + '","MantenerDatos":"1","MantenerErrores":"1","Módulos":"4","CodigoEmpresa":"' + IntToStr(CodigoEmpresa) + '"}'', ' +
          IntToStr(CodigoEmpresa) +
          ')';

  try
    SQL_Execute_NoRes ( Conn, sSQL );
    sSQL := 'SELECT IDENT_CURRENT(''FS_Operations'')';
    iLastID := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  Result := '{"Result":"OK","Error":"","Data":[]}';

  (*
  if (iLastID<>0) and (not WaitOperationDone ( Conn, iLastID, Status, Mensaje )) then begin

    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + Mensaje + '","Data":[]}';
    Response.Content := Result;
    Exit;

  end;

  if Status<>1 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + Mensaje + '","Data":[]}';
  end else begin
    Result := '{"Result":"OK","Error":"","Data":[]}';
  end;
  *)

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1servirDevolucionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  DevolucionId: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRechazos: String;
  UnidadesPedidas: Double;
  UnidadesRecibidas: Double;
  UnidadesPendientes: Double;
  bIgnorarPendientes: Boolean;
  sMsg: String;
  bErr: Boolean;
  iNum: Integer;
  sNewGuid: String;
  sNewMovOrigen: String;
  sOrigenMovimiento: String;
  Albaran: String;
  FechaAlbaran: TDate;
  CodigoProveedor: String;
  TratamientoPartidas: Boolean;
  CantidadEntrada: Double;
  CantidadRechazos: Double;
  UnidadMedidaEntrada: String;
  FechaCaducidad: TDate;
  Precio: Double;
  UnidadMedida: String;
  Cantidad: Double;
  Rechazos: Double;
  FactorConversion: Double;
  aUbicacion: TSGAUbicacion;
  aUbicacionRechazos: TSGAUbicacion;
  Partida: String;
  sOperparams: String;
  OperId: Integer;
  MascaraAlbaran: String;
  MascaraFactura: String;
  CopiasAlbaran: Integer;
  CopiasFactura: Integer;
  ImprimirAlbaran: Boolean;
  ImprimirFactura: Boolean;
  AlbaranValorado: Boolean;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1servirDevolucionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

 DevolucionId := StrToIntDef(request.contentfields.values['DevolucionId'],0);
  if DevolucionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de devolución no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  bIgnorarPendientes := StrToBoolDef(request.contentfields.values['IgnorarPendientes'], false);

  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraAlbaran,  MascaraAlbaran, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraFactura,  MascaraFactura, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasAlbaran,   CopiasAlbaran, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasFactura,   CopiasFactura, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirAlbaran, ImprimirAlbaran, False, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirFactura, ImprimirFactura, False, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_AlbaranValorado, AlbaranValorado, True, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Generar albarà de devolució'}

  sSQL := 'SELECT ' +
          '  Albaran, Fecha, CodigoCliente ' +
          'FROM ' +
          '  FS_SGA_Devoluciones WITH (NOLOCK) ' +
          'WHERE ' +
          '  DevolucionId = ' + IntToStr(DevolucionId);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  if Q.EOF then begin
    Q.Close;
    FreeAndNil(Q);
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de devolución no válido","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Albaran         := Q.FieldByName('Albaran').AsString;
  FechaAlbaran    := Trunc(Q.FieldByName('Fecha').AsDateTime);
  CodigoProveedor := Q.FieldByName('CodigoCliente').AsString;

  Q.Close;
  FreeAndNil(Q);

  sSQL := 'SELECT ' +
          '  SUM(UdPedidas) AS UnidadesPedidas, SUM(UdRecibidas) AS UnidadesRecibidas ' +
          'FROM ' +
          '  FS_SGA_Devoluciones_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  DevolucionId = ' + IntToStr(DevolucionId);
  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  if Q.EOF then begin
    Q.Close;
    FreeAndNil(Q);
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no válido","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  UnidadesPedidas    := Q.FieldByName('UnidadesPedidas').AsFloat;
  UnidadesRecibidas  := Q.FieldByName('UnidadesRecibidas').AsFloat;
  UnidadesPendientes := UnidadesPedidas - UnidadesRecibidas;

  Q.Close;
  FreeAndNil(Q);

  if (UnidadesPedidas=0) or (UnidadesRecibidas=0) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No hay unidades para devolver","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if (UnidadesPendientes>0) and (not bIgnorarPendientes) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Existen unidades pendientes de registrar.","Data":["Confirmar":1]}';
    Response.Content := Result;
    Exit;
  end;

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  try
    // // Conn.BeginTrans;
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(E.Message) + '" ,"Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  sMsg := '';
  bErr := FALSE;

  //...primer borrem totes aquelles linies de la recepción on no s'hagi recepcionat cap Unitat
  sSQL := 'DELETE FROM ' +
          '  FS_SGA_Devoluciones_Lineas ' +
          'WHERE ' +
          '  DevolucionId = ' + IntToStr(DevolucionId) + ' AND ' +
          '  UdRecibidas = 0';
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  sSQL := 'SELECT ' +
          '  art.TratamientoPartidas, srl.UnidadMedida1_ as UnidadMedidaPedido, srl.CodigoArticulo, srld.* ' +
          'FROM ' +
          '  FS_SGA_Devoluciones_Lineas srl WITH (NOLOCK) ' +
          'INNER JOIN ' +
          '  FS_COMMON_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  srl.CodigoArticulo = art.CodigoArticulo ' +
          'INNER JOIN ' +
          '  FS_SGA_Devoluciones_Lineas_Detalle srld WITH (NOLOCK) ' +
          'ON ' +
          '  srl.DevolucionId = srld.DevolucionId AND ' +
          '  srl.DevolucionIdLinea = srld.DevolucionIdLinea ' +
          'WHERE ' +
          '  srl.DevolucionId = ' + IntToStr(DevolucionId) + ' ' +
          'ORDER BY ' +
          '  srld.DevolucionIdLineaDetalle';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  if not bErr then try
    Q.Open;
    iNum := Q.RecordCount;
    if iNum=0 then begin
      sMsg := 'No se ha introducido ninguna cantidad en el detalle.';
      bErr := TRUE;
    end;
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  if not bErr then try
    sNewGuid           := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sNewMovOrigen      := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sOrigenMovimiento  := 'E';
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  while (not bErr) and (not Q.Eof) do begin

    CodigoArticulo          := Q.FieldByName('CodigoArticulo').AsString;
    TratamientoPartidas     := (Q.FieldByName('TratamientoPartidas').AsInteger<>0);
    CodigoUbicacion         := Q.FieldByName('CodigoUbicacion').AsString;
    CodigoUbicacionRechazos := Q.FieldByName('CodigoUbicacionRechazos').AsString;
    CantidadEntrada         := Q.FieldByName('UnidadesEntrada').AsFloat;
    CantidadRechazos        := Q.FieldByName('CantidadErrorEntrada').AsFloat;
    UnidadMedidaEntrada     := Q.FieldByName('UnidadMedida1_').AsString;
    FechaCaducidad          := Q.FieldByName('FechaCaducidad').AsDateTime;
    Precio                  := Q.FieldByName('Precio').AsCurrency;
    UnidadMedida            := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );
    Cantidad                := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                                 CantidadEntrada, UnidadMedida, UnidadMedidaEntrada, FactorConversion );
    Rechazos                := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                                 CantidadRechazos, UnidadMedida, UnidadMedidaEntrada, FactorConversion );

    aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacion );
    if aUbicacion.CodigoUbicacion='' then begin
      bErr := TRUE;
      sMsg := 'Algún código de ubicación no es correcto. Revise los datos introducidos.';
    end;

    aUbicacionRechazos := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacionRechazos );
    if (CantidadRechazos<>0) and (aUbicacionRechazos.CodigoUbicacion='') then begin
      bErr := TRUE;
      sMsg := 'Algún código de ubicación de rechazos no es correcto. Revise los datos introducidos.';
    end;

    if (TratamientoPartidas) then begin
      Partida := Trim(Q.FieldByName('Partida').AsString);
      if Partida='' then begin
        bErr := TRUE;
        sMsg := 'Alguno de los artículos no tienen especificada la partida';
      end;
    end else begin
      Partida := '';
    end;

    // Fem els moviments d'entrada a les ubicacions del magatzem del SGA
    SGA_FS_ALMACEN_PrepareMov ( gaMov );
    gaMov.CodigoEmpresa          := CodigoEmpresa;
    gaMov.EmpresaOrigen          := EmpresaOrigen;
    gaMov.CodigoUsuario          := CodigoUsuario;
    gaMov.Ejercicio              := YY;
    gaMov.Periodo                := MonthOf(Date());
    gaMov.Fecha                  := Date();
    gaMov.FechaHora              := Now();
    gaMov.CodigoAlmacen          := aUbicacion.CodigoAlmacen;
    gaMov.CodigoUbicacion        := aUbicacion.CodigoUbicacion;
    gaMov.CodigoArticulo         := CodigoArticulo;
    gaMov.Partida                := Partida;
    gaMov.Unidades               := CantidadEntrada;
    gaMov.UnidadMedida           := UnidadMedidaEntrada;
    gaMov.UnidadesBase           := Cantidad;
    gaMov.UnidadMedidaBase       := UnidadMedida;
    gaMov.FactorConversion       := FactorConversion;
    gaMov.TipoMovimiento         := 1;
    gaMov.OrigenMovimiento       := 'E';
    gaMov.Comentario             := 'Entrada de devolución';
    gaMov.IdProcesoIME           := sNewGuid;
    gaMov.FechaCaduca            := FechaCaducidad;
    gaMov.Precio                 := Precio;
    gaMov.Albaran                := Albaran;
    gaMov.FechaAlbaran           := FechaAlbaran;
    gaMov.CodigoProveedor        := CodigoProveedor;

    //...afegim a SGA_Movimiento_Almacen
    if not bErr then try
      bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
    except
      on e: exception do begin
        bErr := true;
        sMsg := e.Message;
      end;
    end;

    // Afegim rebutjos
    if (CantidadRechazos<>0) then begin

      gaMov.CodigoAlmacen          := aUbicacionRechazos.CodigoAlmacen;
      gaMov.CodigoUbicacion        := aUbicacionRechazos.CodigoUbicacion;
      gaMov.Unidades               := CantidadRechazos;
      gaMov.UnidadesBase           := Rechazos;
      gaMov.Comentario             := 'Entrada de rechazo de cliente';

      if not bErr then try
        bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
      except
        on e: exception do begin
          bErr := true;
          sMsg := e.Message;
        end;
      end;

    end;

    if not bErr then begin
      Q.Next;
    end;

  end;

  Q.Close;
  Q.Free;

  // Enviem la instrucció al servei per generar l'albarà
  sOperparams := '{' +
                 '"DevolucionId":"' + IntToStr(DevolucionId) + '",' +
                 '"EjercicioDocumento":"' + IntToStr(YY)+'",' +
                 '"CodigoEmpresa":"' + IntToStr(EmpresaOrigen) + '",' +
                 '"MascaraAlbaran":"' + SQL_Str(MascaraAlbaran) + '",' +
                 '"MascaraFactura":"' + SQL_Str(MascaraFactura) + '",' +
                 '"CopiasAlbaran":"' + IntToStr(CopiasAlbaran) + '",' +
                 '"CopiasFactura":"' + IntToStr(CopiasFactura) + '",' +
                 '"ImprimirAlbaran":"' + SQL_BooleanToStr(ImprimirAlbaran) + '",' +
                 '"ImprimirFactura":"' + SQL_BooleanToStr(ImprimirFactura) + '",' +
                 '"AlbaranValorado":"' + SQL_BooleanToStr(AlbaranValorado) + '"' +
                 '}';

  sSQL := 'INSERT INTO FS_Operations ( ' +
          '  oper_CodigoEmpresa, oper_name, oper_product_code, oper_mac_address, ' +
          '  oper_ip_address, oper_datetime, oper_status, oper_params ) ' +
          'OUTPUT ' +
          '  inserted.oper_id ' +
          'VALUES ( ' +
          IntToStr(EmpresaOrigen) + ',' +
          '''CREARDEVOLUCIONCLIENTE'',' +
          '''E4E8'',' +
          '''' + SQL_Str(NETWORK_LocalMAC()) + ''',' +
          '''' + SQL_Str(GetLocalIp) + ''',' +
          SQL_DatetimeToStr(Now()) + ', ' +
          '0,' +
          '''' + SQL_Str(sOperparams) + ''')';

  if not bErr then try
    OperId := SQL_Insert_Identity ( Conn, sSQL, 'oper_id' );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if OperId=-1 then begin
    bErr := TRUE;
    sMsg := 'Error al enviar la operación a SAGE';
  end;

  sSQL := 'UPDATE ' +
          '  FS_SGA_Devoluciones ' +
          'SET ' +
          '  Estado = 3, ' +
          '  Oper_Id = ' + IntToStr(OperId) + ' ' +
          'WHERE ' +
          '  DevolucionId = ' + IntToStr(DevolucionId);
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      sMsg := 'Se ha producido un error:' + #13 + #10 + E.Message;
      bErr := TRUE;
    end;
  end else begin
    // Conn.RollbackTrans;
  end;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(sMsg) + '","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Result := '{"Result":"OK","Error":"","Data":[]}';

  {$ENDREGION}

  Response.Content := Result;


end;

procedure WebModule1servirPreparacionAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  PreparacionId: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRechazos: String;
  UnidadesPedidas: Double;
  UnidadesRecibidas: Double;
  UnidadesPendientes: Double;
  bIgnorarPendientes: Boolean;
  sMsg: String;
  bErr: Boolean;
  iNum: Integer;
  sNewGuid: String;
  sNewMovOrigen: String;
  sOrigenMovimiento: String;
  Albaran: String;
  FechaAlbaran: TDate;
  CodigoProveedor: String;
  TratamientoPartidas: Boolean;
  CantidadEntrada: Double;
  CantidadRechazos: Double;
  UnidadMedidaEntrada: String;
  FechaCaducidad: TDate;
  Precio: Double;
  UnidadMedida: String;
  Cantidad: Double;
  Rechazos: Double;
  FactorConversion: Double;
  aUbicacion: TSGAUbicacion;
  aUbicacionRechazos: TSGAUbicacion;
  Partida: String;
  sOperparams: String;
  OperId: Integer;
  MascaraAlbaran: String;
  MascaraFactura: String;
  CopiasAlbaran: Integer;
  CopiasFactura: Integer;
  ImprimirAlbaran: Boolean;
  ImprimirFactura: Boolean;
  AlbaranValorado: Boolean;
  iUltimoPedido: Integer;
  UbicacionExpediciones: String;
  Unidades: Double;
  UnidadMedidaBase: string;
  UnidadesBase: Double;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
  iEjercicio: Integer;
  bMantenerRestos: Boolean;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1servirPreparacionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  sMsg := '';
  bErr := false;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  PreparacionId := StrToIntDef(request.contentfields.values['PreparacionId'],0);
  if PreparacionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario      := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );
  bIgnorarPendientes := StrToBoolDef(request.contentfields.values['IgnorarPendientes'], false);
  ImprimirAlbaran    := StrToBoolDef(request.ContentFields.Values['ImprimirAlbaran'], false );
  ImprimirFactura    := StrToBoolDef(request.ContentFields.Values['ImprimirFactura'], false );

  //PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirAlbaran, ImprimirAlbaran, False, EmpresaOrigen );
  //PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirFactura, ImprimirFactura, False, EmpresaOrigen );

  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraAlbaran,  MascaraAlbaran, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraFactura,  MascaraFactura, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasAlbaran,   CopiasAlbaran, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasFactura,   CopiasFactura, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_AlbaranValorado, AlbaranValorado, True, EmpresaOrigen );

  iEjercicio := SGA_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now );

  {$ENDREGION}

  {$REGION 'Generar albarans de la preparació'}

  bErr := FALSE;
  sMsg := '';

  // Busquem les diferentes comandes que composen la expedició
  sSQL := 'SELECT DISTINCT ' +
          '  CodigoEmpresa, EjercicioPedido, NumeroPedido, SeriePedido, CodigoCliente ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(PreparacionId) +
          '  AND UdRetiradas > 0 ' +
          '  AND UdExpedidas > 0 ' +
          'ORDER BY ' +
          '  CodigoCliente';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
      Q.Close;
      FreeAndNil(Q);
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' +
        '"No se han podido generar los albaranes de la preparación ' + IntToStr(PreparacionId) + '","Data":[]}';
      Response.Content := Result;
      gaLogFile.Write_DBException(E,sSQL,'ERROR: No se han podido generar los albaranes de la preparación ' +
        IntToStr(PreparacionId), LOG_LEVEL_ERROR );
      Exit;
    end;
  end;

  iNum := 0;

  while not Q.EOF do
  begin

    Inc(iNum);

    if (iNum = Q.RecordCount) then
      iUltimoPedido := 1
    else
      iUltimoPedido := 0;

    // Enviem la instrucció al servei per generar l'albarà
    sOperParams := '{' +
      '"PreparacionId":"' + IntToStr(PreparacionId) + '",' +
      '"EjercicioDocumento":"' + IntToStr(iEjercicio) + '",' +
      '"EjercicioPedido":"' + Q.FieldbyName('EjercicioPedido').asString + '",' +
      '"SeriePedido":"' + JSON_Str(Q.FieldbyName('SeriePedido').asString) + '",' +
      '"NumeroPedido":' + Q.FieldbyName('NumeroPedido').asString + ',' +
      '"UltimoPedido":' + intToStr(iUltimoPedido) + ',' +
      '"CodigoEmpresa":' + IntToStr(CodigoEmpresa) + ',' +
      '"MascaraAlbaran":"' + JSON_Str(MascaraAlbaran) + '",' +
      '"MascaraFactura":"' + JSON_Str(MascaraFactura) + '",' +
      '"CopiasAlbaran":"' + intToStr(CopiasAlbaran) + '",' +
      '"CopiasFactura":"' + intToStr(CopiasFactura) + '",' +
      '"ImprimirAlbaran":"' + SQL_BooleanToStr(ImprimirAlbaran) + '",' +
      '"ImprimirFactura":"' + SQL_BooleanToStr(ImprimirFactura) + '",' +
      '"AlbaranValorado":"' + SQL_BooleanToStr(AlbaranValorado) + '"' + '}';

    sSQL := 'INSERT INTO FS_Operations ( ' +
            '  oper_CodigoEmpresa, oper_name, oper_product_code, oper_mac_address, ' +
            '  oper_ip_address, oper_datetime, oper_status, oper_params ) ' +
            'OUTPUT ' +
            '  inserted.oper_id ' +
            'VALUES ( ' +
            IntToStr(CodigoEmpresa) + ', ' +
            '''CREARALBARANCLIENTE'', ' +
            '''' + CONST_SGA + ''', ' +
            '''' + SQL_Str(NETWORK_LocalMAC()) + ''', ' +
            '''' + SQL_Str(GetLocalIp) + ''', ' +
            SQL_DateTimeToStr(Now) + ', ' +
            '0, ' +
            '''' + SQL_Str(sOperParams) + ''')';

    try
      OperId := SQL_Insert_Identity ( Conn, sSQL, 'oper_id' );
    except
      on E: Exception do
      begin
        bErr := TRUE;
        sMsg := E.Message;
        gaLogFile.Write_DBException(E,sSQL,'ERROR: No se ha podido enviar la operación de crear albarán', LOG_LEVEL_ERROR);
      end;
    end;

    Q.Next;

  end;

  Q.Close;
  FreeAndNil(Q);

  if not bErr then
  begin

    sSQL := 'UPDATE ' +
            '  FS_SGA_Picking_Preparaciones ' +
            'SET ' +
            '  Oper_Id = ' + intToStr(OperId) + ' ' +
            'WHERE ' +
            '  PreparacionId = ' + IntToStr(PreparacionId);

    try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on E: Exception do
      begin
        bErr := true;
        sMsg := E.Message;
        gaLogFile.Write_DBException(E,sSQL,'ERROR: No se ha podido actualizar la preparación', LOG_LEVEL_ERROR);
      end;
    end;

  end;

  // Update FS_SGA_Picking_Estado_Pedido marcant com a preparació processada
  if not bErr then
  begin

    sSQL := 'UPDATE ' +
            '  FS_SGA_Picking_Estado_Pedido ' +
            'SET ' +
            '  Estado_pedido_InPicking = 3 ' +
            'WHERE ' +
            '  PreparacionId = ' + IntToStr(PreparacionId);

    try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on E: Exception do
      begin
        bErr := true;
        sMsg := E.Message;
        gaLogFile.Write_DBException(E,sSQL,'ERROR: No se ha podido actualizar el estado de la preparación', LOG_LEVEL_ERROR);
      end;
    end;

  end;

  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MantenerRestos, bMantenerRestos, TRUE );

  if (not bErr) and (bMantenerRestos) then
  begin

    // Esborrem les línies que no tenen quantitats preparades
    sSQL := 'DELETE FROM ' +
            '  FS_SGA_Picking_Pedido_Lineas ' +
            'WHERE ' +
            '  PreparacionId = ' + intToStr(PreparacionId) +
            '  AND UdExpedidas <= 0';

    try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on E: Exception do
      begin
        bErr := true;
        sMsg := E.Message;
        gaLogFile.Write_DBException(E,sSQL,'ERROR: No se ha podido actualizar el estado de la preparación', LOG_LEVEL_ERROR);
      end;
    end;

  end;

  // Marquem la preparació en estat 3 (creant albarà)
  if (not bErr) and (bMantenerRestos) then
  begin

    sSQL := 'UPDATE ' +
            '  FS_SGA_Picking_Preparaciones ' +
            'SET ' +
            '  Estado = 3 ' +
            'WHERE ' +
            '  PreparacionId = ' + intToStr(PreparacionId);
    try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on E: Exception do
      begin
        bErr := true;
        sMsg := E.Message;
        gaLogFile.Write_DBException(E,sSQL,'ERROR: No se ha podido actualizar el estado de la preparación', LOG_LEVEL_ERROR);
      end;
    end;

  end;

  Result := '{"Result":"OK","Error":"","Data":[]}';

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1servirPreparacionOldAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  PreparacionId: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRechazos: String;
  UnidadesPedidas: Double;
  UnidadesRecibidas: Double;
  UnidadesPendientes: Double;
  bIgnorarPendientes: Boolean;
  sMsg: String;
  bErr: Boolean;
  iNum: Integer;
  sNewGuid: String;
  sNewMovOrigen: String;
  sOrigenMovimiento: String;
  Albaran: String;
  FechaAlbaran: TDate;
  CodigoProveedor: String;
  TratamientoPartidas: Boolean;
  CantidadEntrada: Double;
  CantidadRechazos: Double;
  UnidadMedidaEntrada: String;
  FechaCaducidad: TDate;
  Precio: Double;
  UnidadMedida: String;
  Cantidad: Double;
  Rechazos: Double;
  FactorConversion: Double;
  aUbicacion: TSGAUbicacion;
  aUbicacionRechazos: TSGAUbicacion;
  Partida: String;
  sOperparams: String;
  OperId: Integer;
  MascaraAlbaran: String;
  MascaraFactura: String;
  CopiasAlbaran: Integer;
  CopiasFactura: Integer;
  ImprimirAlbaran: Boolean;
  ImprimirFactura: Boolean;
  AlbaranValorado: Boolean;
  iUltimoPedido: Integer;
  UbicacionExpediciones: String;
  Unidades: Double;
  UnidadMedidaBase: string;
  UnidadesBase: Double;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1servirPreparacionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  sMsg := '';
  bErr := false;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Articulos' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  PreparacionId := StrToIntDef(request.contentfields.values['PreparacionId'],0);
  if PreparacionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  bIgnorarPendientes := StrToBoolDef(request.contentfields.values['IgnorarPendientes'], false);

  ImprimirAlbaran := StrToBoolDef(request.ContentFields.Values['ImprimirAlbaran'], false );
  ImprimirFactura := StrToBoolDef(request.ContentFields.Values['ImprimirFactura'], false );
  //PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirAlbaran, ImprimirAlbaran, False, EmpresaOrigen );
  //PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirFactura, ImprimirFactura, False, EmpresaOrigen );

  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraAlbaran,  MascaraAlbaran, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraFactura,  MascaraFactura, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasAlbaran,   CopiasAlbaran, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasFactura,   CopiasFactura, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_AlbaranValorado, AlbaranValorado, True, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Generar albarà de preparació'}

  // Recollim la ubicació d'expedició per fer el traspàs de material
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, UbicacionExpediciones, EmpresaOrigen );

  sSQL := 'SELECT * FROM FS_SGA_AcumuladoPendiente WITH (NOLOCK) ' +
          'WHERE IdPreparacion = ' + IntToStr(PreparacionId) + ' AND ' +
          'PickingId<>0 AND ' +
          'Cantidad>0 ';
  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  while (not bErr) and (not Q.EOF) do begin

    CodigoArticulo     := Q.FieldByName('CodigoArticulo').AsString;
    Unidades           := Q.FieldByName('Cantidad').AsFloat;
    UnidadMedida       := Q.FieldByName('UnidadMedida').AsString;
    UnidadMedidaBase   := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );
    UnidadesBase       := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                            Unidades, UnidadMedidaBase, UnidadMedida, FactorConversion );
    sNewGuid           := SQL_Execute ( Conn, 'SELECT NEWID()' );

    SGA_FS_ALMACEN_PrepareMov ( gaMov );
    gaMov.CodigoEmpresa          := CodigoEmpresa;
    gaMov.EmpresaOrigen          := EmpresaOrigen;
    gaMov.CodigoUsuario          := CodigoUsuario;
    gaMov.Ejercicio              := YY;
    gaMov.Periodo                := MonthOf(Date());
    gaMov.Fecha                  := Date();
    gaMov.FechaHora              := Now();
    gaMov.CodigoAlmacen          := FS_SGA_CodigoAlmacen ( UbicacionExpediciones );
    gaMov.CodigoUbicacion        := UbicacionExpediciones;
    gaMov.CodigoArticulo         := CodigoArticulo;
    gaMov.Partida                := Q.FieldByName('Partida').AsString;
    gaMov.TipoMovimiento         := 2;
    gaMov.OrigenMovimiento       := 'S';
    gaMov.Unidades               := Unidades;
    gaMov.UnidadMedida           := UnidadMedida;
    gaMov.UnidadesBase           := UnidadesBase;
    gaMov.UnidadMedidaBase       := UnidadMedidaBase;
    gaMov.FactorConversion       := FactorConversion;
    gaMov.IdProcesoIME           := sNewGuid;
    gaMov.PreparacionId          := PreparacionId;
    gaMov.Comentario             := 'Salida de zona expedición';

    if not bErr then try
      bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
    except
      on E:Exception do begin
        bErr := TRUE;
        sMsg := E.Message;
      end;
    end;

    Q.Next;

  end;

  Q.Close;
  FreeAndNil(Q);

  sSQL := 'SELECT DISTINCT ' +
          '  CodigoEmpresa, EjercicioPedido, NumeroPedido, SeriePedido ' +
          'FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(PreparacionId) + ' AND ' +
          '  UdExpedidas > 0 ' +
          'ORDER BY ' +
          '  CodigoEmpresa, EjercicioPedido, SeriePedido, NumeroPedido';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  if not bErr then try
    Q.Open;
    iNum := 1;
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      FreeAndNil(Q);
      Exit;
    end;
  end;

  if (Q.Eof) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación sin líneas expedidas","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  try
    // Conn.BeginTrans;
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(E.Message) + '" ,"Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  while (not bErr) and (not Q.Eof) do begin

    if (iNum = Q.RecordCount) then begin
      iUltimoPedido := 1;
    end else begin
      iUltimoPedido := 0;
    end;

    // Enviem la instrucció al servei per generar l'albarà
    sOperparams := '{' +
                   '"PreparacionId":' + IntToStr(PreparacionId) + ',' +
                   '"EjercicioDocumento":' + IntToStr(YY) + ',' +
                   '"EjercicioPedido":' + Q.FieldbyName('EjercicioPedido').asString + ',' +
                   '"SeriePedido":"' + SQL_Str(Q.FieldbyName('SeriePedido').asString) + '",' +
                   '"NumeroPedido":' + Q.FieldbyName('NumeroPedido').asString+',' +
                   '"UltimoPedido":' + intToStr(iUltimoPedido) + ',' +
                   '"CodigoEmpresa":' + IntToStr(EmpresaOrigen) + ',' +
                   '"MascaraAlbaran":"' + SQL_Str(MascaraAlbaran) + '",' +
                   '"MascaraFactura":"' + SQL_Str(MascaraFactura) + '",' +
                   '"CopiasAlbaran":' + IntToStr(CopiasAlbaran) + ',' +
                   '"CopiasFactura":' + IntToStr(CopiasFactura) + ',' +
                   '"ImprimirAlbaran":' + SQL_BooleanToStr(ImprimirAlbaran) + ',' +
                   '"ImprimirFactura":' + SQL_BooleanToStr(ImprimirFactura) + ',' +
                   '"AlbaranValorado":' + SQL_BooleanToStr(AlbaranValorado) +
                   '}';

    sSQL := 'INSERT INTO FS_Operations ( '+
            '  oper_CodigoEmpresa, oper_name, oper_product_code, oper_mac_address, ' +
            '  oper_ip_address, oper_datetime, oper_status, oper_params ) ' +
            'OUTPUT ' +
            '  inserted.oper_id ' +
            'VALUES ( ' +
            IntToStr(EmpresaOrigen) + ',' +
            '''CREARALBARANCLIENTE'',' +
            '''E4E8'',' +
            '''' + SQL_Str(NETWORK_LocalMAC()) + ''',' +
            '''' + SQL_Str(GetLocalIp) + ''',' +
            SQL_DateTimeToStr(now) + ', ' +
            '0,' +
            '''' + SQL_Str(sOperparams) + ''')';

    if not bErr then try
      OperId := SQL_Insert_Identity ( Conn, sSQL, 'oper_id' );
    except
      on E:Exception do begin
        bErr := TRUE;
        sMsg := E.Message;
      end;
    end;

    if OperId=-1 then begin
      bErr := TRUE;
      sMsg := 'Error al enviar la operación a SAGE';
    end;

    Q.Next;
    Inc(iNum);

  end;

  //Update FS_SGA_Picking_Estado_Pedido marcant com a preparació processada
  sSQL := 'UPDATE ' +
          '  FS_SGA_Picking_Estado_Pedido ' +
          'SET ' +
          '  Estado_pedido_InPicking = 3 ' +
          'WHERE ' +
          '  PreparacionId='+IntToStr(PreparacionId);
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  // Esborrem les línies que no tenen quantitats preparades
  sSQL := 'DELETE FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  PreparacionId = ' + IntToStr(PreparacionId) + ' AND ' +
          '  UdRetiradas <= 0';

  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  sSQL := 'UPDATE ' +
          '  FS_SGA_Picking_Preparaciones ' +
          'SET ' +
          '  Estado = 3, ' +
          '  Oper_Id = ' + IntToStr(OperId) + ' ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(PreparacionId);
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end else begin
    // Conn.RollbackTrans;
  end;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(sMsg) + '","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Result := '{"Result":"OK","Error":"","Data":[]}';

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1servirRecepcionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  RecepcionId: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoArticulo: string;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  CodigoUsuario: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRechazos: String;
  UnidadesPedidas: Double;
  UnidadesRecibidas: Double;
  UnidadesPendientes: Double;
  bIgnorarPendientes: Boolean;
  sMsg: String;
  bErr: Boolean;
  iNum: Integer;
  sNewGuid: String;
  sNewMovOrigen: String;
  sOrigenMovimiento: String;
  Albaran: String;
  FechaAlbaran: TDate;
  CodigoProveedor: String;
  TratamientoPartidas: Boolean;
  CantidadEntrada: Double;
  CantidadRechazos: Double;
  UnidadMedidaEntrada: String;
  FechaCaducidad: TDate;
  Precio: Double;
  UnidadMedida: String;
  Cantidad: Double;
  Rechazos: Double;
  FactorConversion: Double;
  aUbicacion: TSGAUbicacion;
  aUbicacionRechazos: TSGAUbicacion;
  Partida: String;
  sOperparams: String;
  OperId: Integer;
  MascaraAlbaran: String;
  MascaraFactura: String;
  CopiasAlbaran: Integer;
  CopiasFactura: Integer;
  ImprimirAlbaran: Boolean;
  ImprimirFactura: Boolean;
  AlbaranValorado: Boolean;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1servirRecepcionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  RecepcionId := StrToIntDef(request.contentfields.values['RecepcionId'],0);
  if RecepcionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  bIgnorarPendientes := StrToBoolDef(request.contentfields.values['IgnorarPendientes'], false);

  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraAlbaran,  MascaraAlbaran, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_MascaraFactura,  MascaraFactura, '', EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasAlbaran,   CopiasAlbaran, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CopiasFactura,   CopiasFactura, 1, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirAlbaran, ImprimirAlbaran, False, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_ImprimirFactura, ImprimirFactura, False, EmpresaOrigen );
  PARAM_Read_Default ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_AlbaranValorado, AlbaranValorado, True, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Generar albarà de recepció'}

  sSQL := 'SELECT ' +
          '  Albaran, Fecha, CodigoProveedor ' +
          'FROM ' +
          '  FS_SGA_Recepciones WITH (NOLOCK) ' +
          'WHERE ' +
          '  RecepcionId = ' + IntToStr(RecepcionId);

  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  if Q.EOF then begin
    Q.Close;
    FreeAndNil(Q);
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no válido","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Albaran         := Q.FieldByName('Albaran').AsString;
  FechaAlbaran    := Trunc(Q.FieldByName('Fecha').AsDateTime);
  CodigoProveedor := Q.FieldByName('CodigoProveedor').AsString;

  Q.Close;
  FreeAndNil(Q);

  sSQL := 'SELECT ' +
          '  SUM(UdPedidas) AS UnidadesPedidas, SUM(UdRecibidas) AS UnidadesRecibidas ' +
          'FROM ' +
          '  FS_SGA_Recepciones_Lineas WITH (NOLOCK) ' +
          'WHERE ' +
          '  RecepcionId = ' + IntToStr(RecepcionId);
  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  if Q.EOF then begin
    Q.Close;
    FreeAndNil(Q);
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no válido","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  UnidadesPedidas    := Q.FieldByName('UnidadesPedidas').AsFloat;
  UnidadesRecibidas  := Q.FieldByName('UnidadesRecibidas').AsFloat;
  UnidadesPendientes := UnidadesPedidas - UnidadesRecibidas;

  Q.Close;
  FreeAndNil(Q);

  if (UnidadesPedidas=0) or (UnidadesRecibidas=0) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No hay unidades para recibir","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if (UnidadesPendientes>0) and (not bIgnorarPendientes) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Existen unidades pendientes de registrar.","Data":[{"Confirmar":1}]}';
    Response.Content := Result;
    Exit;
  end;

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  try
    // Conn.BeginTrans;
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(E.Message) + '" ,"Data":[]}';
      Response.Content := Result;
      Exit;
    end;
  end;

  sMsg := '';
  bErr := FALSE;

  //...primer borrem totes aquelles linies de la recepción on no s'hagi recepcionat cap Unitat
  sSQL := 'DELETE FROM ' +
          '  FS_SGA_Recepciones_Lineas ' +
          'WHERE ' +
          '  RecepcionId = ' + IntToStr(RecepcionId) + ' AND ' +
          '  UdRecibidas = 0';
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  sSQL := 'SELECT ' +
          '  art.TratamientoPartidas, srl.UnidadMedida1_ as UnidadMedidaPedido, srl.CodigoArticulo, srld.* ' +
          'FROM ' +
          '  FS_SGA_Recepciones_Lineas srl WITH (NOLOCK) ' +
          'INNER JOIN ' +
          '  FS_COMMON_TABLE_Articulos ( ' + IntToStr(CodigoEmpresa) + ' ) art ' +
          'ON ' +
          '  srl.CodigoArticulo = art.CodigoArticulo ' +
          'INNER JOIN ' +
          '  FS_SGA_Recepciones_Lineas_Detalle srld WITH (NOLOCK) ' +
          'ON ' +
          '  srl.RecepcionId = srld.RecepcionId AND ' +
          '  srl.RecepcionIdLinea = srld.RecepcionIdLinea ' +
          'WHERE ' +
          '  srl.RecepcionId = ' + IntToStr(RecepcionId) + ' ' +
          'ORDER BY ' +
          '  srld.RecepcionIdLineaDetalle';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  if not bErr then try
    Q.Open;
    iNum := Q.RecordCount;
    if iNum=0 then begin
      sMsg := 'No se ha introducido ninguna cantidad en el detalle.';
      bErr := TRUE;
    end;
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  if not bErr then try
    sNewGuid           := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sNewMovOrigen      := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sOrigenMovimiento  := 'E';
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  while (not bErr) and (not Q.Eof) do begin

    CodigoArticulo          := Q.FieldByName('CodigoArticulo').AsString;
    TratamientoPartidas     := (Q.FieldByName('TratamientoPartidas').AsInteger<>0);
    CodigoUbicacion         := Q.FieldByName('CodigoUbicacion').AsString;
    CodigoUbicacionRechazos := Q.FieldByName('CodigoUbicacionRechazos').AsString;
    CantidadEntrada         := Q.FieldByName('UnidadesEntrada').AsFloat;
    CantidadRechazos        := Q.FieldByName('CantidadErrorEntrada').AsFloat;
    UnidadMedidaEntrada     := Q.FieldByName('UnidadMedida1_').AsString;
    FechaCaducidad          := Q.FieldByName('FechaCaducidad').AsDateTime;
    Precio                  := Q.FieldByName('Precio').AsCurrency;
    UnidadMedida            := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );
    Cantidad                := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                                 CantidadEntrada, UnidadMedida, UnidadMedidaEntrada, FactorConversion );
    Rechazos                := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                                 CantidadRechazos, UnidadMedida, UnidadMedidaEntrada, FactorConversion );

    aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacion );
    if aUbicacion.CodigoUbicacion='' then begin
      bErr := TRUE;
      sMsg := 'Algún código de ubicación no es correcto. Revise los datos introducidos.';
    end;

    aUbicacionRechazos := SGA_ALMACEN_GetUbicacion ( Conn, CodigoEmpresa, CodigoUbicacionRechazos );
    if (CantidadRechazos<>0) and (aUbicacionRechazos.CodigoUbicacion='') then begin
      bErr := TRUE;
      sMsg := 'Algún código de ubicación de rechazos no es correcto. Revise los datos introducidos.';
    end;

    if (TratamientoPartidas) then begin
      Partida := Trim(Q.FieldByName('Partida').AsString);
      if Partida='' then begin
        bErr := TRUE;
        sMsg := 'Alguno de los artículos no tienen especificada la partida';
      end;
    end else begin
      Partida := '';
    end;

    // Fem els moviments d'entrada a les ubicacions del magatzem del SGA
    SGA_FS_ALMACEN_PrepareMov ( gaMov );
    gaMov.CodigoEmpresa          := CodigoEmpresa;
    gaMov.EmpresaOrigen          := EmpresaOrigen;
    gaMov.CodigoUsuario          := CodigoUsuario;
    gaMov.Ejercicio              := YY;
    gaMov.Periodo                := MonthOf(Date());
    gaMov.Fecha                  := Date();
    gaMov.FechaHora              := Now();
    gaMov.CodigoAlmacen          := aUbicacion.CodigoAlmacen;
    gaMov.CodigoUbicacion        := aUbicacion.CodigoUbicacion;
    gaMov.CodigoArticulo         := CodigoArticulo;
    gaMov.Partida                := Partida;
    gaMov.Unidades               := CantidadEntrada;
    gaMov.UnidadMedida           := UnidadMedidaEntrada;
    gaMov.UnidadesBase           := Cantidad;
    gaMov.UnidadMedidaBase       := UnidadMedida;
    gaMov.FactorConversion       := FactorConversion;
    gaMov.TipoMovimiento         := 1;
    gaMov.OrigenMovimiento       := 'E';
    gaMov.Comentario             := 'Entrada de proveedor';
    gaMov.IdProcesoIME           := sNewGuid;
    gaMov.FechaCaduca            := FechaCaducidad;
    gaMov.Precio                 := Precio;
    gaMov.Albaran                := Albaran;
    gaMov.FechaAlbaran           := FechaAlbaran;
    gaMov.CodigoProveedor        := CodigoProveedor;

    //...afegim a SGA_Movimiento_Almacen
    if not bErr then try
      bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
    except
      on e: exception do begin
        bErr := true;
        sMsg := e.Message;
      end;
    end;

    // Afegim rebutjos
    if (CantidadRechazos<>0) then begin

      gaMov.CodigoAlmacen          := aUbicacionRechazos.CodigoAlmacen;
      gaMov.CodigoUbicacion        := aUbicacionRechazos.CodigoUbicacion;
      gaMov.Unidades               := CantidadRechazos;
      gaMov.UnidadesBase           := Rechazos;
      gaMov.Comentario             := 'Entrada de rechazo de proveedor';

      if not bErr then try
        bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
      except
        on e: exception do begin
          bErr := true;
          sMsg := e.Message;
        end;
      end;

    end;

    if not bErr then begin
      Q.Next;
    end;

  end;

  Q.Close;
  Q.Free;

  // Enviem la instrucció al servei per generar l'albarà
  sOperparams := '{' +
                 '"RecepcionId":"' + IntToStr(RecepcionId) + '",' +
                 '"EjercicioDocumento":"' + IntToStr(YY)+'",' +
                 '"CodigoEmpresa":"' + IntToStr(EmpresaOrigen) + '",' +
                 '"MascaraAlbaran":"' + SQL_Str(MascaraAlbaran) + '",' +
                 '"MascaraFactura":"' + SQL_Str(MascaraFactura) + '",' +
                 '"CopiasAlbaran":"' + IntToStr(CopiasAlbaran) + '",' +
                 '"CopiasFactura":"' + IntToStr(CopiasFactura) + '",' +
                 '"ImprimirAlbaran":"' + SQL_BooleanToStr(ImprimirAlbaran) + '",' +
                 '"ImprimirFactura":"' + SQL_BooleanToStr(ImprimirFactura) + '",' +
                 '"AlbaranValorado":"' + SQL_BooleanToStr(AlbaranValorado) + '"' +
                 '}';

  sSQL := 'INSERT INTO FS_Operations ( ' +
          '  oper_CodigoEmpresa, oper_name, oper_product_code, oper_mac_address, ' +
          '  oper_ip_address, oper_datetime, oper_status, oper_params ) ' +
          'OUTPUT ' +
          '  inserted.oper_id ' +
          'VALUES ( ' +
          IntToStr(EmpresaOrigen) + ',' +
          '''CREARALBARANPROVEEDOR'',' +
          '''E4E8'',' +
          '''' + SQL_Str(NETWORK_LocalMAC()) + ''',' +
          '''' + SQL_Str(GetLocalIp) + ''',' +
          SQL_DatetimeToStr(Now()) + ', ' +
          '0,' +
          '''' + SQL_Str(sOperparams) + ''')';

  if not bErr then try
    OperId := SQL_Insert_Identity ( Conn, sSQL, 'oper_id' );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if OperId=-1 then begin
    bErr := TRUE;
    sMsg := 'Error al enviar la operación a SAGE';
  end;

  sSQL := 'UPDATE ' +
          '  FS_SGA_Recepciones ' +
          'SET ' +
          '  Estado = 3, ' +
          '  Oper_Id = ' + IntToStr(OperId) + ' ' +
          'WHERE ' +
          '  RecepcionId = ' + IntToStr(RecepcionId);
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on e: exception do begin
      bErr := true;
      sMsg := e.Message;
    end;
  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      sMsg := 'Se ha producido un error:' + #13 + #10 + E.Message;
      bErr := TRUE;
    end;
  end else begin
    // Conn.RollbackTrans;
  end;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(sMsg) + '","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Result := '{"Result":"OK","Error":"","Data":[]}';

  {$ENDREGION}

  Response.Content := Result;

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ REALITZA UNA SORTIDA I UNA ENTRADA AL MAGATZEM                        │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1traspasoStockAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  fStock: Double;
  YY, DD, MM, HH, NN, SS, MS: WORD;
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  CodigoArticulo: String;
  Partida: String;
  Precio: Double;
  CodigoAlmacen: String;
  CodigoAlmacenDestino: String;
  Comentarios: String;
  Ubicacion: String;
  UbicacionDestino: String;
  OrigenMovimiento: String;
  MovOrigen: String;
  Serie: String;
  Documento: Integer;
  NumeroSerieLc: String;
  EjercicioDocumento: Integer;
  EmpresaOrigen: Integer;
  FechaCaduca: String;
  CodigoCliente: String;
  CodigoCanal: String;
  Partida2_: String;
  CodigoColor_: String;
  GrupoTalla_: String;
  CodigoTalla01_: String;
  UnidadMedida1_: String;
  TipoMovimiento: Integer;
  Importe: Double;
  Unidades2_: Double;
  UnidadMedida2_: string;
  FactorConversion_: Double;
  Comentario: string;
  CodigoProveedor: string;
  IdProcesoIME: string;
  StatusTraspasadoIME: Integer;
  TipoImportacionIME: Integer;
  DocumentoUnico: Integer;
  FechaRegistro: TDateTime;
  MovPosicion: String;
  MovIdentificadorIME: String;
  bResult: Boolean;
  iLastID: Integer;
  Mensaje: String;
  iStatus: Integer;
  CodigoUbicacion: String;
  CodigoUsuario: Integer;
  CodigoUbicacionDestino: String;
  IdDocumento: String;
  sOrigenMovimiento: string;
  Unidades: Double;
  UnidadMedidaBase: String;
  UnidadesBase: Double;
  UnidadMedida: String;
  FactorConversion: Double;
  sIDCall: String;
  gaMov: TSGAMovimientoStock;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1traspasoStockAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  CodigoAlmacen := request.contentfields.values['CodigoAlmacen'];
  if CodigoAlmacen='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;

  CodigoAlmacenDestino := request.contentfields.values['CodigoAlmacenDestino'];
  if CodigoAlmacenDestino='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de almacén de destino no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;

  CodigoUbicacion := request.contentfields.values['CodigoUbicacion'];

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;

  CodigoUbicacionDestino := request.contentfields.values['CodigoUbicacionDestino'];

  // Conversió al codi d'article real
  CodigoUbicacionDestino := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacionDestino );

  if CodigoUbicacionDestino='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación de destino no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;

  CodigoArticulo := Trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo de destino no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;

  if CodigoArticulo='-1' then begin

    gaLogFile.Write ( 'TraspasoStock: ' +
      'Origen=' + CodigoUbicacion +
      ', Destino=' + CodigoUbicacionDestino +
      ', Artículo=TODOS' +
      ', Partida=TODAS' +
      ', Cantidad=TODO', sIDCall
    );

    Response.Content := SGA_ReubicarCompleto (
      Conn,
      request,
      CodigoEmpresa,
      CodigoAlmacen,
      CodigoUbicacion,
      CodigoAlmacenDestino,
      CodigoUbicacionDestino
    );
    Exit;

  end;

  Unidades := StrToFloatDef ( StringReplace(request.contentfields.values['Unidades'], '.', ',', []), 0 );
  if (Unidades=0) and (CodigoArticulo<>'-1') then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades no pueden ser 0","Data":[]}';
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;

  UnidadMedida     := trim ( request.contentfields.values['UnidadMedida'] );
  UnidadMedidaBase := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );

  if UnidadMedidaBase='' then
    Unidadmedida := '';

  UnidadesBase := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                Unidades, UnidadMedidaBase, UnidadMedida, FactorConversion );

  if UnidadesBase=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades de medida son incorrectas","Data":[]}';
    gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
    Exit;
  end;

  DecodeDateTime ( Now(), YY, MM, DD, HH, NN, SS, MS );

  YY                   := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );
  Serie                := request.contentfields.values['Serie'];
  Documento            := StrToIntDef ( request.contentfields.values['Documento'], 0 );
  IdDocumento          := request.contentfields.values['IdDocumento'];
  Partida              := request.contentfields.values['Partida'];
  Partida2_            := request.contentfields.values['Partida2_'];
  CodigoColor_         := request.contentfields.values['CodigoColor_'];
  GrupoTalla_          := request.contentfields.values['GrupoTalla_'];
  CodigoTalla01_       := request.contentfields.values['CodigoTalla01_'];
  Precio               := StrToFloatDef ( request.contentfields.values['Precio'], 0 );
  Importe              := Unidades * Precio;
  FactorConversion_    := FactorConversion; // StrToFloatDef ( request.contentfields.values['FactorConversion_'], 1.0 );
  Comentario           := request.contentfields.values['Comentario'];
  CodigoCanal          := request.contentfields.values['CodigoCanal'];
  CodigoCliente        := request.contentfields.values['CodigoCliente'];
  CodigoProveedor      := request.contentfields.values['CodigoProveedor'];
  FechaCaduca          := request.contentfields.values['FechaCaduca'];
  Ubicacion            := request.contentfields.values['Ubicacion'];
  sOrigenMovimiento    := request.contentfields.values['OrigenMovimiento'];
  MovOrigen            := request.contentfields.values['MovOrigen'];
  EjercicioDocumento   := StrToIntDef ( request.contentfields.values['EjercicioDocumento'], 0 );
  NumeroSerieLc        := request.contentfields.values['NumeroSerieLc'];
  StatusTraspasadoIME  := StrToIntDef ( request.contentfields.values['StatusTraspasadoIME'], 0 );
  TipoImportacionIME   := StrToIntDef ( request.contentfields.values['TipoImportacionIME'], 2 );
  DocumentoUnico       := StrToIntDef ( request.contentfields.values['DocumentoUnico'], 0 );
  FechaRegistro        := Now();

  try
    MovPosicion := SQL_Execute ( Conn, 'select NEWID()');
    MovPosicion := StringReplace ( MovPosicion, '{', '', [] );
    MovPosicion := StringReplace ( MovPosicion, '}', '', [] );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
      Exit;
    end;
  end;

  try
    MovIdentificadorIME := SQL_Execute ( Conn,'select NEWID()');
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '{', '', [] );
    MovIdentificadorIME := StringReplace ( MovIdentificadorIME, '}', '', [] );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
      Exit;
    end;
  end;

  try
    IdProcesoIME := SQL_Execute ( Conn, 'select NEWID()');
    IdProcesoIME := StringReplace ( IdProcesoIME, '{', '', [] );
    IdProcesoIME := StringReplace ( IdProcesoIME, '}', '', [] );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      Response.Content := Result;
      gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
      Exit;
    end;
  end;

  if (IdDocumento='') or (IdDocumento='0') then begin
    IdDocumento := '00000000-0000-0000-0000-000000000000';
  end;

  if FechaCaduca='' then begin
    FechaCaduca := 'NULL'
  end else begin
    FechaCaduca := '''' + FechaCaduca + '''';
  end;

  if (MovOrigen='') or (MovOrigen='0') then begin
    MovOrigen := SQL_Execute ( Conn,'select NEWID()');
    MovOrigen := StringReplace ( MovOrigen, '{', '', [] );
    MovOrigen := StringReplace ( MovOrigen, '}', '', [] );
  end;

  gaLogFile.Write ( 'TraspasoStock: ' +
    'Origen=' + CodigoUbicacion +
    ', Destino=' + CodigoUbicacionDestino +
    ', Artículo=' + CodigoArticulo +
    ', Partida=' + Partida +
    ', Cantidad=' + FormatFloat('#,0', Unidades), sIDCall
  );

  {$ENDREGION}

  {$REGION 'Realitzar operació'}

  iLastID := 0;
  iStatus := 1;

  if Unidades<>0 then begin

    sSQL := 'SELECT ' +
            '  sysContenidoIni ' +
            'FROM ' +
            '  lsysIni WITH (NOLOCK) ' +
            'WHERE ' +
            '  sysGrupo = ' + IntToStr(EmpresaOrigen) + ' AND ' +
            '  sysFicheroIni = ''CUESTIONARIO'' AND ' +
            '  sysSeccion = ''GES'' AND ' +
            '  sysItem = ''StockNegativo'' ';
    giPermiteStockNegativo := SQL_Execute ( Conn, sSQL );

    if giPermiteStockNegativo=0 then begin

      fStock := SGA_ALMACEN_Stock ( Conn, CodigoEmpresa, CodigoAlmacen, CodigoUbicacion, CodigoArticulo, Partida, UnidadMedida );
      if fStock-Unidades<0 then begin
        Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se permite stock negativo en SAGE","Data":[]}';
        Response.Content := Result;
        gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
        Exit;
      end;

    end;

    if Comentario='' then begin
      Comentario := 'Traspaso';
    end;

    // Fem el moviment de sortida a les taules del SGA
    TipoMovimiento := 2;
    if sOrigenMovimiento='' then begin
      OrigenMovimiento := 'T';
    end else begin
      OrigenMovimiento := sOrigenMovimiento;
    end;

    SGA_FS_ALMACEN_PrepareMov ( gaMov );
    gaMov.CodigoEmpresa          := CodigoEmpresa;
    gaMov.EmpresaOrigen          := EmpresaOrigen;
    gaMov.CodigoUsuario          := CodigoUsuario;
    gaMov.Ejercicio              := YY;
    gaMov.Periodo                := MM;
    gaMov.Fecha                  := Date();
    gaMov.FechaHora              := Now();
    gaMov.CodigoAlmacen          := CodigoAlmacen;
    gaMov.CodigoUbicacion        := CodigoUbicacion;
    gaMov.CodigoAlmacenDestino   := CodigoAlmacenDestino;
    gaMov.CodigoUbicacionDestino := CodigoUbicacionDestino;
    gaMov.CodigoArticulo         := CodigoArticulo;
    gaMov.Partida                := Partida;
    gaMov.TipoMovimiento         := 2;
    gaMov.OrigenMovimiento       := OrigenMovimiento;
    gaMov.Unidades               := Unidades;
    gaMov.UnidadMedida           := UnidadMedida;
    gaMov.UnidadesBase           := UnidadesBase;
    gaMov.UnidadMedidaBase       := UnidadMedidaBase;
    gaMov.FactorConversion       := FactorConversion;
    gaMov.Comentario             := Comentario;
    gaMov.IdProcesoIME           := IdProcesoIME;
    gaMov.IdDocumento            := IdDocumento;
    gaMov.Serie                  := Serie;
    gaMov.FechaCaduca            := FechaCaduca;
    gaMov.Precio                 := Precio;
    gaMov.MovOrigen              := MovOrigen;
    gaMov.CodigoProveedor        := CodigoProveedor;

    if not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, Mensaje ) then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' +  Mensaje + '","Data":[]}';
      gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
      Exit;
    end;

    // Fem el moviment d'entrada a les taules del SGA
    TipoMovimiento := 1;
    if sOrigenMovimiento='' then begin
      OrigenMovimiento := 'T';
    end else begin
      OrigenMovimiento := sOrigenMovimiento;
    end;

    gaMov.CodigoAlmacen          := CodigoAlmacenDestino;
    gaMov.CodigoUbicacion        := CodigoUbicacionDestino;
    gaMov.CodigoAlmacenDestino   := CodigoAlmacen;
    gaMov.CodigoUbicacionDestino := CodigoUbicacion;
    gaMov.TipoMovimiento         := 1;
    gaMov.OrigenMovimiento       := OrigenMovimiento;

    if not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, Mensaje ) then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' +  Mensaje + '","Data":[]}';
      gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
      Exit;
    end;

    // Si fem canvi de magatzem, fem els moviments a SAGE
    if CodigoAlmacen<>CodigoAlmacenDestino then begin

      sSQL := 'INSERT INTO ' +
              '  TmpIME_MovimientoStock ( ' +
              '    CodigoEmpresa, Ejercicio, Periodo, Fecha, Serie, Documento, ' +
              '    CodigoArticulo, CodigoAlmacen, AlmacenContrapartida, Partida, ' +
              '    Partida2_, CodigoColor_, GrupoTalla_, CodigoTalla01_, TipoMovimiento, ' +
              '    Unidades, UnidadMedida1_, Precio, Importe, Unidades2_, UnidadMedida2_, ' +
              '    FactorConversion_, Comentario, CodigoCanal, CodigoCliente, CodigoProveedor, ' +
              '    FechaCaduca, Ubicacion, OrigenMovimiento, EmpresaOrigen, MovOrigen, ' +
              '    EjercicioDocumento, NumeroSerieLc, IdProcesoIME, MovIdentificadorIME, ' +
              '    StatusTraspasadoIME, TipoImportacionIME, DocumentoUnico, FechaRegistro, ' +
              '    MovPosicion ' +
              '  ) ' +
              'VALUES ( ' +
              IntToStr(CodigoEmpresa) + ', ' +
              IntToStr(YY) + ', ' +
              IntToStr(MM) + ', ' +
              SQL_DateToStr ( Now() ) + ', ' +
              '''' + SQL_Str(Serie) + ''', ' +
              IntToStr(Documento) + ', ' +
              '''' + SQL_Str(CodigoArticulo) + ''', ' +
              '''' + SQL_Str(CodigoAlmacenDestino) + ''', ' +
              '''' + SQL_Str(CodigoAlmacen) + ''', ' +
              '''' + SQL_Str(Partida) + ''', ' +
              '''' + SQL_Str(Partida2_) + ''', ' +
              '''' + SQL_Str(CodigoColor_) + ''', ' +
              '''' + SQL_Str(GrupoTalla_) + ''', ' +
              '''' + SQL_Str(CodigoTalla01_) + ''', ' +
              '1, ' +
              SQL_FloatToStr ( Unidades ) + ', '+
              '''' + SQL_Str( UnidadMedida ) + ''', ' +
              SQL_FloatToStr ( Precio ) + ', ' +
              SQL_FloatToStr ( Importe ) + ', ' +
              SQL_FloatToStr ( UnidadesBase ) + ', '+
              '''' + SQL_Str( UnidadMedidaBase ) + ''', ' +
              SQL_FloatToStr ( FactorConversion_ ) + ', '+
              '''' + SQL_Str( Comentario ) + ''', ' +
              '''' + SQL_Str( CodigoCanal ) + ''', ' +
              '''' + SQL_Str( CodigoCliente ) + ''', ' +
              '''' + SQL_Str( CodigoProveedor ) + ''', ' +
              FechaCaduca + ', ' +
              '''' + SQL_Str( Ubicacion ) + ''', ' +
              '''T'', ' +
              IntToStr(EmpresaOrigen) + ', ' +
              '''' + SQL_Str( MovOrigen ) + ''', ' +
              IntToStr(EjercicioDocumento) + ', ' +
              '''' + SQL_Str( NumeroSerieLc ) + ''', ' +
              '''' + SQL_Str( IdProcesoIME ) + ''', ' +
              '''' + SQL_Str( MovIdentificadorIME ) + ''', ' +
              IntToStr(StatusTraspasadoIME) + ', ' +
              IntToStr(TipoImportacionIME) + ', ' +
              IntToStr(DocumentoUnico) + ', ' +
              SQL_DateTimeToStr ( FechaRegistro ) + ', ' +
              '''' + SQL_Str( MovPosicion ) + ''') ';

      try
        SQL_Execute_NoRes ( Conn, sSQL );
      except
        on E:Exception do begin
          Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
          Response.Content := Result;
          gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
          Exit;
        end;
      end;

      sSQL := 'INSERT INTO ' +
              '  FS_Operations ( oper_product_code, oper_name, oper_datetime, oper_params, oper_CodigoEmpresa ) ' +
              'VALUES ( ' +
              '''E4E8'', ' +
              '''MOVIMIENTOSTOCK'', ' +
              SQL_DateTimeToStr(Now()) + ', ' +
              '''{"IdProcesoIME":"' + IdProcesoIME + '","MantenerDatos":"1","MantenerErrores":"1","Módulos":"4","CodigoEmpresa":"' + IntToStr(CodigoEmpresa) + '"}'', ' +
              IntToStr(CodigoEmpresa) +
              ')';

      try
        SQL_Execute_NoRes ( Conn, sSQL );
        sSQL := 'SELECT IDENT_CURRENT(''FS_Operations'')';
        iLastID := SQL_Execute ( Conn, sSQL );
      except
        on E:Exception do begin
          Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
          Response.Content := Result;
          gaLogFile.Write ( 'ERROR: ' + Response.Content, sIDCall );
          Exit;
        end;
      end;

    end;

  end else begin

    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades no pueden ser 0","Data":[]}';
    Response.Content := Result;
    Exit;

  end;

  Result := '{"Result":"OK","Error":"","Data":[]}';

  (*
  if (iLastID<>0) and (not WaitOperationDone ( Conn, iLastID, Status, Mensaje )) then begin

    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + Mensaje + '","Data":[]}';
    Response.Content := Result;
    Exit;

  end;

  if Status<>1 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + Mensaje + '","Data":[]}';
  end else begin
    Result := '{"Result":"OK","Error":"","Data":[]}';
  end;
  *)

  {$ENDREGION}


  gaLogFile.Write ( 'Resultado trapaso: ' + Result + ' enviado a ' + Response.HTTPRequest.RemoteIP, sIDCall );
  Response.Content := Result;

end;


procedure WebModule1traspasoUbicacionDestinoAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  CodigoAlmacen: String;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoUbicacion: string;
  Ejercicio: Integer;
  EmpresaOrigen: Integer;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  CodigoArticulo: string;
  sFiltre: string;
  Tipo: string;
  CodUbi: String;
  aUbicacion: TSGAUbicacion;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1traspasoUbicacionDestinoAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoArticulo := trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );
  if CodigoArticulo='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo especificado incorrecto","Data":[]}';
    Exit;
  end;

  CodigoUbicacion := trim(request.contentfields.values['CodigoUbicacion']);

  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );
  if CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
    Exit;
  end;

  aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, EmpresaOrigen, CodigoUbicacion );
  if aUbicacion.CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de ubicación es incorrecto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Tipo := trim(request.contentfields.values['Tipo']);
  if (Tipo<>'ARTICULO') and (Tipo<>'SALIDAS') then // and (Tipo<>'VACIAS') then
    Tipo := 'ARTICULO';

  Ejercicio := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  if Tipo='SALIDAS' then begin

    sSQL := 'SELECT ' +
            '  COUNT(DISTINCT fstm.CodigoUbicacion) ' +
            'FROM ' +
            '  FS_SGA_TABLE_Movimientos ( ' + IntToStr(CodigoEmpresa) + ' ) fstm ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) u ' +
            'ON ' +
            '  fstm.CodigoAlmacen = u.CodigoAlmacen AND ' +
            '  fstm.CodigoUbicacion = u.CodigoUbicacion ' +
            'WHERE ' +
            '  fstm.CodigoAlmacen = ''' + SQL_Str(aUbicacion.CodigoAlmacen) + ''' AND ' +
            '  fstm.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
            '  fstm.CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacion) + ''' ) ' +
            'GROUP BY ' +
            '  fstm.CodigoUbicacion, u.CodigoAlternativo';

  end else if Tipo='ARTICULO' then begin

    sSQL := 'SELECT ' +
            '  COUNT(DISTINCT CodigoUbicacion) ' +
            'FROM ' +
            '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) fsas ' +
            'WHERE ' +
            '  CodigoAlmacen = ''' + SQL_Str(aUbicacion.CodigoAlmacen) + ''' AND ' +
            '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
            '  Ejercicio = ' + IntToStr(Ejercicio) + ' AND ' +
            '  Periodo = 99 AND ' +
            '  UnidadesSaldo <> 0 AND ' +
            '  CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacion) + ''' ) ';

  end;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
    if iTotalRegs>3 then
      iTotalRegs := 3;
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  if Tipo='SALIDAS' then begin

    sSQL := 'SELECT TOP 3 ' +
            '  fstm.CodigoUbicacion, u.CodigoAlternativo, '''' as Partida, ' +
            '  0 as UnidadesSaldo, u.CodigoAlternativo AS CodigoUbicacionAlternativo, ' +
            '  MAX(fstm.UnidadMedida) AS UnidadMedida, NULL AS FechaCaduca, ' +
            '  MAX(FechaHora) AS FechaUltimaSalida ' +
            'FROM ' +
            '  FS_SGA_TABLE_Movimientos ( ' + IntToStr(CodigoEmpresa) + ' ) fstm ' +
            'LEFT JOIN ' +
            '  FS_SGA_TABLE_Ubicaciones ( ' + IntToStr(CodigoEmpresa) + ' ) u ' +
            'ON ' +
            '  fstm.CodigoAlmacen = u.CodigoAlmacen AND ' +
            '  fstm.CodigoUbicacion = u.CodigoUbicacion ' +
            'WHERE ' +
            '  fstm.CodigoAlmacen = ''' + SQL_Str(aUbicacion.CodigoAlmacen) + ''' AND ' +
            '  fstm.CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
            '  fstm.CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacion) + ''' ) ' +
            'GROUP BY ' +
            '  fstm.CodigoUbicacion, u.CodigoAlternativo ' +
            'ORDER BY ' +
            '  MAX(FechaHora) DESC';

  end else if Tipo='ARTICULO' then begin

    sSQL := 'SELECT ' +
            '  CodigoUbicacion, CodigoUbicacionAlternativo, Partida, UnidadesSaldo, ' +
            '  FechaUltimaSalida, CodigoAlternativo, UnidadMedida, FechaCaduca ' +
            'FROM ' +
            '  dbo.FS_SGA_TABLE_AcumuladoStock ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
            'WHERE ' +
            '  CodigoAlmacen = ''' + SQL_Str(aUbicacion.CodigoAlmacen) + ''' AND ' +
            '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
            '  Ejercicio = ' + IntToStr(Ejercicio) + ' AND ' +
            '  Periodo = 99 AND ' +
            '  UnidadesSaldo <> 0 AND ' +
            '  CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacion) + ''' ) ' +
            'ORDER BY ' +
            '  Partida ' +
            'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
            'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  end;

Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
      '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoUbicacionAlternativo').AsString) + '",' +
      '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
      '"FechaCaducidad":"' + JSON_Str(Q.FieldByName('FechaCaduca').AsString) + '",' +
      '"FechaUltimaSalida":"' + JSON_Str(Q.FieldByName('FechaUltimaSalida').AsString) + '",' +
      '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
      '"UnidadesSaldo":' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat) +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ ACTUALITZA LES CAIXES I PALETS D'UNA LÍNIA DE PREPARACIÓ              │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1ubicacionesDevolucionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  Result: String;
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  CodigoUbicacionDevolucion: String;
  CodigoUbicacionDevolucionRechazos: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1ubicacionesDevolucionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionDevolucion,         CodigoUbicacionDevolucion, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionDevolucionRechazos, CodigoUbicacionDevolucionRechazos, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  Result := '{"Result":"OK","Error":"","TotalRecords":0,"NumPages":0,"NumRecords":0,"Data":[';

  Result := Result + '{' +
                     '"CodigoUbicacionRecepcion":"' + JSON_Str(CodigoUbicacionDevolucion) + '",' +
                     '"CodigoUbicacionRecepcionRechazos":"' + JSON_Str(CodigoUbicacionDevolucionRechazos) + '"' +
                     '}';

  Result := Result + ']}';

  {$ENDREGION}

  Response.Content := Result;

end;

procedure WebModule1ubicacionesRecepcionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  Result: String;
  EmpresaOrigen: Integer;
  CodigoEmpresa: Integer;
  CodigoUbicacionRecepcion: String;
  CodigoUbicacionRecepcionRechazos: String;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1ubicacionesRecepcionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcion,         CodigoUbicacionRecepcion, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_CodigoUbicacionRecepcionRechazos, CodigoUbicacionRecepcionRechazos, EmpresaOrigen );

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  Result := '{"Result":"OK","Error":"","TotalRecords":0,"NumPages":0,"NumRecords":0,"Data":[';

  Result := Result + '{' +
                     '"CodigoUbicacionRecepcion":"' + JSON_Str(CodigoUbicacionRecepcion) + '",' +
                     '"CodigoUbicacionRecepcionRechazos":"' + JSON_Str(CodigoUbicacionRecepcionRechazos) + '"' +
                     '}';

  Result := Result + ']}';

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │  \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1updateCabeceraRecepcionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  EmpresaOrigen: Integer;
  CodigoEmpresa: Integer;
  CodigoUsuario: Integer;
  IdRecepcion: Integer;
  Result: String;
  sSQL: String;
  Data: String;
  bErr: Boolean;
  sMsg: string;
  Bultos: Integer;
  Cajas: Integer;
  Palets: Integer;
  Transportista: Integer;
  RefAlbaran: String;
  FechaAlbaran: TDate;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1updateCabeceraRecepcionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  IdRecepcion := StrToIntDef(request.contentfields.values['IdRecepcion'],0);
  if IdRecepcion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Bultos := StrToIntDef(request.contentfields.values['Bultos'],0);
  Cajas  := StrToIntDef(request.contentfields.values['Cajas'],0);
  Palets := StrToIntDef(request.contentfields.values['Palets'],0);

  Transportista := StrToIntDef(request.contentfields.values['Transportista'],0);
  RefAlbaran    := Trim(request.contentfields.values['RefAlbaran']);
  FechaAlbaran  := StrToDateDef ( request.contentfields.values['FechaAlbaran'], Date() );

  {$ENDREGION}

  {$REGION 'Guardar les dades'}

  sMsg := '';
  bErr := FALSE;

  try
    // Conn.BeginTrans;
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  sSQL := 'UPDATE ' +
          '  FS_SGA_Recepciones ' +
          'SET ' +
          '  Bultos = ' + IntToStr(Bultos) + ', ' +
          '  Cajas = ' + IntToStr(Cajas) + ', ' +
          '  Palets = ' + IntToStr(Palets) + ', ' +
          '  RefNumeroAlbaran = ''' + SQL_Str(RefAlbaran) + ''', ' +
          '  RefFechaAlbaran = ' + SQL_DateToStr(FechaAlbaran) + ' ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  RecepcionId = ' + IntToStr(IdRecepcion);
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + JSON_Str(sMsg) + '"}';
  end else begin
    Result := '{"Result":"OK","Error":""}';
  end;

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │                                                                       │  \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1updateCajasPaletsAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  PickingId: Integer;
  Result: String;
  sSQL: String;
  Data: String;
  Desglose: String;
  lJSonValue: TJSonValue;
  AutoId: Integer;
  Caja: string;
  Palet: string;
  Unidades: Double;
  bErr: Boolean;
  sMsg: string;
  Partida: string;
  sIDCall: String;
  JSonObject: TJSONObject;
  JSonValue: TJSONValue;
  JSonArray: TJSONArray;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1updateCajasPaletsAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  CodigoEmpresa := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if CodigoEmpresa=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  PickingId := StrToIntDef(request.contentfields.values['PickingId'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de línea de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Data := (request.contentfields.values['Data']);
  if Data='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se han especificado los datos","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  JSonObject := _Parse_JSonObject ( Data );
  JSonValue  := JSonObject.Get('Desglose').JsonValue;

  if JSonValue=nil then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Los datos especificados no son válidos","Data":[]}';
    JSonObject.Free;
    Response.Content := Result;
    Exit;
  end;

  JSonArray := TJSONArray(JSonValue);

  {$ENDREGION}

  {$REGION 'Guardar les dades'}

  sMsg := '';
  bErr := FALSE;

  try
    // Conn.BeginTrans;
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  sSQL := 'DELETE FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas_Detalle ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  PickingId = ' + IntToStr(PickingId);
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if not bErr then begin

    for lJSonValue in JSonArray do begin

      AutoId   := StrToIntDef(_Get_JSonValue ( lJSonValue, 'AutoId' ),0);
      Caja     := Trim(_Get_JSonValue ( lJSonValue, 'Caja' ));
      Palet    := Trim(_Get_JSonValue ( lJSonValue, 'Palet' ));
      Partida  := Trim(_Get_JSonValue ( lJSonValue, 'Partida' ));
      Unidades := StrToFloatDef( StringReplace(_Get_JSonValue ( lJSonValue, 'Unidades' ),'.',',',[]),0);

      sSQL := 'INSERT INTO FS_SGA_Picking_Pedido_Lineas_Detalle ( ' +
              '  PreparacionId, PickingId, Partida, Caja, Palet, Unidades ) ' +
              'VALUES ( ' +
              IntToStr(IdPreparacion) + ', ' +
              IntToStr(PickingId) + ', ' +
              '''' + SQL_Str(Partida) + ''', ' +
              '''' + SQL_Str(Caja) + ''', ' +
              '''' + SQL_Str(Palet) + ''', ' +
              SQL_FloatToStr(Unidades) + ' )';
      if not bErr then try
        SQL_Execute_NoRes ( Conn, sSQL );
      except
        on E:Exception do begin
          bErr := TRUE;
          sMsg := E.Message;
        end;
      end;

    end;

  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  JSonObject.Free;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + JSON_Str(sMsg) + '"}';
  end else begin
    Result := '{"Result":"OK","Error":""}';
  end;

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ ACTUALITZA LA QUANTITAT UTILITZADA EN UNA LÍNIA DE PREPARACIÓ         │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1updateCantidadPreparacionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  EmpresaOrigen: Integer;
  IdPreparacion: Integer;
  PickingId: Integer;
  Result: String;
  sSQL: String;
  Data: String;
  Desglose: String;
  lJSonValue: TJSonValue;
  CodigoUbicacion: String;
  CodigoArticulo: String;
  Partida: String;
  LineasPosicion: String;
  Q: TADOQuery;
  aUbicacion: TSGAUbicacion;
  Stock: Double;
  UnidadesPendientes: Double;
  bErr: Boolean;
  sMsg: String;
  sNewGuid: String;
  sNewMovOrigen: String;
  sOrigenMovimiento: String;
  YY: Integer;
  CodigoUsuario: Integer;
  iNum: Integer;
  Unidades: Double;
  UnidadMedida: String;
  UnidadesBase: Double;
  UnidadMedidaBase: String;
  FactorConversion: Double;
  TratamientoPartidas: Boolean;
  CodigoUbicacionExpedicion: String;
  aUbicacionExpedicion: TSGAUbicacion;
  CodigoAlmacenUbicacion: String;
  PartidaPedido: String;
  sStr: string;
  TipoEntrada, TipoSalida: String;
  DescripcionEntrada, DescripcionSalida: String;
  sOperparams: String;
  bRecalcularRuta: Boolean;
  bResult: Boolean;
  iUnidadesNecesarias: Double;
  iUnidadesRetiradas: Double;
  sIDCall: String;
  iIntents: Integer;
  gaMov: TSGAMovimientoStock;
  bAutoExpedicion: Boolean;
  iNumPedidos: Integer;
  bIsBuilding: Boolean;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1updateCantidadPreparacionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  YY := SGA_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  CodigoArticulo := Trim(request.contentfields.values['CodigoArticulo']);

  // Conversió al codi d'article real
  CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

  if CodigoArticulo=''then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  TratamientoPartidas := ARTICULO_TratamientoPartida ( Conn, CodigoEmpresa, CodigoArticulo );

  PartidaPedido := Trim(request.contentfields.values['PartidaPedido']);

  (*
  if (PartidaPedido='') and (TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de partida del pedido no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if (PartidaPedido<>'') and (not TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo del pedido no requiere partida","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  *)

  Partida := Trim(request.contentfields.values['Partida']);
  if (Partida='') and (TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de partida no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  if (Partida<>'') and (not TratamientoPartidas) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de artículo no requiere partida","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  CodigoUbicacion := Trim(request.ContentFields.Values['CodigoUbicacion']);

  // Conversió al codi d'article real
  CodigoUbicacion        := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );
  CodigoAlmacenUbicacion := FS_SGA_CodigoAlmacen ( CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de ubicación no especificado","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_TipoMovimientoEntradaExpedicion, TipoEntrada, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_TipoMovimientoSalidaExpedicion, TipoSalida, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_DescripcionEntradaExpedicion, DescripcionEntrada, EmpresaOrigen );
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_DescripcionSalidaExpedicion, DescripcionSalida, EmpresaOrigen );

  aUbicacionExpedicion := SGA_ALMACEN_GetUbicacion ( Conn, EmpresaOrigen, CodigoUbicacionExpedicion );
  if aUbicacionExpedicion.CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de ubicación de expedición no definido en parámetros","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Unidades := FS_StrToFloatDef ( Trim(request.contentfields.values['Cantidad']), 0 );
  if Unidades=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Cantidad no especificada","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  aUbicacion := SGA_ALMACEN_GetUbicacion ( Conn, EmpresaOrigen, CodigoUbicacion );
  if aUbicacion.CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El código de ubicación es incorrecto","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  UnidadMedida     := trim ( request.contentfields.values['UnidadMedida'] );
  UnidadMedidaBase := FS_SGA_ARTICULO_UnidadBase ( Conn, CodigoEmpresa, CodigoArticulo );

  if UnidadMedidaBase='' then
    Unidadmedida := '';

  UnidadesBase := SGA_FS_ARTICULO_ConversionUnidades ( Conn, CodigoEmpresa, CodigoArticulo,
                    Unidades, UnidadMedidaBase, UnidadMedida, FactorConversion );

  if UnidadesBase=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Las unidades de medida son incorrectas","Data":[]}';
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  Stock := SGA_ALMACEN_Stock ( Conn, EmpresaOrigen, aUbicacion.CodigoAlmacen, CodigoUbicacion, CodigoArticulo, Partida, UnidadMedida );
  if Unidades>Stock then begin
    Result := '{"Almacen":"' + JSON_Str(aUbicacion.CodigoAlmacen) + '","Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La cantidad es superior al stock de la ubicación del almacén","Data":[]}';
    Response.Content := Result;
    gaLogFile.Write ( Response.Content, sIDCall  );
    Exit;
  end;

  sSQL := 'SELECT SUM(UdNecesarias) - MAX(UdRetiradas) ' +
          'FROM   FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
          'WHERE PreparacionId = ' + IntToStr(IdPreparacion) + ' ' +
          'AND CodigoArticulo=''' + SQL_Str(CodigoArticulo) + '''';
  UnidadesPendientes := SQL_Execute ( Conn, sSQL );

  gaLogFile.Write ( 'Unidades pendientes = ' + FloatToStr(UnidadesPendientes) + ', Unidades = ' + FloatToStr(Unidades) + ', Stock = ' + FloatToStr(Stock), sIDCall  );
  if Unidades=Stock then begin
    // Mirar si en quedaran de pendents
    if (UnidadesPendientes-Unidades)>0 then begin
      gaLogFile.Write ( 'Recalcular ruta = true' , sIDCall );
      bRecalcularRuta := true;
    end;
  end;

  // Mirem si fem expedició automàtica quan només tenim un pedido
  (*
  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_AutoExpedicion, bAutoExpedicion, EmpresaOrigen );

  // Ens assegurem que només tinguem una sola comanda si tenim AutoExpedició
  if bAutoExpedicion then
  begin

    sSQL := 'SELECT COUNT ( * ) ' +
            'FROM ' +
            '  FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
            'WHERE ' +
            '  PreparacionId = ' + IntToStr(IdPreparacion);
    iNumPedidos := SQL_Execute ( Conn, sSQL );

    if iNumPedidos>1 then
    begin
      bAutoExpedicion := FALSE;
      gaLogFile.Write ( 'Se han seleccionado más de un pedido y no se puede realizar la autoexpedición', sIDCall );
    end;

  end;
  *)

  {$ENDREGION}

  sStr := '  Preparacion    : ' + IntToStr(IdPreparacion) + #13 + #10 +
          '                       CodigoArticulo : ' + CodigoArticulo + #13 + #10 +
          '                       Partida        : ' + Partida + #13 + #10 +
          '                       CodigoUbicacion: ' + CodigoUbicacion + #13 + #10 +
          '                       Destino        : ' + CodigoUbicacionExpedicion + #13 + #10 +
          '                       Cantidad       : ' + FloatToStr(Unidades) + #13 + #10 +
          '                       Autoexpedicion : ' + BoolToStr(bAutoExpedicion) + #13 + #10;
  gaLogFile.Write ( sStr, sIDCall  );

  {$REGION 'Guardar les dades'}

  bErr := FALSE;
  sMsg := '';

  if not bErr then try
    sNewGuid           := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sNewMovOrigen      := SQL_Execute ( Conn, 'SELECT NEWID()' );
    sOrigenMovimiento  := 'S';
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if not bErr then
  begin

    gaLogFile.Write ( 'SGA_Reservar_stock_pedido', sIDCall  );

    iIntents := 1;

    while (iIntents<=3) do begin

      bErr := not SGA_Reservar_stock_pedido (
        Conn,
        EmpresaOrigen,
        YY,
        '',
        '',
        CodigoArticulo,
        Partida,
        IdPreparacion,
        0,
        '',
        Unidades,
        UnidadMedida,
        UnidadesBase,
        UnidadMedidaBase,
        sMsg
      );

      if bErr then
        gaLogFile.Write ( 'After SGA_Reservar_stock_pedido: ERROR (intent ' + inttostr(iIntents) + ')', sIDCall  )
      else
        gaLogFile.Write ( 'After SGA_Reservar_stock_pedido: OK', sIDCall );

      if bErr then begin
        Inc(iIntents);
        Sleep(1000);
      end else begin
        iIntents := 999;
      end;

    end;

  end;

  if bErr then
    gaLogFile.Write ( 'ERROR: ' + sMsg, sIDCall );

  SGA_FS_ALMACEN_PrepareMov ( gaMov );
  gaMov.CodigoEmpresa          := CodigoEmpresa;
  gaMov.EmpresaOrigen          := EmpresaOrigen;
  gaMov.CodigoUsuario          := CodigoUsuario;
  gaMov.Ejercicio              := YY;
  gaMov.Periodo                := MonthOf(Date());
  gaMov.Fecha                  := Date();
  gaMov.FechaHora              := Now();
  gaMov.CodigoAlmacen          := aUbicacion.CodigoAlmacen;
  gaMov.CodigoUbicacion        := CodigoUbicacion;
  gaMov.CodigoArticulo         := CodigoArticulo;
  gaMov.Partida                := Partida;
  gaMov.TipoMovimiento         := 2;
  gaMov.OrigenMovimiento       := TipoSalida;
  gaMov.Unidades               := Unidades;
  gaMov.UnidadMedida           := UnidadMedida;
  gaMov.UnidadesBase           := UnidadesBase;
  gaMov.UnidadMedidaBase       := UnidadMedidaBase;
  gaMov.FactorConversion       := FactorConversion;
  gaMov.IdProcesoIME           := sNewGuid;
  gaMov.Comentario             := 'SGAMobile: ' + DescripcionSalida;
  gaMov.PreparacionId          := IdPreparacion;
  gaMov.MovOrigen              := sNewMovOrigen;

  if TipoSalida='T' then begin
    gaMov.CodigoAlmacenDestino   := aUbicacionExpedicion.CodigoAlmacen;
    gaMov.CodigoUbicacionDestino := aUbicacionExpedicion.CodigoUbicacion;
  end;

  if not bErr then try
    gaLogFile.Write ( 'SGA_FS_ALMACEN_MovimientoStock salida', sIDCall );
    bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  gaMov.FechaHora              := Now();
  gaMov.CodigoAlmacen          := aUbicacionExpedicion.CodigoAlmacen;
  gaMov.CodigoUbicacion        := CodigoUbicacionExpedicion;
  gaMov.CodigoArticulo         := CodigoArticulo;
  gaMov.TipoMovimiento         := 1;
  gaMov.OrigenMovimiento       := TipoEntrada;
  gaMov.Comentario             := 'SGAMobile: ' + DescripcionEntrada;

  if TipoSalida='T' then begin
    gaLogFile.Write ( 'SGA_FS_ALMACEN_MovimientoStock traspaso', sIDCall  );
    gaMov.CodigoAlmacenDestino   := aUbicacion.CodigoAlmacen;
    gaMov.CodigoUbicacionDestino := aUbicacion.CodigoUbicacion;
  end;

  if not bErr then try
    gaLogFile.Write ( 'SGA_FS_ALMACEN_MovimientoStock entrada', sIDCall  );
    bErr := not SGA_FS_ALMACEN_MovimientoStock ( Conn, gaMov, sMsg, sIDCall );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  // Fem els moviments a Sage si els magatzems són diferents
  if (not bErr) and (aUbicacion.CodigoAlmacen <> aUbicacionExpedicion.CodigoAlmacen) then begin

    gaLogFile.Write ( 'Movimiento de traspaso en Sage, IdProcesoIME = ' + gaMov.IdProcesoIME, sIDCall  );

    // Inserir línia a TmpIME_MovimientoStock
    sSQL := 'INSERT INTO ' +
            '  TmpIME_MovimientoStock ( CodigoEmpresa, EmpresaOrigen, Ejercicio, Periodo, Fecha, FechaRegistro, Serie, '+
            '  CodigoArticulo, CodigoAlmacen, AlmacenContrapartida, Partida, Partida2_, TipoMovimiento, Unidades, ' +
            '  UnidadMedida1_, Unidades2_, UnidadMedida2_, FactorConversion_, Comentario, Ubicacion, ' +
            '  idProcesoIME, MovOrigen, FechaCaduca, OrigenMovimiento ) '+
            'VALUES (' +
            IntToStr(gaMov.CodigoEmpresa) + ', ' +
            IntToStr(gaMov.EmpresaOrigen) + ', ' +
            IntToStr(gaMov.Ejercicio) + ', ' +
            IntToStr(gaMov.Periodo) + ', ' +
            SQL_DateTimeToStr(gaMov.Fecha) + ', ' +
            SQL_DateTimeToStr(gaMov.FechaHora) + ', ' +
            '''' + SQL_Str(gaMov.Serie) + ''', ' +
            '''' + SQL_Str(gaMov.CodigoArticulo) + ''', ' +
            '''' + SQL_Str(gaMov.CodigoAlmacenDestino) + ''', ' +
            '''' + SQL_Str(gaMov.CodigoAlmacen) + ''', ' +
            '''' + SQL_Str(gaMov.Partida) + ''', ' +
            '''' + SQL_Str(gaMov.Partida) + ''', ' +
            '2, ' +
            SQL_FloatToStr(gaMov.Unidades) + ', ' +
            '''' + SQL_Str(gaMov.UnidadMedida) + ''', ' +
            SQL_FloatToStr(gaMov.UnidadesBase) + ', ' +
            '''' + SQL_Str(gaMov.UnidadMedidaBase) + ''', ' +
            SQL_FloatToStr(gaMov.FactorConversion) + ', ' +
            '''' + SQL_Str(gaMov.Comentario) + ''', ' +
            ''''', ' +
            '''' + SQL_Str(gaMov.IdProcesoIME) + ''',' +
            '''' + SQL_Str(gaMov.MovOrigen) + ''', ' +
            SQL_DateToStr(gaMov.FechaCaduca) + ', ' +
            '''T'')';

    if not bErr then try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on e: exception do begin
        bErr := bErr or true;
        sMsg := e.Message;
      end;
    end;

    sOperparams := '{"IdProcesoIME":"' + gaMov.IdProcesoIME + '","MantenerDatos":"1","MantenerErrores":"1","Módulos":"4","CodigoEmpresa":"' + IntToStr(EmpresaOrigen) + '"}';
    sSQL := 'INSERT INTO ' +
            '  FS_Operations ( oper_CodigoEmpresa, oper_name, oper_product_code, oper_mac_address, oper_ip_address, ' +
            '  oper_datetime, oper_status, oper_params ) ' +
            'VALUES ( ' +
            IntToStr(EmpresaOrigen) + ', ' +
            '''MOVIMIENTOSTOCK'', ' +
            '''E4E8'',' +
            '''' + SQL_Str(NETWORK_LocalMAC()) + ''', ' +
            '''' + SQL_Str(GetLocalIp()) + ''', ' +
            SQL_DateTimeToStr(Now()) + ', ' +
            '0, ' +
            '''' + SQL_Str(sOperparams) + ''' )';

    if not bErr then try
      SQL_Execute_NoRes ( Conn, sSQL );
    except
      on e: exception do begin
        bErr := true;
        sMsg := e.Message;
      end;
    end;

  end;

  sSQL := 'UPDATE ' +
          '  FS_SGA_Picking_Pedido_Lineas ' +
          'SET ' +
          '  UdRetiradas = UdRetiradas + ' + SQL_FloatToStr(Unidades) + ' ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  CodigoArticulo=''' + SQL_Str(CodigoArticulo) + ''' AND ' +
          '  Partida=''' + SQL_Str(PartidaPedido) + ''' AND ' +
          '  UnidadMedida = ''' + SQL_Str(UnidadMedida) + ''' ';

  if not bErr then try
    gaLogFile.Write ( 'Actualizar unidades retiradas', sIDCall  );
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if (not bErr) and (bRecalcularRuta) then begin

    gaLogFile.Write ( 'Recalculamos ruta', sIDCall );

    sSQL := 'SELECT ' +
            '  SUM(UdNecesarias) AS Necesarias, MIN(UdRetiradas) AS Retiradas ' +
            'FROM ' +
            '  FS_SGA_Picking_Pedido_Lineas WITH (NOLOCK) ' +
            'WHERE ' +
            '  PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
            '  CodigoArticulo=''' + SQL_Str(CodigoArticulo) + ''' AND ' +
            '  Partida=''' + SQL_Str(PartidaPedido) + ''' AND ' +
            '  UnidadMedida = ''' + SQL_Str(UnidadMedida) + ''' ';
    Q := SQL_PrepareQuery ( Conn, sSQL );

    if not bErr then try
      Q.Open;
    except
      on E:Exception do begin
        bErr := TRUE;
        sMsg := E.Message;
      end;
    end;

    if (not bErr) and (not Q.EOF) then begin
      iUnidadesNecesarias := Q.FieldByName('Necesarias').AsFloat;
      iUnidadesRetiradas := Q.FieldByName('Retiradas').AsFloat;
      gaLogFile.Write ( 'Unidades necesarias = ' + FloatToStr(iUnidadesNecesarias) + ', Unidades retiradas = ' + FloatToStr(iUnidadesRetiradas), sIDCall  );
    end else begin
      iUnidadesNecesarias := 0;
      iUnidadesRetiradas := 0;
    end;

    if iUnidadesNecesarias<=iUnidadesRetiradas then begin
      gaLogFile.Write ( 'Recalcular ruta = false', sIDCall  );
      bRecalcularRuta := FALSE;
    end;

    Q.Close;
    FreeAndNil(Q);

  end;

  if (not bErr) and (bRecalcularRuta) then try
    gaLogFile.Write ( 'Recalcular ruta', sIDCall  );
    bErr := not SGA_Check_PreparacionOrdenada ( gsPath, Conn, EmpresaOrigen, YY, IdPreparacion, aUbicacion.CodigoAlmacen, CodigoUbicacionExpedicion, sMsg, TRUE, bIsBuilding );
    gaLogFile.Write ( 'Recalcular ruta OK', sIDCall  );
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  sSQL := 'DELETE FROM ' +
          '  FS_SGA_Picking_Pedido_Lineas_Detalle ' +
          'WHERE ' +
          '  PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  Unidades=0';
  if not bErr then try
    gaLogFile.Write ( 'Purgar líneas completadas', sIDCall  );
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if bErr then begin
    gaLogFile.Write ( 'ERROR: ' + sMsg, sIDCall  );
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + JSON_Str(sMsg) + '","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"OK","Message":"","Data":[]}';
  Response.Content := Result;
  (*
  Request.QueryFields.AddPair('CodigoAlmacen', aUbicacion.CodigoAlmacen );
  Request.ContentFields.AddPair('CodigoAlmacen', aUbicacion.CodigoAlmacen );
  Request.QueryFields.AddPair('Partida', Partida );
  Request.ContentFields.AddPair('Partida', Partida );
  WebModule1preparacionUbicacionesAction ( Sender, Request, Response, Handled );
  *)

end;


procedure WebModule1updateDevolucionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  DevolucionId: Integer;
  DevolucionIdLinea: Integer;
  Result: String;
  sSQL: String;
  Data: String;
  Desglose: String;
  lJSonValue: TJSonValue;
  AutoId: Integer;
  Caja: string;
  Palet: string;
  Unidades: Double;
  bErr: Boolean;
  sMsg: string;
  Partida: string;
  CodigoAlmacen: String;
  CodigoUbicacion: String;
  CodigoAlmacenRechazos: String;
  CodigoUbicacionRechazos: String;
  FechaCaducidad: String;
  dFechaCaducidad: TDate;
  Verificacion: String;
  AnomaliaId: Integer;
  UnidadMedida1_: String;
  UnidadesEntrada: Double;
  CantidadErrorEntrada: Double;
  CantidadError: Double;
  TotalEntrada: Double;
  Total: Double;
  JSonPair: TJSONPair;
  YY, MM, DD: WORD;
  EmpresaOrigen: Integer;
  sIDCall: String;
  JSonObject: TJSONObject;
  JSonValue: TJSONValue;
  JSonArray: TJSONArray;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1updateDevolucionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  DevolucionId := StrToIntDef(request.contentfields.values['DevolucionId'],0);
  if DevolucionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de devolución no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  DevolucionIdLinea := StrToIntDef(request.contentfields.values['DevolucionIdLinea'],0);
  if DevolucionIdLinea=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de línea de devolución no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if DevolucionIdLinea=-1 then begin

    CodigoUbicacion := Trim(request.contentfields.values['CodigoUbicacion']);

    // Conversió al codi d'article real
    CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

    if CodigoUbicacion='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    CodigoUbicacionRechazos := Trim(request.contentfields.values['CodigoUbicacionRechazos']);
    if CodigoUbicacionRechazos='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación de rechazos no especificado","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacion );
    if CodigoAlmacen='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación incorrecto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    CodigoAlmacenRechazos := FS_SGA_CodigoAlmacen ( CodigoUbicacionRechazos );
    if CodigoAlmacen='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación de rechazos incorrecto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    Verificacion := AnsiUpperCase(Trim(request.contentfields.values['Verificacion']));
    if Verificacion='' then
      Verificacion := 'PENDIENTE';

    if (Verificacion<>'PENDIENTE') and (Verificacion<>'CORRECTA') and (Verificacion<>'INCIDENCIA') then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El tipo de verificación no es correcto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

  end;

  Data := (request.contentfields.values['Data']);
  if Data='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se han especificado los datos","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  JSonObject := _Parse_JSonObject ( Data );
  if JSonObject=nil then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El parámetro Data no es correcto","Data":[]}';
    JSonObject.Free;
    Response.Content := Result;
    Exit;
  end;

  JSonPair := JSonObject.Get('Desglose');
  if JSonPair=nil then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El parámetro Data no incluye el desglose","Data":[]}';
    JSonObject.Free;
    Response.Content := Result;
    Exit;
  end;

  JSonValue := JSonPair.JsonValue;
  if JSonValue=nil then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Los datos especificados no son válidos","Data":[]}';
    JSonObject.Free;
    Response.Content := Result;
    Exit;
  end;

  JSonArray := TJSONArray(JSonValue);

  {$ENDREGION}

  {$REGION 'Guardar les dades'}

  sMsg := '';
  bErr := FALSE;

  try
    // Conn.BeginTrans;
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if DevolucionIdLinea<>-1 then begin

    sSQL := 'DELETE FROM ' +
            '  FS_SGA_Devoluciones_Lineas_Detalle ' +
            'WHERE ' +
            '  DevolucionId = ' + IntToStr(DevolucionId) + ' AND ' +
            '  DevolucionIdLinea = ' + IntToStr(DevolucionIdLinea);
  end else begin

    sSQL := 'INSERT INTO ' +
            '  FS_SGA_Devoluciones_Lineas_Detalle ( DevolucionId, DevolucionIdLinea, CodigoAlmacen, ' +
            '  CodigoUbicacion, CodigoAlmacenRechazos, CodigoUbicacionRechazos, Caja, Palet, Partida, ' +
            '  FechaCaducidad, Verificacion, Precio, UnidadMedida1_, UnidadesEntrada, Unidades, ' +
            '  CantidadErrorEntrada, CantidadError, TotalEntrada, Total ) ' +
            'SELECT ' +
            '  DevolucionId, DevolucionIdLinea, ' +
            '''' + SQL_Str(CodigoAlmacen) + ''', ' +
            '''' + SQL_Str(CodigoUbicacion) + ''', ' +
            '''' + SQL_Str(CodigoAlmacenRechazos) + ''', ' +
            '''' + SQL_Str(CodigoUbicacionRechazos) + ''', ' +
            ''''', ' +
            ''''', Partida, NULL, ' +
            '''' + SQL_Str(Verificacion) + ''', Precio, UnidadMedida1_, ' +
            'UdPedidas - UdRecibidas, UdPedidas - UdRecibidas, 0, '+
            '0, UdPedidas - UdRecibidas, UdPedidas - UdRecibidas ' +
            'FROM ' +
            '  FS_SGA_Devoluciones_Lineas WITH (NOLOCK) ' +
            'WHERE ' +
            '  UdPedidas > UdRecibidas AND ' +
            '  DevolucionId = ' + IntToStr(DevolucionId);

  end;

  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if (DevolucionIdLinea<>-1) and (not bErr) then begin

    for lJSonValue in JSonArray do begin

      CodigoUbicacion         := Trim(_Get_JSonValue ( lJSonValue, 'CodigoUbicacion' ));

      // Conversió al codi d'article real
      CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

      CodigoAlmacen           := FS_SGA_CodigoAlmacen ( CodigoUbicacion );
      CodigoUbicacionRechazos := Trim(_Get_JSonValue ( lJSonValue, 'CodigoUbicacionRechazos' ));
      CodigoAlmacenRechazos   := FS_SGA_CodigoAlmacen ( CodigoUbicacionRechazos );
      Caja                    := Trim(_Get_JSonValue ( lJSonValue, 'Caja' ));
      Palet                   := Trim(_Get_JSonValue ( lJSonValue, 'Palet' ));
      Partida                 := Trim(_Get_JSonValue ( lJSonValue, 'Partida' ));
      FechaCaducidad          := Trim(_Get_JSonValue ( lJSonValue, 'FechaCaducidad' ));
      Verificacion            := AnsiUpperCase(Trim(_Get_JSonValue ( lJSonValue, 'Verificacion' )));
      AnomaliaId              := StrToIntDef(_Get_JSonValue ( lJSonValue, 'AnomaliaId' ),0);
      UnidadMedida1_          := Trim(_Get_JSonValue ( lJSonValue, 'UnidadMedida' ));
      UnidadesEntrada         := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'UnidadesEntrada' ),'.',',',[]),0);
      Unidades                := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'Unidades' ),'.',',',[]),0);
      CantidadErrorEntrada    := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'CantidadErrorEntrada' ),'.',',',[]),0);
      CantidadError           := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'CantidadError' ),'.',',',[]),0);
      TotalEntrada            := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'TotalEntrada' ),'.',',',[]),0);
      Total                   := UnidadesEntrada + CantidadErrorEntrada;

      if FechaCaducidad='' then begin
        dFechaCaducidad := 0;
      end else begin
        YY := StrToInt ( Copy ( FechaCaducidad, 7, 4 ) );
        MM := StrToInt ( Copy ( FechaCaducidad, 4, 2 ) );
        DD := StrToInt ( Copy ( FechaCaducidad, 1, 2 ) );
        dFechaCaducidad := EncodeDate ( YY, MM, DD );
      end;

      sSQL := 'INSERT INTO FS_SGA_Devoluciones_Lineas_Detalle ( ' +
              '  DevolucionId, DevolucionIdLinea, CodigoAlmacen, CodigoUbicacion, CodigoAlmacenRechazos, ' +
              '  CodigoUbicacionRechazos, Caja, Palet, Partida, FechaCaducidad, Verificacion, ' +
              '  AnomaliaId, UnidadMedida1_, UnidadesEntrada, Unidades, CantidadErrorEntrada, ' +
              '  CantidadError, TotalEntrada, Total ) ' +
              'VALUES ( ' +
              IntToStr(DevolucionId) + ', ' +
              IntToStr(DevolucionIdLinea) + ', ' +
              '''' + SQL_Str(CodigoAlmacen) + ''', ' +
              '''' + SQL_Str(CodigoUbicacion) + ''', ' +
              '''' + SQL_Str(CodigoAlmacenRechazos) + ''', ' +
              '''' + SQL_Str(CodigoUbicacionRechazos) + ''', ' +
              '''' + SQL_Str(Caja) + ''', ' +
              '''' + SQL_Str(Palet) + ''', ' +
              '''' + SQL_Str(Partida) + ''', ' +
              SQL_DateToStr(dFechaCaducidad) + ', ' +
              '''' + SQL_Str(Verificacion) + ''', ' +
              IntToStr(AnomaliaId) + ', ' +
              '''' + SQL_Str(UnidadMedida1_) + ''', ' +
              SQL_FloatToStr(UnidadesEntrada) + ', ' +
              SQL_FloatToStr(Unidades) + ', ' +
              SQL_FloatToStr(CantidadErrorEntrada) + ', ' +
              SQL_FloatToStr(CantidadError) + ', ' +
              SQL_FloatToStr(Total) + ', ' +
              SQL_FloatToStr(Total) + ')';

      if not bErr then try
        SQL_Execute_NoRes ( Conn, sSQL );
      except
        on E:Exception do begin
          bErr := TRUE;
          sMsg := E.Message;
        end;
      end;

    end;

  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  JSonObject.Free;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + JSON_Str(sMsg) + '"}';
  end else begin
    Result := '{"Result":"OK","Error":""}';
  end;

  {$ENDREGION}

  Response.Content := Result;


end;

procedure WebModule1updateInventarioUbicacionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q, Q2: TADOQuery;
  EmpresaOrigen: Integer;
  InventarioId: Integer;
  sFechaCaduca: String;
  CodigoUbicacion: String;
  CodigoAlmacen: String;
  CodigoPasillo: String;
  CodigoEstanteria: String;
  Altura: String;
  Fondo: String;
  TipoUbicacion: String;
  Data, Articulos: String;
  Desglose: String;
  lJSonValue: TJSonValue;
  sMsg: String;
  bErr: Boolean;
  CodigoArticulo: String;
  Partida: String;
  UnidadMedida: String;
  UnidadesSaldo: Double;
  dFechaCaduca: TDate;
  FechaCaduca: String;
  CodigoUsuario: Integer;
  bAdded: Boolean;
  TipoUbicaciones: String;
  iNum: Integer;
  sIDCall: String;
  JSonObject: TJSONObject;
  JSonValue: TJSONValue;
  JSonArray: TJSONArray;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1updateInventarioUbicacionAction: ' + Request.RemoteAddr , sIDCall );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  InventarioId := StrToIntDef(request.contentfields.Values['InventarioId'], 0 );
  if InventarioId=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de inventario no especificado","Data":[]}';
    Exit;
  end;

  sSQL := 'SELECT ' +
          '  Inventario_TipoUbicaciones ' +
          'FROM ' +
          '  FS_SGA_Inventario WITH (NOLOCK) ' +
          'WHERE ' +
          '  Inventario_Id = ' + IntToStr(InventarioId);
  TipoUbicaciones := SQL_Execute ( Conn, sSQL );

  // Tipus d'ubicació (TODAS,PENDIENTES,VERIFICADAS)
  CodigoUbicacion := trim(request.contentfields.Values['CodigoUbicacion']);

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de ubicación no especificado","Data":[]}';
    Exit;
  end;

  // Verifiquem que la ubicació pertany a l'inventari
  if TipoUbicaciones<>'LIBRE' then begin

    sSQL := 'SELECT ' +
            '  COUNT(*) ' +
            'FROM ' +
            '  FS_SGA_Inventario_Detalle WITH (NOLOCK) ' +
            'WHERE ' +
            '  Inventario_Id = ' + IntToStr(InventarioId) + ' AND ' +
            '  CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + ''' ';
    iNum := SQL_Execute ( Conn, sSQL );
    if iNum=0 then begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La ubicación no está incluida en este inventario","Data":[]}';
      Exit;
    end;

  end;

  // Verifiquem que la ubicació pertany al magatzem
  FS_SGA_UBICACION_Desglosar ( CodigoUbicacion, CodigoAlmacen, CodigoPasillo, CodigoEstanteria, Altura, Fondo );
  sSQL := 'SELECT ' +
          '  Inventario_CodigoAlmacen ' +
          'FROM ' +
          '  FS_SGA_Inventario WITH (NOLOCK) ' +
          'WHERE ' +
          '  Inventario_Id = ' + IntToStr(InventarioId);
  if CodigoAlmacen<>SQL_Execute(Conn,sSQL) then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"La ubicación del almacén no está incluida en este inventario","Data":[]}';
    Exit;
  end;

  Data := (request.contentfields.values['Data']);
  if Data='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se han especificado los datos","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  try
    JSonObject := _Parse_JSonObject ( Data );
    JSonValue  := JSonObject.Get('Articulos').JsonValue;
  except
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Los datos especificados no son válidos","Data":[]}';
    JSonObject.Free;
    Response.Content := Result;
    Exit;
  end;

  if JSonValue=nil then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Los datos especificados no son válidos","Data":[]}';
    JSonObject.Free;
    Response.Content := Result;
    Exit;
  end;

  JSonArray := TJSONArray(JSonValue);

  {$ENDREGION}

  {$REGION 'Guardar les dades'}

  sMsg := '';
  bErr := FALSE;

  try
    // Conn.BeginTrans;
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  bAdded := FALSE;

  sSQL := 'DELETE FROM ' +
          '  FS_SGA_Inventario_Detalle ' +
          'WHERE ' +
          '  Inventario_Id = ' + IntToStr(InventarioId) + ' AND ' +
          '  CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + '''';
  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if not bErr then begin

    for lJSonValue in JSonArray do begin

      CodigoArticulo := Trim (_Get_JSonValue ( lJSonValue, 'CodigoArticulo' ) );
      Partida        := Trim (_Get_JSonValue ( lJSonValue, 'Partida' ) );
      UnidadMedida   := Trim (_Get_JSonValue ( lJSonValue, 'UnidadMedida' ) );
      UnidadesSaldo  := StrToFloatDef (_Get_JSonValue ( lJSonValue, 'UnidadesSaldo' ), 0 );
      sFechaCaduca   := _Get_JSonValue ( lJSonValue, 'FechaCaduca' );
      dFechaCaduca   := StrToDateDef ( Trim ( sFechaCaduca ), 0 );

      // Conversió al codi d'article real
      CodigoArticulo := ARTICULO_CodigoFromAlternativo ( Conn, CodigoEmpresa, CodigoArticulo );

      if dFechaCaduca<>0 then begin
        FechaCaduca := SQL_DateToStr ( dFechaCaduca );
      end else begin
        FechaCaduca := 'NULL';
      end;

      if UnidadesSaldo>0 then begin

        bAdded := TRUE;

        sSQL := 'INSERT INTO FS_SGA_Inventario_Detalle ( ' +
                '  CodigoEmpresa, Inventario_Id, CodigoUbicacion, CodigoArticulo, ' +
                '  Partida, UnidadMedida, UnidadesSaldo, FechaCaduca, Verificada, UsuarioId, ' +
                '  FechaHoraValidacion ) ' +
                'VALUES ( ' +
                IntToStr(CodigoEmpresa) + ', ' +
                IntToStr(InventarioId) + ', ' +
                '''' + SQL_Str(CodigoUbicacion) + ''', ' +
                '''' + SQL_Str(CodigoArticulo) + ''', ' +
                '''' + SQL_Str(Partida) + ''', ' +
                '''' + SQL_Str(UnidadMedida) + ''', ' +
                SQL_FloatToStr(UnidadesSaldo) + ', ' +
                FechaCaduca + ', ' +
                '1, ' +
                IntToStr(CodigoUsuario) + ', ' +
                SQL_DateTimeToStr(Now()) + ' )';
        if not bErr then try
          SQL_Execute_NoRes ( Conn, sSQL );
        except
          on E:Exception do begin
            bErr := TRUE;
            sMsg := E.Message;
          end;
        end;

      end;

    end;

    if not bAdded then begin

      sSQL := 'INSERT INTO FS_SGA_Inventario_Detalle ( ' +
                '  CodigoEmpresa, Inventario_Id, CodigoUbicacion, CodigoArticulo, ' +
                '  Partida, UnidadMedida, UnidadesSaldo, FechaCaduca, Verificada, UsuarioId, ' +
                '  FechaHoraValidacion ) ' +
                'VALUES ( ' +
                IntToStr(CodigoEmpresa) + ', ' +
                IntToStr(InventarioId) + ', ' +
                '''' + SQL_Str(CodigoUbicacion) + ''', ' +
                ''''', ' +
                ''''', ' +
                ''''', ' +
                '0, ' +
                'NULL, ' +
                '1, ' +
                IntToStr(CodigoUsuario) + ', ' +
                SQL_DateTimeToStr(Now()) + ' )';
        if not bErr then try
          SQL_Execute_NoRes ( Conn, sSQL );
        except
          on E:Exception do begin
            bErr := TRUE;
            sMsg := E.Message;
          end;
        end;

    end;

  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + JSON_Str(sMsg) + '"}';
  end else begin
    Result := '{"Result":"OK","Error":""}';
  end;

  {$ENDREGION}

  JSonObject.Free;

  Response.Content := Result;

end;

procedure WebModule1updateRecepcionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  RecepcionId: Integer;
  RecepcionIdLinea: Integer;
  Result: String;
  sSQL: String;
  Data: String;
  Desglose: String;
  AutoId: Integer;
  Caja: string;
  Palet: string;
  Unidades: Double;
  bErr: Boolean;
  sMsg: string;
  Partida: string;
  CodigoAlmacen: String;
  CodigoUbicacion: String;
  CodigoAlmacenRechazos: String;
  CodigoUbicacionRechazos: String;
  FechaCaducidad: String;
  dFechaCaducidad: TDate;
  Verificacion: String;
  AnomaliaId: Integer;
  UnidadMedida1_: String;
  UnidadesEntrada: Double;
  CantidadErrorEntrada: Double;
  CantidadError: Double;
  TotalEntrada: Double;
  Total: Double;
  JSonPair: TJSONPair;
  YY, MM, DD: WORD;
  EmpresaOrigen: Integer;
  sIDCall: String;
  JSonObject: TJSONObject;
  JSonValue: TJSONValue;
  JSonArray: TJSONArray;
  lJSonValue: TJSonValue;
  Precio: Double;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1updateRecepcionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  RecepcionId := StrToIntDef(request.contentfields.values['IdRecepcion'],0);
  if RecepcionId=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de recepción no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  RecepcionIdLinea := StrToIntDef(request.contentfields.values['RecepcionIdLinea'],0);
  if RecepcionIdLinea=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Identificador de línea de recepción no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  if RecepcionIdLinea=-1 then begin

    CodigoUbicacion := Trim(request.contentfields.values['CodigoUbicacion']);

    // Conversió al codi d'article real
    CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

    if CodigoUbicacion='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación no especificado","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    CodigoUbicacionRechazos := Trim(request.contentfields.values['CodigoUbicacionRechazos']);
    if CodigoUbicacionRechazos='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación de rechazos no especificado","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacion );
    if CodigoAlmacen='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación incorrecto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    CodigoAlmacenRechazos   := FS_SGA_CodigoAlmacen ( CodigoUbicacionRechazos );
    if CodigoAlmacen='' then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de ubicación de rechazos incorrecto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

    Verificacion := AnsiUpperCase(Trim(request.contentfields.values['Verificacion']));
    if Verificacion='' then
      Verificacion := 'PENDIENTE';

    if (Verificacion<>'PENDIENTE') and (Verificacion<>'CORRECTA') and (Verificacion<>'INCIDENCIA') then begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"El tipo de verificación no es correcto","Data":[]}';
      Response.Content := Result;
      Exit;
    end;

  end;


  Data := (request.contentfields.values['Data']);
  if Data='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se han especificado los datos","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  JSonObject := _Parse_JSonObject ( Data );
  JSonValue  := JSonObject.Get('Desglose').JsonValue;

  if JSonValue=nil then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Los datos especificados no son válidos","Data":[]}';
    JSonObject.Free;
    Response.Content := Result;
    Exit;
  end;

  JSonArray := TJSONArray(JSonValue);

  {$ENDREGION}

  {$REGION 'Guardar les dades'}

  sMsg := '';
  bErr := FALSE;

  try
    // Conn.BeginTrans;
  except
    on E:Exception do begin
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if RecepcionIdLinea<>-1 then begin

    sSQL := 'DELETE FROM ' +
            '  FS_SGA_Recepciones_Lineas_Detalle ' +
            'WHERE ' +
            '  RecepcionId = ' + IntToStr(RecepcionId) + ' AND ' +
            '  RecepcionIdLinea = ' + IntToStr(RecepcionIdLinea);
  end else begin

    sSQL := 'INSERT INTO ' +
            '  FS_SGA_Recepciones_Lineas_Detalle ( RecepcionId, RecepcionIdLinea, CodigoAlmacen, ' +
            '  CodigoUbicacion, CodigoAlmacenRechazos, CodigoUbicacionRechazos, Caja, Palet, Partida, ' +
            '  FechaCaducidad, Verificacion, Precio, UnidadMedida1_, UnidadesEntrada, Unidades, ' +
            '  CantidadErrorEntrada, CantidadError, TotalEntrada, Total ) ' +
            'SELECT ' +
            '  RecepcionId, RecepcionIdLinea, ' +
            '''' + SQL_Str(CodigoAlmacen) + ''', ' +
            '''' + SQL_Str(CodigoUbicacion) + ''', ' +
            '''' + SQL_Str(CodigoAlmacenRechazos) + ''', ' +
            '''' + SQL_Str(CodigoUbicacionRechazos) + ''', ' +
            ''''', ' +
            ''''', Partida, NULL, ' +
            '''' + SQL_Str(Verificacion) + ''', Precio, UnidadMedida1_, ' +
            'UdPedidas - UdRecibidas, UdPedidas - UdRecibidas, 0, '+
            '0, UdPedidas - UdRecibidas, UdPedidas - UdRecibidas ' +
            'FROM ' +
            '  FS_SGA_Recepciones_Lineas WITH (NOLOCK) ' +
            'WHERE ' +
            '  UdPedidas > UdRecibidas AND ' +
            '  RecepcionId = ' + IntToStr(RecepcionId);

  end;


  if not bErr then try
    SQL_Execute_NoRes ( Conn, sSQL );
  except
    on E:Exception do begin
      bErr := TRUE;
      sMsg := E.Message;
    end;
  end;

  if (RecepcionIdLinea<>-1) and (not bErr) then begin

    for lJSonValue in JSonArray do begin

      CodigoUbicacion         := Trim(_Get_JSonValue ( lJSonValue, 'CodigoUbicacion' ));

      // Conversió al codi d'article real
      CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

      CodigoAlmacen           := FS_SGA_CodigoAlmacen ( CodigoUbicacion );
      CodigoUbicacionRechazos := Trim(_Get_JSonValue ( lJSonValue, 'CodigoUbicacionRechazos' ));
      CodigoAlmacenRechazos   := FS_SGA_CodigoAlmacen ( CodigoUbicacionRechazos );
      Caja                    := Trim(_Get_JSonValue ( lJSonValue, 'Caja' ));
      Palet                   := Trim(_Get_JSonValue ( lJSonValue, 'Palet' ));
      Partida                 := Trim(_Get_JSonValue ( lJSonValue, 'Partida' ));
      FechaCaducidad          := Trim(_Get_JSonValue ( lJSonValue, 'FechaCaducidad' ));
      Verificacion            := AnsiUpperCase(Trim(_Get_JSonValue ( lJSonValue, 'Verificacion' )));
      AnomaliaId              := StrToIntDef(_Get_JSonValue ( lJSonValue, 'AnomaliaId' ),0);
      UnidadMedida1_          := Trim(_Get_JSonValue ( lJSonValue, 'UnidadMedida' ));
      UnidadesEntrada         := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'UnidadesEntrada' ),'.',',',[]),0);
      Unidades                := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'Unidades' ),'.',',',[]),0);
      CantidadErrorEntrada    := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'CantidadErrorEntrada' ),'.',',',[]),0);
      CantidadError           := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'CantidadError' ),'.',',',[]),0);
      TotalEntrada            := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'TotalEntrada' ),'.',',',[]),0);
      Total                   := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'Total' ),'.',',',[]),0);
      Total                   := UnidadesEntrada + CantidadErrorEntrada;
      Precio                  := StrToFloatDef(StringReplace(_Get_JSonValue ( lJSonValue, 'Precio' ),'.',',',[]),0);

      if FechaCaducidad='' then begin
        dFechaCaducidad := 0;
      end else begin
        YY := StrToInt ( Copy ( FechaCaducidad, 7, 4 ) );
        MM := StrToInt ( Copy ( FechaCaducidad, 4, 2 ) );
        DD := StrToInt ( Copy ( FechaCaducidad, 1, 2 ) );
        dFechaCaducidad := EncodeDate ( YY, MM, DD );
      end;

      sSQL := 'INSERT INTO FS_SGA_Recepciones_Lineas_Detalle ( ' +
              '  RecepcionId, RecepcionIdLinea, CodigoAlmacen, CodigoUbicacion, CodigoAlmacenRechazos, ' +
              '  CodigoUbicacionRechazos, Caja, Palet, Partida, FechaCaducidad, Verificacion, ' +
              '  AnomaliaId, UnidadMedida1_, UnidadesEntrada, Unidades, CantidadErrorEntrada, ' +
              '  CantidadError, TotalEntrada, Total, Precio ) ' +
              'VALUES ( ' +
              IntToStr(RecepcionId) + ', ' +
              IntToStr(RecepcionIdLinea) + ', ' +
              '''' + SQL_Str(CodigoAlmacen) + ''', ' +
              '''' + SQL_Str(CodigoUbicacion) + ''', ' +
              '''' + SQL_Str(CodigoAlmacenRechazos) + ''', ' +
              '''' + SQL_Str(CodigoUbicacionRechazos) + ''', ' +
              '''' + SQL_Str(Caja) + ''', ' +
              '''' + SQL_Str(Palet) + ''', ' +
              '''' + SQL_Str(Partida) + ''', ' +
              SQL_DateToStr(dFechaCaducidad) + ', ' +
              '''' + SQL_Str(Verificacion) + ''', ' +
              IntToStr(AnomaliaId) + ', ' +
              '''' + SQL_Str(UnidadMedida1_) + ''', ' +
              SQL_FloatToStr(UnidadesEntrada) + ', ' +
              SQL_FloatToStr(Unidades) + ', ' +
              SQL_FloatToStr(CantidadErrorEntrada) + ', ' +
              SQL_FloatToStr(CantidadError) + ', ' +
              SQL_FloatToStr(Total) + ', ' +
              SQL_FloatToStr(Total) + ', ' +
              SQL_FloatToStr(Precio) + ')';

      if not bErr then try
        SQL_Execute_NoRes ( Conn, sSQL );
      except
        on E:Exception do begin
          bErr := TRUE;
          sMsg := E.Message;
        end;
      end;

    end;

  end;

  if not bErr then try
    // Conn.CommitTrans;
  except
    on E:Exception do begin
      // Conn.RollbackTrans;
      sMsg := E.Message;
      bErr := TRUE;
    end;
  end;

  if bErr then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"' + JSON_Str(sMsg) + '"}';
  end else begin
    Result := '{"Result":"OK","Error":""}';
  end;

  {$ENDREGION}

  JSonObject.Free;

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ RETORNA EL LLISTAT D'USUARIS                                          │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1userListAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1userListAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_Usuarios WITH (NOLOCK) ' +
          'WHERE ' +
          //'  CodigoEmpresa = 9999 AND ' +
          '  EsBaja = 0';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  u.*, r.RolNombre ' +
          'FROM ' +
          '  FS_SGA_Usuarios u WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  FS_SGA_Roles r WITH (NOLOCK) ' +
          'ON ' +
          '  u.RolId = r.RolID ' +
          'WHERE ' +
          //'  CodigoEmpresa = 9999 AND ' +
          '  EsBaja = 0 ' +
          'ORDER BY ' +
          '  NombreCompletoUsuario, NombreUsuario, CodigoUsuario ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoUsuario":"' + JSON_Str(Q.FieldByName('CodigoUsuario').AsString) + '",' +
      '"NombreUsuario":"' + JSON_Str(Q.FieldByName('NombreUsuario').AsString) + '",' +
      '"NombreCompletoUsuario":"' + JSON_Str(Q.FieldByName('NombreCompletoUsuario').AsString) + '",' +
      '"RolNombre":"' + JSON_Str(Q.FieldByName('RolNombre').AsString) + '"' +
      '}';

    Q.Next;
  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ VALIDA USUARI I PASSWORD                                              │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1validateUbicacionAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  Result: String;
  sSQL: String;
  CodigoUsuario: Integer;
  Q: TADOQuery;
  CodigoEmpresa: Integer;
  CodigoUbicacion: String;
  CodigoAlternativo: String;
  CodigoAlmacen: String;
  CodigoPasillo: String;
  CodigoEstanteria: String;
  Altura: String;
  Fondo: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1validateUbicacionAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUbicacion := Trim(request.contentfields.Values['CodigoUbicacion'] );

  // Conversió al codi d'article real
  CodigoUbicacion := FS_SGA_CodigoUbicacion_FromAlternativo ( Conn, CodigoEmpresa, CodigoUbicacion );

  if CodigoUbicacion='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado la ubicación","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  {$ENDREGION}

  {$REGION 'Validem la ubicació'}

  sSQL := 'SELECT TOP 1 ' +
          '  CodigoUbicacion, CodigoAlternativo ' +
          'FROM ' +
          '  FS_SGA_ESTR_UBICA WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(CodigoEmpresa) + ' AND ' +
          '  (CodigoUbicacion = ''' + SQL_Str(CodigoUbicacion) + ''' OR ' +
          '  CodigoAlternativo = ''' + SQL_Str(CodigoUbicacion) + ''' )';
  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  if not Q.EOF then begin
    CodigoUbicacion   := Q.FieldByName('CodigoUbicacion').AsString;
    CodigoAlternativo := Q.FieldByName('CodigoAlternativo').AsString;
  end else begin
    CodigoUbicacion := '';
  end;

  FS_SGA_UBICACION_Desglosar ( CodigoUbicacion,
    CodigoAlmacen, CodigoPasillo, CodigoEstanteria, Altura, Fondo );

  Q.Close;
  FreeAndNil(Q);

  if (CodigoUbicacion='') then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"Código de ubicación incorrecto"}';
  end else begin
    Result := '{"Result":"OK","Error":"","Data":[';
    Result := Result + '{' +
      '"Tipo":2,' +
      '"CodigoAlmacen":"' + JSON_Str(CodigoAlmacen) + '",' +
      '"CodigoPasillo":"' + JSON_Str(CodigoPasillo) + '",' +
      '"CodigoEstanteria":"' + JSON_Str(CodigoEstanteria) + '",' +
      '"Altura":"' + JSON_Str(Altura) + '",' +
      '"Fondo":"' + JSON_Str(Fondo) + '",' +
      '"CodigoUbicacion":"' + JSON_Str(CodigoUbicacion) + '",' +
      '"CodigoUbicacionAlternativo":"' + JSON_Str(CodigoAlternativo) + '"' +
      '}]}';
  end;

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1validateUserAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  Usuario: String;
  Password: String;
  Result: String;
  sSQL: String;
  CodigoUsuario: Integer;
  Q: TADOQuery;
  sPass: String;
  sPermissions: string;
  RoleId: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1validateUserAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  Usuario := Trim(request.contentfields.values['Usuario']);
  if Usuario='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado el nombre de usuario","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Password := Trim(request.contentfields.values['Password']);
  if Password='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"No se ha especificado la contraseña","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  {$ENDREGION}

  {$REGION 'Validem l´usuari'}

  sSQL := 'SELECT ' +
          '  CodigoUsuario, PasswordUsuario, RolId ' +
          'FROM ' +
          '  FS_SGA_Usuarios WITH (NOLOCK) ' +
          'WHERE ' +
          '  EsBaja = 0 AND ' +
          '  NombreUsuario = ''' + SQL_Str(Usuario) + ''' ';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
    end;
  end;

  if not Q.EOF then begin
    try
      sPass := LICENSE_TwoFish_DEC ( Q.FieldByName('PasswordUsuario').AsString );
    except
      on E:Exception do begin
        sPass := '';
        gaLogFile.Write ( E.Message );
      end;
    end;
    gaLogFile.Write ( 'Password descifrado correctamente', sIDCall );
    CodigoUsuario := Q.FieldByName('CodigoUsuario').AsInteger;
    RoleId := Q.FieldByName('RolId').AsInteger;
  end else begin
    gaLogFile.Write ( 'ERROR: Password no descifrado', sIDCall );
    sPass := '';
    CodigoUsuario := 0;
  end;

  Q.Close;
  FreeAndNil(Q);

  if (CodigoUsuario=0) or (sPass<>Password) then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Error":"Usuario incorrecto"}';
  end else begin

    sSQL := 'SELECT ' +
            '  fsfp.FormId, fsf.FormNombre, fsfp.Permiso ' +
            'FROM  ' +
            '  FS_SGA_Forms_Permisos fsfp WITH (NOLOCK) ' +
            'LEFT JOIN  ' +
            '  FS_SGA_Forms fsf WITH (NOLOCK) ' +
            'ON  ' +
            '  fsf.FormID = fsfp.FormId ' +
            'WHERE ' +
            '  fsfp.RolId = ' + IntToStr(RoleId) + ' AND ' +
            '  fsfp.Permiso<>0 ' +
            'ORDER BY ' +
            '  fsfp.FormId';
    Q := SQL_PrepareQuery ( Conn, sSQL );
    Q.Open;

    sPermissions := '';
    while not Q.EOF do begin

       if sPermissions<>'' then
         sPermissions := sPermissions + ',';

       sPermissions := sPermissions +
         '{' +
         '"FormId":' + Q.FieldByName('FormId').AsString + ',' +
         '"FormName":"' + JSON_Str(Q.FieldByName('FormNombre').AsString) + '",' +
         '"Perm":' + Q.FieldByName('Permiso').AsString +
         '}';

       Q.Next;

    end;

    Q.Close;
    FreeAndNil(Q);

    Result := '{"Result":"OK","Error":"","Data":[';
    Result := Result + '{' +
      '"CodigoUsuario":"' + IntToStr(CodigoUsuario) + '",' +
      '"Permisos":[' + sPermissions + ']' +
      '}]}';
  end;

  {$ENDREGION}

  Response.Content := Result;

end;


{$ENDREGION}


{$REGION '--- FUNCIONS DE COMANDES I ALBARANS DE CLIENT'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAR COMANDES DE CLIENTS                                           │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listPedidosVentaAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoCliente: String;
  sAndWhere: String;
  EjercicioPedido: Integer;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listPedidosVentaAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoCliente   := trim(request.contentfields.values['CodigoCliente']);
  EjercicioPedido := StrToIntDef(request.contentfields.Values['EjercicioPedido'], 0 );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='PEDIDO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioPedido DESC, SeriePedido DESC, NumeroPedido DESC ';
    end else begin
      sOrderBy := 'EjercicioPedido, SeriePedido, NumeroPedido ';
    end;
  end else if OrdenarPor='CLIENTE' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'RazonSocial DESC, EjercicioPedido, SeriePedido, NumeroPedido ';
    end else begin
      sOrderBy := 'RazonSocial, EjercicioPedido, SeriePedido, NumeroPedido ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioPedido DESC, SeriePedido DESC, NumeroPedido DESC ';
    end else begin
      sOrderBy := 'EjercicioPedido, SeriePedido, NumeroPedido ';
    end;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if CodigoCliente<>'' then begin
    sAndWhere := sAndWhere + 'AND CodigoCliente=''' + SQL_Str(CodigoCliente) + ''' ';
  end;

  if EjercicioPedido<>0 then begin
    sAndWhere := sAndWhere + 'AND EjercicioPedido=' + IntToStr(EjercicioPedido) + ' ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  CabeceraPedidoCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  FechaPedido >= DATEADD(day,-30,GETDATE()) AND ' +
          '  Estado<>2 ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  CabeceraPedidoCliente WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  FechaPedido >= DATEADD(day,-30,GETDATE()) AND ' +
          '  Estado <> 2 ' +
          sAndWhere + ' ' +
          'ORDER BY ' +
          sOrderBy + ' ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
      '"SeriePedido":"' + Q.FieldByName('SeriePedido').AsString + '",' +
      '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
      '"SuPedido":"' + Q.FieldByName('SuPedido').AsString + '",' +
      '"FechaPedido":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaPedido').AsDateTime ) + '",' +
      '"FechaEntrega":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaEntrega').AsDateTime ) + '",' +
      '"FechaTope":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaTope').AsDateTime ) + '",' +
      '"FechaNecesaria":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaNecesaria').AsDateTime ) + '",' +
      '"NumeroLineas":' + Q.FieldByName('NumeroLineas').AsString + ',' +
      '"PesoBruto":' + SQL_FloatToStr(Q.FieldByName('PesoBruto_').AsFloat) + ',' +
      '"PesoNeto":' + SQL_FloatToStr(Q.FieldByName('PesoNeto_').AsFloat) + ',' +
      '"Volumen":' + SQL_FloatToStr(Q.FieldByName('Volumen_').AsFloat) + ',' +
      '"CodigoCliente":"' + JSON_Str(Q.FieldByName('CodigoCliente').AsString) + '",' +
      '"Nombre":"' + JSON_Str(Q.FieldByName('Nombre').AsString) + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '",' +
      '"Nacion":"' + JSON_Str(Q.FieldByName('Nacion').AsString) + '",' +
      '"Estado":' + Q.FieldByName('Estado').AsString + '' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAR PROVEÏDORS D'UNA EMPRESA                                      │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listPreparacionesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Tipo: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  Filter: String;
  sAndWhere: String;
  sSort: String;
  sSortType: String;
  EmpresaOrigen: Integer;
  PreparacionId: Integer;
  sIDCall: String;
  CodigoUsuario: Integer;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listPreparacionesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );

  Tipo := StrToIntDef(request.contentfields.values['Tipo'],-1);
  PreparacionId := StrToIntDef(request.contentfields.values['PreparacionId'],0);

  sSort := AnsiLowerCase(trim(request.contentfields.Values['OrdenarPor']));
  sSortType := AnsiLowerCase(trim(request.contentfields.Values['TipoOrden']));

  if (sSort='fecha') then
    sSort := ' p.Fecha '
  else if (sSort='cliente') then
    sSort := ' p.CodigoCliente '
  else if (sSort='lineas') then
    sSort := ' 1 '
  else if (sSort='progreso') then
    sSort := ' 1.0 - ( CAST ( ( SELECT COUNT(*) FROM FS_SGA_Picking_Pedido_Lineas pl WITH (NOLOCK) ' +
             ' WHERE p.CodigoEmpresa = pl.CodigoEmpresa AND p.PreparacionId = pl.PreparacionId AND ' +
             ' pl.UdSaldo<>0 ) AS float ) / NULLIF ( cast ( ( SELECT COUNT(*) ' +
             ' FROM FS_SGA_Picking_Pedido_Lineas pl WITH (NOLOCK) WHERE p.CodigoEmpresa = pl.CodigoEmpresa AND ' +
             ' p.PreparacionId = pl.PreparacionId ' +
             ' ) as float),0 ) ) '
  else
    sSort := ' p.PreparacionId ';

  if sSortType='desc' then
    sSort := sSort + ' DESC ';

  if (Pos('preparacionid', ansilowercase(sSort))<=0) then
    sSort := sSort + ', p.PreparacionId ';

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if PreparacionId<>0 then begin
    sAndWhere := sAndWhere + 'AND p.PreparacionId = ' + IntToStr(PreparacionId) + ' ';
  end;

  if Tipo<>-1 then begin
    sAndWhere := sAndWhere + 'AND p.Estado = ' + IntToStr(Tipo) + ' ';
  end;

  (*
  sSQL := 'SELECT ' +
          '  COUNT ( * ) ' +
          'FROM ' +
          '  FS_SGA_Picking_Preparaciones WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) +
          sAndWhere;
  *)

  sSQL := 'SELECT ' +
          '  COUNT(DISTINCT p.PreparacionId) ' +
          'FROM ' +
          '  FS_SGA_Picking_Preparaciones p WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  FS_SGA_Operarios_Preparacion fsop WITH (NOLOCK) ' +
          'ON ' +
          '  fsop.CodigoEmpresa = p.CodigoEmpresa ' +
          '  AND fsop.PreparacionId = p.PreparacionId ' +
          'WHERE ' +
          '  p.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' ';

  if (CodigoUsuario>1) then
    sSQL := sSQL + 'AND fsop.OperarioId = ' + IntToStr(CodigoUsuario) + ' ';

  sSQL := sSQL + sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT DISTINCT ' +
          '  ISNULL(Comptadors.NumPedidos, 0) AS NumPedidos, ' +
          '  CASE WHEN Comptadors.NumPedidos=1 THEN CAST(EjercicioPedido AS varchar) ELSE ''-'' END as EjercicioPedido, ' +
          '  CASE WHEN Comptadors.NumPedidos=1 THEN SeriePedido ELSE ''-'' END as SeriePedido, ' +
          '  CASE WHEN Comptadors.NumPedidos=1 THEN CAST(NumeroPedido AS varchar) ELSE ''-'' END as NumeroPedido, ' +
          '  ISNULL(NumLineasTotales,0) AS NumLineasTotales, ' +
          '  ISNULL(NumLineasPendientesExpedir,0) AS NumLineasPendientesExpedir, ' +
          '  ISNULL(NumArticulosTotales, 0) AS NumArticulosTotales, ' +
          '  ISNULL(NumArticuloPendientesPreparar,0) AS NumArticuloPendientesPreparar, ' +
          '  p.* ' +
          'FROM ' +
          '  FS_SGA_Picking_Preparaciones p WITH ( NOLOCK ) ' +
          'LEFT JOIN ' +
          '  FS_SGA_Operarios_Preparacion fsop WITH (NOLOCK) ' +
          'ON ' +
          '  fsop.CodigoEmpresa = p.CodigoEmpresa ' +
          '  AND fsop.PreparacionId = p.PreparacionId ' +
          'LEFT JOIN ( ' +
          '  SELECT ' +
          '    CodigoEmpresa, PreparacionId, ' +
          '    MIN(EjercicioPedido) AS EjercicioPedido, ' +
          '    MIN(NumeroPedido) AS NumeroPedido, ' +
          '    MIN(SeriePedido) AS SeriePedido, ' +
          '    COUNT ( DISTINCT CONCAT ( EjercicioPedido, SeriePedido, NumeroPedido ) ) as NumPedidos, ' +
          '    COUNT ( PickingId ) AS NumLineasTotales, ' +
          '    SUM ( CASE WHEN UdSaldo>0 THEN 1 ELSE 0 END ) as NumLineasPendientesExpedir, ' +
          '    COUNT ( DISTINCT CONCAT ( CodigoArticulo, Partida ) ) as NumArticulosTotales ' +
          '  FROM ' +
          '    FS_SGA_Picking_Pedido_Lineas pl WITH ( NOLOCK ) ' +
          '  GROUP BY ' +
          '    CodigoEmpresa, PreparacionId ' +
          ') Comptadors ' +
          'ON ' +
          '  Comptadors.CodigoEmpresa = p.CodigoEmpresa ' +
          '  AND Comptadors.PreparacionId = p.PreparacionId ' +
          'LEFT JOIN ( ' +
          '  SELECT ' +
          '    CodigoEmpresa, PreparacionId, ' +
          '    COUNT(*) AS NumArticuloPendientesPreparar ' +
          '  FROM ( ' +
          '    SELECT ' +
          '      CodigoEmpresa, PreparacionId, CodigoArticulo, Partida, ' +
          '      SUM ( UdNecesarias ) AS Necesarias, MAX ( UdRetiradas ) AS Preparadas ' +
          '    FROM ' +
          '      FS_SGA_Picking_Pedido_Lineas WITH ( NOLOCK ) ' +
          '    GROUP BY ' +
          '      CodigoEmpresa, PreparacionId, CodigoArticulo, Partida ' +
          '    HAVING ' +
          '      SUM ( UdNecesarias ) > MAX ( UdRetiradas ) ' +
          '  ) B ' +
          '  GROUP BY ' +
          '    CodigoEmpresa, PreparacionId ' +
          ') Pendientes ' +
          'ON ' +
          '  Pendientes.CodigoEmpresa = p.CodigoEmpresa ' +
          '  AND Pendientes.PreparacionId = p.PreparacionId ';

  sSQL := sSQL + 'WHERE ' +
          '  p.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  ISNULL(Comptadors.NumPedidos,0)>0 ' +
          sAndWhere + ' ';

  if (CodigoUsuario>1) then
    sSQL := sSQL + 'AND fsop.OperarioId = ' + IntToStr(CodigoUsuario) + ' ';

  sSQL := sSQL + 'ORDER BY ' +
          sSort +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  //Result := '{"SQL":"' + JSON_Str(sSQL) + '","Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"PreparacionId":' + Q.FieldByName('PreparacionId').AsString + ',' +
      '"NumPedidos":' + Q.FieldByName('NumPedidos').AsString + ',' +
      '"EjercicioPedido":"' + JSON_Str(Q.FieldByName('EjercicioPedido').AsString) + '", ' +
      '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '", ' +
      '"NumeroPedido":"' + JSON_Str(Q.FieldByName('NumeroPedido').AsString) + '", ' +
      '"Ejercicio":' + Q.FieldByName('Ejercicio').AsString + ',' +
      '"Fecha":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('Fecha').AsDateTime) + '",' +
      '"CodigoCliente":"' + JSON_Str(Q.FieldByName('CodigoCliente').AsString) + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"NumLineasTotales":' + Q.FieldByName('NumLineasTotales').AsString + ',' +
      '"NumLineasPendientesExpedir":' + Q.FieldByName('NumLineasPendientesExpedir').AsString + ',' +
      '"NumArticulosTotales":' + Q.FieldByName('NumArticulosTotales').AsString + ',' +
      '"NumArticuloPendientesPreparar":' + Q.FieldByName('NumArticuloPendientesPreparar').AsString + ',' +
      '"NumLineasExpedidas":' + IntToStr(Q.FieldByName('NumLineasTotales').AsInteger-Q.FieldByName('NumLineasPendientesExpedir').AsInteger) +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


procedure WebModule1listPreparacionOrdenadaAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  IdPreparacion: Integer;
  Result: String;
  sSQL: String;
  sSQL1: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  EmpresaOrigen: Integer;
  YY: Integer;
  MostrarPartidas: Integer;
  sTable: string;
  CodigoAlmacen: String;
  CodigoArticulo: String;
  sUbicaciones: String;
  Partida: String;
  bError: Boolean;
  Pendientes: Integer;
  SoloConStock: Integer;
  iStockTotal: Double;
  CodigoUbicacionExpedicion: String;
  CodigoUbicacionesExcluidas: String;
  sMsg: String;
  sIDCall: String;
  bIsBuilding: Boolean;
{$ENDREGION}

begin

  if request.contentfields.Values['LogID']<>'' then
    sIDCall := request.contentfields.Values['LogID'];

  if Length(sIDCall)<>12 then
    sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listPreparacionOrdenadaAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  gaLogFile.Write ( 'EmpresaOrigen = ' + IntToStr(EmpresaOrigen), sIDCall  );

  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );
  gaLogFile.Write ( 'CodigoEmpresa = ' + IntToStr(CodigoEmpresa), sIDCall  );

  YY := SAGE_FECHA_AnoActivo ( Conn, EmpresaOrigen, Now() );
  gaLogFile.Write ( 'YY = ' + IntToStr(YY), sIDCall  );

  MostrarPartidas := 1; //StrToIntDef(request.contentfields.values['MostrarPartidas'],0);
  Pendientes      := StrToIntDef(request.contentfields.values['Pendientes'],0);
  SoloConStock    := StrToIntDef(request.contentfields.values['SoloConStock'],0);
  CodigoAlmacen   := Trim(request.ContentFields.Values['CodigoAlmacen']);

  IdPreparacion := StrToIntDef(request.contentfields.values['IdPreparacion'],0);
  if IdPreparacion=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de preparación no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  gaLogFile.Write ( 'IdPreparacion = ' + IntToStr(IdPreparacion), sIDCall  );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));

  sOrderBy   := '';
  sOperation := '>';

  if OrdenarPor='ARTICULO' then begin
    sOrderBy := 'fspo.CodigoArticulo ' + TipoOrden + ', fspo.Partida ' + TipoOrden + ' ';
  end else if OrdenarPor='CODIGOUBICACION' then begin
    sOrderBy := 'fspo.CodigoUbicacion ' + TipoOrden + ', fspo.rn ' + TipoOrden + ' ';
  end else if OrdenarPor='CODIGOUBICACIONALTERNATIVO' then begin
    sOrderBy := 'fspo.rn ' + TipoOrden + ' ';
  end else begin
    sOrderBy := 'fspo.rn ' + TipoOrden + ' ';
  end;

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, EmpresaOrigen );
  gaLogFile.Write ( 'CodigoUbicacionExpedicion = ' + CodigoUbicacionExpedicion, sIDCall  );

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionesExcluidasExpedicion, CodigoUbicacionesExcluidas, EmpresaOrigen );
  gaLogFile.Write ( 'CodigoUbicacionesExcluidas = ' + CodigoUbicacionesExcluidas, sIDCall  );

  if (CodigoUbicacionesExcluidas='') or (CodigoUbicacionesExcluidas='0') then
    CodigoUbicacionesExcluidas := '''''';

  if CodigoAlmacen='' then begin
    CodigoAlmacen := FS_SGA_CodigoAlmacen ( CodigoUbicacionExpedicion );
  end;

  gaLogFile.Write ( 'CodigoAlmacen = ' + CodigoAlmacen, sIDCall  );

  {$ENDREGION}

  {$REGION 'Ens assegurem que tenim creada la taula amb l´ordenació creada'}
  sSQL := 'SELECT COUNT(*) FROM FS_SGA_ActualizarRuta WITH (NOLOCK) WHERE PreparacionId=' + IntToStr(IdPreparacion);
  if SQL_Execute(Conn,sSQL)>0 then
  begin
    gaLogFile.Write ( 'Before SGA_Check_PreparacionOrdenada Manual', sIDCall  );
    SGA_Check_PreparacionOrdenada ( gsPath, Conn, EmpresaOrigen, YY, IdPreparacion, CodigoAlmacen, CodigoUbicacionExpedicion, sMsg, TRUE, bIsBuilding );
    gaLogFile.Write ( 'After SGA_Check_PreparacionOrdenada Manual: ' + sMsg, sIDCall  );
  end else begin
    gaLogFile.Write ( 'Before SGA_Check_PreparacionOrdenada', sIDCall  );
    SGA_Check_PreparacionOrdenada ( gsPath, Conn, EmpresaOrigen, YY, IdPreparacion, CodigoAlmacen, CodigoUbicacionExpedicion, sMsg, FALSE, bIsBuilding );
    gaLogFile.Write ( 'After SGA_Check_PreparacionOrdenada: ' + sMsg, sIDCall  );
  end;

  if bIsBuilding then
  begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Se está calculando la ruta. Volver a intentar en unos segundos","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  {$ENDREGION}

  {$REGION 'Recuperació de dades'}
  sTable := 'FS_SGA_TABLE_PreparacionDetallesPeriodo';

  sSQL := 'SELECT ' +
          '  fssa.UnidadesSaldo, fspo.* ' +
          'FROM ' +
          '  FS_SGA_PreparacionOrdenada fspo WITH (NOLOCK) ' +
          'INNER JOIN ' +
          '( ' +
          '  SELECT ' +
          '    CodigoUbicacion, CodigoArticulo, SUM(UnidadesSaldo) AS UnidadesSaldo  ' +
          '  FROM ' +
          '    FS_SGA_TABLE_AcumuladoStockActual ( ' + IntToStr(CodigoEmpresa) + ', ' + IntToStr(YY) + ' ) ' +
          '  GROUP BY ' +
          '    CodigoUbicacion, CodigoArticulo ' +
          ') fssa ' +
          'ON ' +
          '  fssa.CodigoUbicacion = fspo.CodigoUbicacion AND ' +
          '  fssa.CodigoArticulo = fspo.CodigoArticulo AND ' +
          '  fssa.CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ) ' +
          'WHERE ' +
          '  fspo.PreparacionId = ' + IntToStr(IdPreparacion) + ' AND ' +
          '  fspo.CodigoUbicacion NOT IN ( ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ) AND ' +
          '  fspo.CodigoUbicacion NOT IN ( ' + CodigoUbicacionesExcluidas + ' )';

  if Pendientes=1 then
     sSQL := sSQL + 'AND fspo.UdNecesarias > fspo.Udretiradas ';

  if SoloConStock=1 then
     sSQL := sSQL + 'AND fspo.CodigoUbicacion IS NOT NULL ';

  sSQL := sSQL + 'ORDER BY ' + sOrderBy;

  Q := SQL_PrepareQuery ( Conn, sSQL );
  gaLogFile.Write(sSQL, sIDCall );

  try
    Q.Open;
  except
    on E:Exception do begin
      gaLogFile.Write ( 'ERROR: ' + E.Message, sIDCall  );
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '","Data":[]}';
      FreeAndNil(Q);
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":1,"NumPages":1,"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    CodigoAlmacen  := FS_SGA_CodigoAlmacen ( Q.FieldByName('CodigoUbicacion').AsString );
    CodigoArticulo := Q.FieldByName('CodigoArticulo').AsString;
    Partida        := Q.FieldByName('Partida').AsString;

    Result := Result + '{' +
                       '"Indice":"' + Q.FieldByName('rn').AsString + '",' +
                       '"CodigoEmpresa":"' + IntToStr(CodigoEmpresa) + '",' +
                       '"UdNecesarias":"' + SQL_FloatToStr(Q.FieldByName('UdNecesarias').AsFloat) + '",' +
                       '"UdRetiradas":"' + SQL_FloatToStr(Q.FieldByName('UdRetiradas').AsFloat) + '",' +
                       '"UdExpedidas":"' + SQL_FloatToStr(Q.FieldByName('UdExpedidas').AsFloat) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(CodigoArticulo) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoArticuloAlternativo').AsString) + '",' +
                       '"DescripcionArticulo":"' + JSON_Str(Q.FieldByName('DescripcionArticulo').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Partida) + '",' +
                       '"CodigoAlmacen":"' + JSON_Str(CodigoAlmacen) + '",' +
                       '"PreparacionId":"' + Q.FieldByName('PreparacionId').AsString + '",' +
                       '"TratamientoPartidas":"' + Q.FieldByName('TratamientoPartidas').AsString + '",' +
                       '"UnidadesStock2":"' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat) + '",' +
                       '"UnidadesStock":"' + SQL_FloatToStr(iStockTotal) + '",' +
                       '"UnidadMedida":"' + JSON_Str(Q.FieldByName('UnidadMedida').AsString) + '",' +
                       '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
                       '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('CodigoUbicacionAlternativo').AsString) + '"' +
                       '}';

    Q.Next;

  end;

  if not bError then
    Result := Result + ']}'
  else
    Result := sUbicaciones;

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAR PROVEÏDORS D'UNA EMPRESA                                      │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listProveedoresAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  Filter: String;
  sAndWhere: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listProveedoresAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  Filter := trim(request.ContentFields.Values['Filtro']);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if Filter<>'' then begin
    sAndWhere := sAndWhere + 'AND ( ' +
                             '  p.Nombre LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.RazonSocial LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Domicilio LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.CodigoProveedor LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.CodigoPostal LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Municipio LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Provincia LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Telefono LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Telefono2 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Telefono3 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Email1 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.Email2 LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.CifDni LIKE ''%' + SQL_Str(Filter) + '%'' OR ' +
                             '  p.CifEuropeo LIKE ''%' + SQL_Str(Filter) + '%'' ' +
                             ')';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  Proveedores p WITH (NOLOCK) ' +
          'WHERE ' +
          '  p.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  p.FechaBajaLc IS NULL ' +
          sAndWhere;


  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  p.* ' +
          'FROM ' +
          '  Proveedores p WITH (NOLOCK) ' +
          'WHERE ' +
          '  p.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  p.FechaBajaLc IS NULL ' +
          sAndWhere +
          'ORDER BY ' +
          '  p.CodigoEmpresa, p.RazonSocial ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":"' + Q.FieldByName('CodigoEmpresa').AsString + '",' +
      '"CodigoProveedor":"' + Q.FieldByName('CodigoProveedor').AsString + '",' +
      '"CifEuropeo":"' + JSON_Str(Q.FieldByName('CifEuropeo').AsString) + '",' +
      '"Nombre":"' + JSON_Str(Q.FieldByName('Nombre').AsString) + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '",' +
      '"Nacion":"' + JSON_Str(Q.FieldByName('Nacion').AsString) + '",' +
      '"Telefono":"' + JSON_Str(Q.FieldByName('Telefono').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAR CAPÇALERA DE PREPARACIONS                                     │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listRecepcionesAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Tipo: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  Filter: String;
  sAndWhere: String;
  sSort: String;
  sSortType: String;
  CodigoUsuario: Integer;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listRecepcionesAction: ' + Request.RemoteAddr, sIDCall  );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],MAXINT);
  if iPageSize=0 then iPageSize := MAXINT;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoUsuario := StrToIntDef(request.contentfields.Values['CodigoUsuario'], 0 );
  Tipo := StrToIntDef(request.contentfields.values['Tipo'],0);

  sSort := AnsiLowerCase(trim(request.contentfields.Values['OrdenarPor']));
  sSortType := AnsiLowerCase(trim(request.contentfields.Values['TipoOrden']));

  if (sSort='fecha') then
    sSort := ' r.Fecha '
  else if (sSort='cliente') then
    sSort := ' r.CodigoProveedor '
  else if (sSort='lineas') then
    sSort := ' 1 '
  else if (sSort='progreso') then
    sSort := ' '
    (*' 1.0 - ( CAST ( ( SELECT COUNT( * ) FROM FS_SGA_Picking_Pedido_Lineas pl ' +
             ' WHERE p.CodigoEmpresa = pl.CodigoEmpresa AND p.PreparacionId = pl.PreparacionId AND ' +
             ' pl.UdSaldo<>0 ) AS float ) / NULLIF ( cast ( ( SELECT COUNT( * ) ' +
             ' FROM FS_SGA_Picking_Pedido_Lineas pl WHERE p.CodigoEmpresa = pl.CodigoEmpresa AND ' +
             ' p.PreparacionId = pl.PreparacionId ' +
             ' ) as float),0 ) ) '*)
  else
    sSort := ' r.RecepcionId ';

  if sSortType='desc' then
    sSort := sSort + ' DESC ';

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if (Tipo=0) or (Tipo=1) then
    sAndWhere := sAndWhere + 'AND r.Estado IN (0,1) '
  else
    sAndWhere := sAndWhere + 'AND r.Estado = ' + IntToStr(Tipo) + ' ';

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  FS_SGA_Recepciones r WITH (NOLOCK) ' +
          'INNER JOIN ' +
          '  CabeceraPedidoProveedor cpc WITH (NOLOCK) ' +
          'ON ' +
          '  r.CodigoEmpresa = cpc.CodigoEmpresa AND ' +
          '  r.EjercicioPedido = cpc.EjercicioPedido AND ' +
          '  r.SeriePedido = cpc.SeriePedido AND ' +
          '  r.NumeroPedido = cpc.NumeroPedido ' +
          'WHERE ' +
          '  r.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  ( ' +
          '    SELECT ' +
          '      COUNT(*) ' +
          '    FROM ' +
          '      FS_SGA_Recepciones_Lineas rl WITH (NOLOCK) ' +
          '    WHERE ' +
          '      r.CodigoEmpresa = rl.CodigoEmpresa AND ' +
          '      r.RecepcionId = rl.RecepcionId ' +
          '  ) AS NumLineasTotales, ' +
          '  ( ' +
          '    SELECT ' +
          '      COUNT(*) ' +
          '    FROM ' +
          '      FS_SGA_Recepciones_Lineas rl WITH (NOLOCK) ' +
          '    WHERE ' +
          '      r.CodigoEmpresa = rl.CodigoEmpresa AND ' +
          '      r.RecepcionId = rl.RecepcionId AND ' +
          '      rl.UdSaldo<>0 ' +
          '  ) AS NumLineasPendientes, ' +
          '  r.* ' +
          'FROM ' +
          '  FS_SGA_Recepciones r WITH (NOLOCK) ' +
          'LEFT JOIN ' +
          '  CabeceraPedidoProveedor cpc WITH (NOLOCK) ' +
          'ON ' +
          '  r.CodigoEmpresa = cpc.CodigoEmpresa AND ' +
          '  r.EjercicioPedido = cpc.EjercicioPedido AND ' +
          '  r.SeriePedido = cpc.SeriePedido AND ' +
          '  r.NumeroPedido = cpc.NumeroPedido ' +
          'WHERE ' +
          '  r.CodigoEmpresa = ' + IntToStr(EmpresaOrigen) +
          sAndWhere +
          'ORDER BY ' +
          sSort +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.Open;

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"RecepcionId":' + Q.FieldByName('RecepcionId').AsString + ',' +
      '"Fecha":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('Fecha').AsDateTime) + '",' +
      '"CodigoProveedor":"' + JSON_Str(Q.FieldByName('CodigoProveedor').AsString) + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"IdAlbaranPro":"' + JSON_Str(Q.FieldByName('IdAlbaranPro').AsString) + '",' +
      '"Albaran":"' + JSON_Str(Q.FieldByName('Albaran').AsString) + '",' +
      '"Observaciones":"' + JSON_Str(Q.FieldByName('Observaciones').AsString) + '",' +
      '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
      '"SeriePedido":"' + JSON_Str(Q.FieldByName('SeriePedido').AsString) + '",' +
      '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
      '"FechaInicioRecepcion":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('FechaInicioRecepcion').AsDateTime) + '",' +
      '"FechaFinRecepcion":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('FechaFinRecepcion').AsDateTime) + '",' +
      '"Estado":' + Q.FieldByName('Estado').AsString + ',' +
      '"NumLineasTotales":' + Q.FieldByName('NumLineasTotales').AsString + ',' +
      '"NumLineasPendientes":' + Q.FieldByName('NumLineasPendientes').AsString + ',' +
      '"NumLineasRealizadas":' + IntToStr(Q.FieldByName('NumLineasTotales').AsInteger-Q.FieldByName('NumLineasPendientes').AsInteger) + ',' +
      '"Bultos":' + IntToStr(Q.FieldByName('Bultos').AsInteger) + ',' +
      '"Cajas":' + IntToStr(Q.FieldByName('Cajas').AsInteger) + ',' +
      '"Palets":' + IntToStr(Q.FieldByName('Palets').AsInteger) + ',' +
      '"RefAlbaran":"' + JSON_Str(Q.FieldByName('RefNumeroAlbaran').AsString) + '",' +
      '"FechaAlbaran":"' + FormatDateTime ( 'dd/mm/yyyy', Q.FieldByName('RefFechaAlbaran').AsDateTime) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;


// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE SUBFAMÍLIES D'UNA FAMÍLIA D'ARTICLES                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listSubfamiliasAction(Sender: TObject;
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoFamilia: String;
  Filtro: String;
  sAndWhere: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listSubfamiliasAction: ' + Request.RemoteAddr, sIDCall );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Familias' );

  CodigoFamilia := Trim(request.contentfields.values['CodigoFamilia']);
  if CodigoFamilia='' then begin
    Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de familia no especificado","Data":[]}';
    Response.Content := Result;
    Exit;
  end;

  Filtro := Trim(request.contentfields.values['Filtro']);

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if Filtro<>'' then begin
    sAndWhere := sAndWhere + 'AND ( ' +
      'CodigoSubfamilia LIKE ''%' + SQL_Str(Filtro) + '%'' OR ' +
      'Descripcion LIKE ''%' + SQL_Str(Filtro) + '%'' ' +
      ' ) ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Familias ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoFamilia = ''' + SQL_Str(CodigoFamilia) + ''' AND ' +
          '  CodigoSubfamilia <> ''**********'' ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  dbo.FS_SGA_TABLE_Familias ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  CodigoFamilia = ''' + SQL_Str(CodigoFamilia) + ''' AND ' +
          '  CodigoSubfamilia <> ''**********'' ' +
          sAndWhere +
          'ORDER BY ' +
          '  CodigoSubfamilia ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );
  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result + '{' +
      '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
      '"Descripcion":"' + JSON_Str(Q.FieldByName('Descripcion').AsString) + '"' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;


end;

{$ENDREGION}


{$REGION '--- FUNCIONS DE COMANDES I ALBARANS DE PROVEÏDOR'}

// ┌───────────────────────────────────────────────────────────────────────┐ \\
// │ LLISTAT DE COMANDES A PROVEÏDOR                                       │ \\
// └───────────────────────────────────────────────────────────────────────┘ \\
procedure WebModule1listPedidosCompraAction
 ( Conn: TADOConnection; sParams: String; var statusCode: Integer; var statusText: String; var Result: String );

{$REGION 'Declaració de variables'}
var
  CodigoEmpresa: Integer;
  Result: String;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoProveedor: String;
  sAndWhere: String;
  EjercicioPedido: Integer;
  OrdenarPor: String;
  TipoOrden: String;
  sOrderBy: String;
  EmpresaOrigen: Integer;
  sIDCall: String;
{$ENDREGION}

begin

  sIDCall := GenerateRandomHash ( 12 );

  gaLogFile.Write ( 'WebModule1listPedidosCompraAction: ' + Request.RemoteAddr, sIDCall );

  {$REGION 'Recuperació de paràmetres'}

  iPage     := StrToIntDef(request.contentfields.values['Page'],0);
  iPageSize := StrToIntDef(request.contentfields.values['PageSize'],DEFAULT_PAGE_SIZE);
  if iPageSize=0 then iPageSize := DEFAULT_PAGE_SIZE;

  EmpresaOrigen := StrToIntDef(request.contentfields.Values['CodigoEmpresa'], 0 );
  if EmpresaOrigen=0 then begin
    Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"Código de empresa no especificado","Data":[]}';
    Exit;
  end;
  CodigoEmpresa := SAGE_EMPRESA_EmpresaOrigen ( Conn, EmpresaOrigen, 'Almacenes' );

  CodigoProveedor := trim(request.contentfields.values['CodigoProveedor']);
  EjercicioPedido := StrToIntDef(request.contentfields.Values['EjercicioPedido'], 0 );

  OrdenarPor := AnsiUpperCase(Trim(request.contentfields.values['OrdenarPor']));
  TipoOrden  := AnsiUpperCase(Trim(request.contentfields.values['TipoOrden']));
  sOrderBy   := '';

  if OrdenarPor='PEDIDO' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioPedido DESC, SeriePedido DESC, NumeroPedido DESC ';
    end else begin
      sOrderBy := 'EjercicioPedido, SeriePedido, NumeroPedido ';
    end;
  end else if OrdenarPor='PROVEEDOR' then begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'RazonSocial DESC, EjercicioPedido, SeriePedido, NumeroPedido ';
    end else begin
      sOrderBy := 'RazonSocial, EjercicioPedido, SeriePedido, NumeroPedido ';
    end;
  end else begin
    if TipoOrden='DESC' then begin
      sOrderBy := 'EjercicioPedido DESC, SeriePedido DESC, NumeroPedido DESC ';
    end else begin
      sOrderBy := 'EjercicioPedido, SeriePedido, NumeroPedido ';
    end;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de totals'}

  sAndWhere := '';

  if CodigoProveedor<>'' then begin
    sAndWhere := sAndWhere + 'AND CodigoProveedor=''' + SQL_Str(CodigoProveedor) + ''' ';
  end;

  if EjercicioPedido<>0 then begin
    sAndWhere := sAndWhere + 'AND EjercicioPedido=' + IntToStr(EjercicioPedido) + ' ';
  end;

  sSQL := 'SELECT ' +
          '  COUNT(*) ' +
          'FROM ' +
          '  CabeceraPedidoProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  FechaPedido >= DATEADD(day,-30,GETDATE()) AND ' +
          '  Estado <> 2 ' +
          sAndWhere;

  try
    iTotalRegs := SQL_Execute ( Conn, sSQL );
  except
    on E:Exception do begin
      Result := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  if Frac(iTotalRegs / iPageSize)=0 then begin
    iPages := iTotalRegs div iPageSize;
  end else begin
    iPages := Trunc(iTotalRegs div iPageSize)+1;
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  sSQL := 'SELECT ' +
          '  * ' +
          'FROM ' +
          '  CabeceraPedidoProveedor WITH (NOLOCK) ' +
          'WHERE ' +
          '  CodigoEmpresa = ' + IntToStr(EmpresaOrigen) + ' AND ' +
          '  FechaPedido >= DATEADD(day,-30,GETDATE()) AND ' +
          '  Estado <> 2 ' +
          sAndWhere +
          'ORDER BY ' +
          sOrderBy + ' ' +
          'OFFSET ' + IntToStr(iPage*iPageSize) + ' ROWS ' +
          'FETCH NEXT ' + IntToStr(iPageSize) + ' ROWS ONLY';

  Q := SQL_PrepareQuery ( Conn, sSQL );

  try
    Q.Open;
  except
    on E:Exception do begin
      Q.Close;
      FreeAndNil(Q);
      Response.Content := '{"Request":"' + JSON_StrWeb(Request.ContentFields.Text) + '","Result":"ERROR","Message":"' + E.Message + '"","Data":[]}';
      Exit;
    end;
  end;

  iNumRegs := Q.RecordCount;
  Result := '{"Result":"OK","Error":"","TotalRecords":' + IntToStr(iTotalRegs) + ',"NumPages":' + IntToStr(iPages) + ',"NumRecords":' + IntToStr(iNumRegs) + ',"Data":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    Result := Result +
      '{' +
      '"CodigoEmpresa":' + Q.FieldByName('CodigoEmpresa').AsString + ',' +
      '"IdDelegacion":"' + Q.FieldByName('IdDelegacion').AsString + '",' +
      '"EjercicioPedido":' + Q.FieldByName('EjercicioPedido').AsString + ',' +
      '"SeriePedido":"' + Q.FieldByName('SeriePedido').AsString + '",' +
      '"NumeroPedido":' + Q.FieldByName('NumeroPedido').AsString + ',' +
      '"CodigoProveedor":"' + Q.FieldByName('CodigoProveedor').AsString + '",' +
      '"RazonSocial":"' + JSON_Str(Q.FieldByName('RazonSocial').AsString) + '",' +
      '"Nombre":"' + JSON_Str(Q.FieldByName('Nombre').AsString) + '",' +
      '"Domicilio":"' + JSON_Str(Q.FieldByName('Domicilio').AsString) + '",' +
      '"CodigoPostal":"' + JSON_Str(Q.FieldByName('CodigoPostal').AsString) + '",' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '",' +
      '"Nacion":"' + JSON_Str(Q.FieldByName('Nacion').AsString) + '",' +
      '"FechaPedido":"' + FormatDateTime('dd/mm/yyyy', Q.FieldByName('FechaPedido').AsDateTime) + '",' +
      '"NumeroLineas":' + Q.FieldByName('NumeroLineas').AsString + ',' +
      '"Municipio":"' + JSON_Str(Q.FieldByName('Municipio').AsString) + '",' +
      '"Provincia":"' + JSON_Str(Q.FieldByName('Provincia').AsString) + '",' +
      '"Nacion":"' + JSON_Str(Q.FieldByName('Nacion').AsString) + '",' +
      '"Estado":' + Q.FieldByName('Estado').AsString + '' +
      '}';

    Q.Next;

  end;

  Result := Result + ']}';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

  Response.Content := Result;

end;

{$ENDREGION}


{$REGION '--- FUNCIONS D´ETIQUETES'}

{$ENDREGION}


{$REGION '--- FUNCIONS DE COMANDES I ALBARANS DE PROVEÏDOR'}

{$ENDREGION}



function FS_SGA_ObtenerUbicaciones ( Conn: TADOConnection; CodigoEmpresa: Integer;
  CodigoArticulo, Partida, CodigoAlmacen: String; MostrarPartidas: Integer;
  var Error: Boolean; var iStockTotal: Double ): String;

{$REGION 'Declaració de variables'}
var
  IdPreparacion: Integer;
  sSQL: String;
  Q: TADOQuery;
  iTotalRegs, iNumRegs: Integer;
  iPageSize, iPage: Integer;
  iPages: Integer;
  CodigoUbicacion: string;
  sDesglose: string;
  OrdenarPor: String;
  sOrderBy: String;
  TipoOrden: String;
  PickingId: Integer;
  sMostrarPartidas: String;
  YY: WORD;
  sFechaUltimaEntrada: string;
  FechaUltimaEntrada: TDateTime;
  FechaCaduca: TDateTime;
  sFechaCaduca: string;
  TratamientoPartidas: Boolean;
  sMostrarAlmacenes: string;
  CodigoUbicacionExpedicion: String;
{$ENDREGION}

begin

  Error := FALSE;

  iStockTotal := 0;

  {$REGION 'Preparació de paràmetres'}

  YY := SAGE_FECHA_AnoActivo ( Conn, CodigoEmpresa, Now() );

  sMostrarAlmacenes := 'AND CodigoAlmacen=''' + SQL_Str(CodigoAlmacen) + ''' ';

  if MostrarPartidas<>1 then begin
    sOrderBy := 'MIN(CASE WHEN FechaCaduca IS NULL THEN ' +
      SQL_DateToStr(EncodeDate(9999,12,31)) + ' ELSE FechaCaduca END), Partida, CodigoUbicacion ';
    sMostrarPartidas := 'AND Partida=''' + SQL_Str(Partida) + ''' ';
  end else begin
    sOrderBy := 'MIN(CASE WHEN FechaCaduca IS NULL THEN ' +
      SQL_DateToStr(EncodeDate(9999,12,31)) + ' ELSE FechaCaduca END), CodigoUbicacion, Partida ';
  end;

  {$ENDREGION}

  {$REGION 'Recuperació de dades'}

  PARAM_Read ( Conn, 'FS_SGA_Parametros', FS_PARAMS_SGA_UbicacionDefectoExpedicion, CodigoUbicacionExpedicion, CodigoEmpresa );

  sSQL := 'SELECT ' +
          '  CodigoAlmacen, Almacen, CodigoZona, NombreZona, CodigoUbicacion, CodigoPasillo, ' +
          '  DescripcionPasillo, CodigoEstanteria, Altura, Fondo, Picking, Bloqueada, Inactiva, ' +
          '  MultiRef, MultiLote, Rotacion, CodigoArticulo, Partida, ' +
          '  CodigoFamilia, CodigoSubfamilia, CodigoAlternativo, codigoUbicacionAlternativo, ' +
          '  CodigoAlternativo2, TratamientoPartidas, ' +
          '  SUM(UnidadesSaldo) AS UnidadesSaldo, SUM(UnidadesUsadas) AS UnidadesUsadas, ' +
          '  MIN(FechaPrimeraEntrada) AS FechaPrimeraEntrada, MIN(FechaUltimaEntrada) AS FechaUltimaEntrada, ' +
          '  MAX(FechaUltimaSalida) AS FechaUltimaSalida, MIN(CASE WHEN FechaCaduca IS NULL THEN ' +
          SQL_DateToStr(EncodeDate(9999,12,31)) + ' ELSE FechaCaduca END) AS FechaCaduca ' +
          'FROM ' +
          '  FS_SGA_TABLE_UbicacionsPickingPedidos ( ' + IntToStr(CodigoEmpresa) + ' ) ' +
          'WHERE ' +
          '  Ejercicio = ' + IntToStr ( YY ) + ' AND ' +
          '  CodigoArticulo = ''' + SQL_Str(CodigoArticulo) + ''' AND ' +
          '  CodigoUbicacion <> ''' + SQL_Str(CodigoUbicacionExpedicion) + ''' ' +
          sMostrarAlmacenes +
          sMostrarPartidas +
          'GROUP BY ' +
          '  CodigoAlmacen, Almacen, CodigoZona, NombreZona, CodigoUbicacion, CodigoPasillo, ' +
          '  DescripcionPasillo, CodigoEstanteria, Altura, Fondo, Picking, Bloqueada, Inactiva, ' +
          '  MultiRef, MultiLote, Rotacion, CodigoArticulo, Partida, ' +
          '  CodigoFamilia, CodigoSubfamilia, CodigoAlternativo, codigoUbicacionAlternativo, ' +
          '  CodigoAlternativo2, TratamientoPartidas ' +
          'ORDER BY ' +
          sOrderBy;

  Q := SQL_PrepareQuery ( Conn, sSQL );
  Q.SQL.Text := sSQL;
  Q.Open;

  Result := '"SQL":"' + JSON_Str(sSQL) + '","Ubicaciones":[';
  iNumRegs := 0;

  while not Q.Eof do begin

    if iNumRegs<>0 then
      Result := Result + ',';

    Inc(iNumRegs);

    FechaUltimaEntrada := Q.FieldByName('FechaUltimaEntrada').AsDateTime;
    if FechaUltimaEntrada=0 then
      FechaUltimaEntrada := Q.FieldByName('FechaPrimeraEntrada').AsDateTime;
    if FechaUltimaEntrada=0 then
      sFechaUltimaEntrada := ''
    else
      sFechaUltimaEntrada := FormatDateTime('dd/mm/yyyy',FechaUltimaEntrada);

    FechaCaduca := Q.FieldByName('FechaCaduca').AsDateTime;
    if FechaCaduca=0 then
      sFechaCaduca := ''
    else
      sFechaCaduca := FormatDateTime('dd/mm/yyyy',FechaCaduca);

    iStockTotal := iStockTotal + Q.FieldByName('UnidadesSaldo').AsFloat;

    Result := Result + '{' +
                       '"CodigoAlmacen":"' + JSON_Str(Q.FieldByName('CodigoAlmacen').AsString) + '",' +
                       '"Almacen":"' + JSON_Str(Q.FieldByName('Almacen').AsString) + '",' +
                       '"CodigoZona":"' + JSON_Str(Q.FieldByName('CodigoZona').AsString) + '",' +
                       '"NombreZona":"' + JSON_Str(Q.FieldByName('NombreZona').AsString) + '",' +
                       '"CodigoUbicacion":"' + JSON_Str(Q.FieldByName('CodigoUbicacion').AsString) + '",' +
                       '"CodigoUbicacionAlternativo":"' + JSON_Str(Q.FieldByName('codigoUbicacionAlternativo').AsString) + '",' +
                       '"CodigoPasillo":"' + JSON_Str(Q.FieldByName('CodigoPasillo').AsString) + '",' +
                       '"DescripcionPasillo":"' + JSON_Str(Q.FieldByName('DescripcionPasillo').AsString) + '",' +
                       '"CodigoEstanteria":"' + JSON_Str(Q.FieldByName('CodigoEstanteria').AsString) + '",' +
                       '"Altura":"' + JSON_Str(Q.FieldByName('Altura').AsString) + '",' +
                       '"Fondo":"' + JSON_Str(Q.FieldByName('Fondo').AsString) + '",' +
                       '"Picking":"' + SQL_BooleanToStr(Q.FieldByName('Picking').AsBoolean) + '",' +
                       '"Bloqueada":"' + SQL_BooleanToStr(Q.FieldByName('Bloqueada').AsBoolean) + '",' +
                       '"Inactiva":"' + SQL_BooleanToStr(Q.FieldByName('Inactiva').AsBoolean) + '",' +
                       '"CodigoArticulo":"' + JSON_Str(Q.FieldByName('CodigoArticulo').AsString) + '",' +
                       '"Partida":"' + JSON_Str(Q.FieldByName('Partida').AsString) + '",' +
                       '"UnidadesSaldo":"' + SQL_FloatToStr(Q.FieldByName('UnidadesSaldo').AsFloat) + '",' +
                       '"FechaUltimaEntrada":"' + sFechaUltimaEntrada + '",' +
                       '"FechaCaduca":"' + sFechaCaduca + '",' +
                       '"CodigoFamilia":"' + JSON_Str(Q.FieldByName('CodigoFamilia').AsString) + '",' +
                       '"CodigoSubfamilia":"' + JSON_Str(Q.FieldByName('CodigoSubfamilia').AsString) + '",' +
                       '"CodigoArticuloAlternativo":"' + JSON_Str(Q.FieldByName('CodigoAlternativo').AsString) + '",' +
                       '"TratamientoPartidas":"' + JSON_Str(Q.FieldByName('TratamientoPartidas').AsString) + '",' +
                       '"UnidadesUsadas":"' + SQL_FloatToStr(Q.FieldByName('UnidadesUsadas').AsFloat) + '"' +
                       '}';

    Q.Next;

  end;

  Result := Result + ']';

  Q.Close;
  FreeAndNil(Q);

  {$ENDREGION}

end;


end.
