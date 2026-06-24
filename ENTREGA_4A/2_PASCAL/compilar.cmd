@echo off
rem ====================================================================
rem  Compila el SISTEMA 4A - VARIANTE UNA SOLA VENTANA (Free Pascal).
rem  Requiere Free Pascal 3.2.2 (con ptcgraph + ptccrt) en C:\FPC.
rem  Genera bin\P_Sistema.exe (subsistema GUI, sin consola).
rem ====================================================================
setlocal
set FPC=C:\FPC\3.2.2\bin\i386-Win32\fpc
if not exist "%FPC%" (
  echo No se encontro fpc en %FPC%
  echo Instale Free Pascal o ajuste la ruta FPC en este archivo.
  pause
  exit /b 1
)
if not exist bin mkdir bin
"%FPC%" -O2 -FEbin -FUbin P_Sistema.pas
echo.
if exist bin\P_Sistema.exe (
  echo Listo: bin\P_Sistema.exe
) else (
  echo Hubo errores de compilacion.
)
pause
