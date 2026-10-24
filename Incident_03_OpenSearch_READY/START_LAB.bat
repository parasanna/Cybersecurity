@echo off
setlocal
cd /d "%~dp0"
where docker >nul 2>&1
if errorlevel 1 (
  echo.
  echo Docker Desktop is not installed or docker.exe is not in PATH.
  echo Install Docker Desktop once, start it, and run START_LAB.bat again.
  pause
  exit /b 1
)

docker info >nul 2>&1
if errorlevel 1 (
  echo.
  echo Docker Desktop is installed but is not running.
  echo Start Docker Desktop and wait until it reports that the engine is running.
  pause
  exit /b 1
)

echo.
echo Starting the Cyber Incident OpenSearch lab...
echo The FIRST run downloads the OpenSearch images and can take several minutes.
docker compose up -d
if errorlevel 1 (
  echo.
  echo Docker Compose could not start the lab. See the message above.
  pause
  exit /b 1
)

echo.
echo Waiting for OpenSearch Dashboards to become ready...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$deadline=(Get-Date).AddMinutes(12); $ok=$false; do { Start-Sleep -Seconds 4; try { $r=Invoke-WebRequest -UseBasicParsing -Uri 'http://localhost:5601/api/status' -TimeoutSec 3; if ($r.StatusCode -eq 200) {$ok=$true} } catch {} } while (-not $ok -and (Get-Date) -lt $deadline); if ($ok) { Start-Sleep -Seconds 8; Start-Process 'http://localhost:5601/app/discover'; exit 0 } else { exit 1 }"
if errorlevel 1 (
  echo.
  echo Dashboards is still starting. Wait 1-2 minutes and open:
  echo http://localhost:5601/app/discover
  pause
  exit /b 0
)

echo.
echo Lab is ready. Your browser should open automatically.
echo If no data appear, follow README_FIRST.txt and set the incident time range.
pause
