@echo off

if "%~1" == "" goto error
if "%~2" == "" goto error
if "%~3" == "" goto error

docker run ^
  --rm ^
  --network ciberseguridad_sonarnet ^
  -e SONAR_HOST_URL="http://sonarqube:9000" ^
  -e SONAR_LOGIN="%1" ^
  -v "%2:/usr/src" ^
  sonarsource/sonar-scanner-cli ^
  -D sonar.java.binaries=./target/classes/ ^
  -D sonar.projectKey="%3"

exit /b 0

:error
  echo.
  echo Uso:  sonar-scanner-cli-maven.bat TOKEN RUTA_PROYECTO NOMBRE_PROYECTO
  echo.
  exit /b 1
