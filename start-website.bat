@echo off
setlocal

cd /d "%~dp0"

echo Starting the site at http://localhost:8080 ...
start "" "http://localhost:8080"
bundle exec jekyll serve --livereload --host 127.0.0.1 --port 8080
if errorlevel 1 goto :error

goto :eof

:error
echo.
echo The site could not be started. Make sure Ruby and Bundler are installed, then run this file again.
pause
