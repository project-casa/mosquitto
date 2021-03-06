@echo off
set DOCKER_CONTAINER=casa-mqtt
set version=

if "%1" == "build" goto build
if "%1" == "publish" goto publish
if "%1" == "start" goto start
if "%1" == "stop" goto stop
if "%1" == "restart" goto stop
if "%1" == "login" goto login
if "%1" == "clean" goto clean
if "%1" == "--" goto exec
goto help

:build
docker-compose build
goto:eof

:publish
if "%version%" == "" set version=%2
if "%version%" == "" set /P version=Enter a version:
if "%version%" == "" goto publish
if not "%version:~,1%" == "v" set version=v%version%

set image=roeldev/casa-mosquitto:%version%
echo You are about to push "%image%" to Docker hub.
set /P continue=Are you sure? [y/n]
if not "%continue%" == "y" goto:eof

docker push %image%
goto:eof

:start
docker-compose up -d
goto:eof

:stop
docker-compose down
if "%1" == "restart" goto start
goto:eof

:login
docker exec -it %DOCKER_CONTAINER% sh
goto:eof

:exec
set ARGS=%*
set ARGS=%ARGS:~3%
docker exec -it %DOCKER_CONTAINER% %ARGS%
goto:eof

:clean
if exist "%~dp0\config\certs" (
    rmdir "%~dp0\config\certs" /s /q
)
if exist "%~dp0\config\passwd" (
    del "%~dp0\config\passwd" /q
)
if exist "%~dp0\data" (
    rmdir "%~dp0\data" /s /q
)
if exist "%~dp0\log" (
    rmdir "%~dp0\log" /s /q
)
goto:eof

:help
echo Usage:
echo   do [action]
echo   do -- [command]
echo.
echo Actions:
echo   build    Build Docker image
echo   publish  Publish Docker image to Docker Hub
echo   start    Start Docker container
echo   stop     Stop Docker container
echo   restart  Restart Docker container
echo   login    Login to Docker container
echo   clean    Clean project; remove generated files and folders
echo   --       Execute the command in the Docker container
echo.
