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
REM *** Renombramos el archivo actual                           ***
REM ***************************************************************

if exist FS_LicenseServer.EXE.old (

	ren FS_LicenseServer.EXE FS_LicenseServer.EXE.tmp
	
	REM ***************************************************************
	REM *** Renombramos el archivo antiguo                          ***
	REM ***************************************************************

	ren FS_LicenseServer.EXE.old FS_LicenseServer.exe

	REM ***************************************************************
	REM *** Borramos la copia de seguridad el archivo               ***
	REM ***************************************************************

	del /F "FS_LicenseServer.EXE.tmp"
	
)

if exist FS_ServerGuardian.EXE.old (

	ren FS_ServerGuardian.EXE FS_ServerGuardian.EXE.tmp

	REM ***************************************************************
	REM *** Renombramos el archivo antiguo                          ***
	REM ***************************************************************

	ren FS_ServerGuardian.EXE.old FS_ServerGuardian.exe
	
	if not exist FS_ServerGuardian.EXE (
		ren FS_ServerGuardian.EXE.tmp FS_ServerGuardian.EXE
	)

	REM ***************************************************************
	REM *** Borramos la copia de seguridad el archivo               ***
	REM ***************************************************************

	del /F "FS_ServerGuardian.EXE.tmp"
	
)

if exist FS_LicenseServer.EXE (
	@echo "Iniciando aplicaci¢n..."
	sc start FSGuardian
)