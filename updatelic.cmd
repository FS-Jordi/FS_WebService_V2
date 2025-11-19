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

if exist updates\license.dat (

	if exist license.dat.old (
		del /F "license.dat.old"
	)

	REM ***************************************************************
	REM *** Renombramos el archivo actual                           ***
	REM ***************************************************************

	ren license.dat license.dat.old
	
	REM ***************************************************************
	REM *** Descomprimimos el archivo ZIP del servidor              ***
	REM ***************************************************************

	copy updates\license.dat .
	
	REM ***************************************************************
	REM *** Restauramos el Guardian si no està dentro del uppdate   ***
	REM ***************************************************************
	
	if not exist license.dat (
		ren license.dat.old license.dat
	)
	else (
		
		del /F updates\license.dat
	)
	
)

sc start FSGuardian
