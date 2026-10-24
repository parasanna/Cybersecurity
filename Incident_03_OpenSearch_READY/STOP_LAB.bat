@echo off
cd /d "%~dp0"
docker compose down
echo.
echo Lab stopped. Your data volume is preserved.
pause
