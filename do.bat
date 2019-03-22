@echo off
set DOCKER_CONTAINER=casa-mqtt

if "%1" == "build" goto build
if "%1" == "start" goto start
if "%1" == "stop" goto stop
if "%1" == "restart" goto stop
if "%1" == "login" goto login
if "%1" == "--" goto exec
goto help

:build
docker-compose build
goto end

:start
docker-compose up -d
goto end

:stop
docker-compose down
if "%1" == "restart" goto start
goto end

:login
docker exec -it %DOCKER_CONTAINER% sh
goto end

:exec
set ARGS=%*
set ARGS=%ARGS:~3%
docker exec -it %DOCKER_CONTAINER% %ARGS%
goto end

:help
echo Usage:
echo   do [action]
echo   do -- [command]
echo.
echo Actions:
echo   build    Build Docker image
echo   start    Start Docker container
echo   stop     Stop Docker container
echo   restart  Restart Docker container
echo   --       Execute the command in the Docker container
echo.
goto end

:end
