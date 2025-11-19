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