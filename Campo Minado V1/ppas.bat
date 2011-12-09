@echo off
SET THEFILE=f:\usp\icc\trabal~1\campom~1\campom~1.exe
echo Linking %THEFILE%
c:\dev-pas\bin\ldw.exe  -s   -b base.$$$ -o f:\usp\icc\trabal~1\campom~1\campom~1.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
