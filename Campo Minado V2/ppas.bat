@echo off
SET THEFILE=e:\usp\icc\trabal~1\campom~1\campom~2\campom~1.exe
echo Linking %THEFILE%
c:\arquiv~1\dev-pas\bin\ldw.exe  -s   -b base.$$$ -o e:\usp\icc\trabal~1\campom~1\campom~2\campom~1.exe link.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occured while assembling %THEFILE%
goto end
:linkend
echo An error occured while linking %THEFILE%
:end
