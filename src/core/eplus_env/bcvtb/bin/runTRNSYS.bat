@echo off
rem ============================================================
rem Script to run TRNSYS.
rem This script is called by the BCVTB to run TRNSYS on Windows.
rem 
rem tsnouidui@lbl.gov                                   2013-01-24
rem ============================================================
set argument=%1%

@echo Checking for TRNSYS
if exist "%BCVTB_TRNSYS_BIN%" goto GETEXT
@echo Error: Environment variable to TRNSYS is not valid.
@echo        BCVTB_TRNSYS_BIN=%BCVTB_TRNSYS_BIN%
@echo        Check bin/systemVariables-windows.properties
@echo        Exit with error.
goto END

:GETEXT
@echo Getting file extension
rem Get file extension
set ext=%argument:~-3%
if %ext%==dck goto RUNTRNSYS
@echo Error: First argument of %0 must be dck file.
@echo        Exit with error.
goto END

@echo Deleting temporary files generated by TRNSYS
set fileSet=buildlog.txt socket.cfg utilSocket.cfg
for %%a IN (%fileSet%) do call :saveDel %%a
goto NEXT 

rem Delete files if they exist
:saveDel
if exist %1 del %1
goto END

rem Continuation after the loop
:NEXT


:RUNTRNSYS
@echo Starting TRNExe.exe
"%BCVTB_TRNSYS_BIN%" %argument%
goto END

:END