@echo off
cd /d "%~dp0"
echo WARNING: This resets the OpenSearch data volume for this lab.
choice /M "Reset the lab"
if errorlevel 2 exit /b 0
docker compose down -v
echo.
echo Reset complete. Run START_LAB.bat to recreate the lab.
pause
