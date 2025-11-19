unit Globals;


interface


{$REGION '--- IMPORTS'}

uses
  System.Classes,
  System.JSON,
  Functions_Updates;

{$ENDREGION}


{$REGION '--- DECLARACIÓ DE VARIABLES GLOBALS'}

type
  TParametrosConfig = record
    ActivarDesconnexio: Boolean;          // Desconnexió automàtica ON/OFF
    MinutsMarge: Integer;                 // Minuts de marge per tancar sessió
    Horaris: array[0..6,0..3] of record   // Horaris de tancament de sessió diaris
      HoraInici: TDateTime;               // Hora d'inici
      HoraFinal: TDateTime;               // Hora final
      CerrarSesion: Boolean;              // Tancar sessió a l'arribar a hora final + minuts de marge
      ContinuarTrabajos: Boolean;         // Continuar els treballs amb operari 0
    end;
    PurgeLogFilesDays: Integer;
    WaitStart: Integer;
  end;

var

  gsPath: String;                         // Path de l'aplicació
  gsPathRepositorio: String;              // Path compartido del repositorio

  TVSFixedFileInfo: TEXEVersionData;      // Versió de l'aplicació

  gsCustomerCode: AnsiString;             // Codi del client
  gsCustomerName: AnsiString;             // Nom del client
  gsProductList: TStringList;             // Llistat de productes
  gsLicenseList: TStringList;             // Llistat de llicències

  gbMultiInstance: Boolean;               // Servei multiinstància

  giNumRegistrosBloque: Integer;
  gsPCName: String;
  gsMACAddress: String;

  gbDebug: Boolean;                       // Programa en mode debug
  gbDemo: Boolean;                        // Programa sense connexió a SAGE
  gbRestartService: Boolean;              // Activar reinici del servei
  gtRestartServiceTime: TTime;            // Hora de reinici del servei
  gbUseSSL: Boolean;                      // Fer crides HTTPS

  gdtLastLive: TDateTime;
  gbSGAWS_Active: Boolean;                // Webservice del SGA actiu
  giSGAWS_Port: Integer;                  // Port de comunicació amb el WS del SGA

  gsProv: WideString;                     // Provider
  gsHost: WideString;                     // Servidor de base de dades
  gsBBDD: WideString;                     // Nom de la base de dades
  gsUser: WideString;                     // Usuari de la base de dades
  gsPass: WideString;                     // Password de la base de dades

  gsActualizarCabeceraVentas: String;
  gsActualizarCabeceraCompras: String;
  gsActualizarCabeceraDevVentas: String;
  gsActualizarCabeceraDevCompras: String;

  giPermiteStockNegativo: Integer;        // Permetre stock negatiu

  aParamsConfig: TParametrosConfig;       // Configuració gfeneral

  gbGD_Active: boolean;
  gsGD_TempPath: String;
  gsGD_DestPath: String;

  gbGS1Estandar: Boolean;
  gsGS1GroupSeparator: String;

  globalYY: Integer;      // Ejercicio de trabajo de Sage

  //JSonObject : TJSonObject;
  //JSonValue  : TJSonValue;
  //JSonArray  : TJsonArray;

  gbFinalitzar: Boolean;                  // Finalitzar el servei
  giCodigoEmpresa: SmallInt;
  giNumSessions: Integer;

  gbTratamientoSimplificado: Boolean;

  gbCalculatingRoute: Boolean;

{$ENDREGION}


implementation

end.

