@echo OFF
cd /D "%~dp0"
cd ..
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
