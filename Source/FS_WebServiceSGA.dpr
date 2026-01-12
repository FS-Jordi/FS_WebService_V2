program FS_WebServiceSGA;

{$ifdef DEBUG}
  {$APPTYPE CONSOLE}
{$endif}

uses
  System.SysUtils,
  Vcl.SvcMgr,
  Functions_DB in '..\..\..\COMMON\Functions_DB.pas',
  Functions_EncryptDecrypt in '..\..\..\COMMON\Functions_EncryptDecrypt.pas',
  Functions_JSON in '..\..\..\COMMON\Functions_JSON.pas',
  Functions_LogV2 in '..\..\..\COMMON\Functions_LogV2.pas',
  Functions_Network in '..\..\..\COMMON\Functions_Network.pas',
  Functions_PARAMS in '..\..\..\COMMON\Functions_PARAMS.pas',
  Functions_Process in '..\..\..\COMMON\Functions_Process.pas',
  Functions_SAGE in '..\..\..\COMMON\Functions_SAGE.pas',
  Functions in 'Functions.pas',
  Globals in 'Globals.pas',
  Main in 'Main.pas' {FS_MainWebServiceSGA: TService},
  SGAWebModule in 'SGAWebModule.pas',
  Functions_CODE128 in '..\..\..\COMMON\Functions_CODE128.pas',
  Functions_Updates in '..\..\..\COMMON\Functions_Updates.pas',
  Functions_Registry in '..\..\..\COMMON\Functions_Registry.pas',
  Functions_SGA in '..\..\..\COMMON\Functions_SGA.pas',
  Functions_LicenseDLL in '..\..\..\COMMON\Functions_LicenseDLL.pas',
  Functions_Types in '..\..\..\COMMON\Functions_Types.pas';

{$R *.RES}

var
  MyDummyBoolean: Boolean;
  FS: TFS_MainWebServiceSGA;

begin

  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //

  {$ifdef DEBUG}

  try
    // In debug mode the server acts as a console application.
    WriteLn('MyServiceApp DEBUG mode. Press enter to exit.');

    // Create the TService descendant manually.
    FS_MainWebServiceSGA := TFS_MainWebServiceSGA.Create(nil);

    // Simulate service start.
    MyDummyBoolean := False;
    FS_MainWebServiceSGA.ServiceStart(FS_MainWebServiceSGA, MyDummyBoolean);
    FS_MainWebServiceSGA.ServiceExecute(FS_MainWebServiceSGA);

    // Keep the console box running (ServerContainer1 code runs in the background)
    while (not gbFinalitzar) do
    begin
    end;

    // On exit, destroy the service object.
    FreeAndNil(FS_MainWebServiceSGA);
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      WriteLn('Press enter to exit.');
      ReadLn;
    end;
  end;

  {$else}

  // Run as a true windows service (release).
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TFS_MainWebServiceSGA, FS_MainWebServiceSGA);
  Application.Run;

  {$endif}

end.
