@echo off
title ARADHINA FONCIER - DEPLOY
cd /d "%~dp0"

echo.
echo ===== ARADHINA FONCIER - NETLIFY DEPLOY =====
echo Working folder: %CD%
echo.

ver
where node >nul 2>nul
if errorlevel 1 goto NONODE

echo Node version:
node -v
echo.
echo NOTE: This project (Next.js 16) needs Node.js 20.9 or newer.
echo Node 20+ does NOT run on Windows 7 / 8. Use Windows 10/11 or a cloud build.
echo.

if not exist package.json goto NOPKG

echo [1/4] Installing packages...
call npm install
if errorlevel 1 goto FAIL

echo.
echo [2/4] Building the site...
call npm run build
if errorlevel 1 goto FAIL

echo.
echo [3/4] Netlify login...
call npx netlify-cli login

echo.
echo [4/4] Publishing to Netlify...
call npx netlify-cli deploy --dir=out --functions=netlify/functions --prod --no-build --site aradhina-foncier
if errorlevel 1 goto FAIL

echo.
echo ===== DONE =====
echo Open: https://aradhina-foncier.netlify.app
goto END

:NONODE
echo ERROR: Node.js is not installed or not working on this computer.
echo Install Node.js 20 LTS or newer from https://nodejs.org (Windows 10/11 required).
goto END

:NOPKG
echo ERROR: package.json not found. Put this file next to package.json.
goto END

:FAIL
echo.
echo ERROR: A step failed. Read the messages above.

:END
echo.
pause
