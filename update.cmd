@ECHO OFF

REM ***************************************************************
REM *** Forzamos el cierre de servicios                         ***
REM ***************************************************************

sc stop FSGuardian
:loopGuardian
sc query FSGuardian | find "STOPPED"
if errorlevel 1 (
  timeout 1
  goto loopGuardian
)

sc stop FS_MainLicenseServer
:loopLS
sc query FS_MainLicenseServer | find "STOPPED"
if errorlevel 1 (
  timeout 1
  goto loopLS
)

REM ***************************************************************
REM *** Borramos la copia de seguridad el archivo               ***
REM ***************************************************************

if exist FS_LicenseServer.EXE (

	if exist FS_LicenseServer.EXE.old (
		del /F "FS_LicenseServer.exe.old"
	)
	
	if exist FS_ServerGuardian.EXE.old (
		del /F "FS_ServerGuardian.exe.old"
	)

	REM ***************************************************************
	REM *** Renombramos el archivo actual                           ***
	REM ***************************************************************

	ren FS_LicenseServer.EXE FS_LicenseServer.EXE.old
	ren FS_ServerGuardian.EXE FS_ServerGuardian.EXE.old

	REM ***************************************************************
	REM *** Descomprimimos el archivo ZIP del servidor              ***
	REM ***************************************************************

	@unzip -o updates\licenseserver.zip
	
	REM ***************************************************************
	REM *** Restauramos el Guardian si no està dentro del uppdate   ***
	REM ***************************************************************
	
	if not exist FS_ServerGuardian.EXE (
		ren FS_ServerGuardian.EXE.old FS_ServerGuardian.EXE
	)
	
	if exist FS_LicenseServer.EXE (
		del /F updates\licenseserver.zip		
		@echo "Iniciando aplicaci¢n..."
		sc start FSGuardian
	) else (
		CALL restore.cmd
	)

)