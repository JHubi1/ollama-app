@echo OFF
cd /D "%~dp0"
cls

call flutter clean

echo.
pause
echo ----------

call flutter pub get

echo.
echo ----------
pause
exit
