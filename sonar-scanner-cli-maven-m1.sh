#!/usr/bin/env sh

if [ $# -lt 3 ]; then
  echo ''
  echo 'Uso:  sonar-scanner-cli-m1.sh TOKEN RUTA_PROYECTO NOMBRE_PROYECTO'
  exit 1
fi

docker-compose -f docker-compose.yml -f docker-compose.arm64.yml run \
  --rm \
  -e SONAR_HOST_URL="http://sonarqube:9000" \
  -e SONAR_LOGIN="$1" \
  -v "$2:/usr/src" \
  sonar-scanner-cli \
  -D sonar.java.binaries=./target/classes/ \
  -D sonar.projectKey="$3"
