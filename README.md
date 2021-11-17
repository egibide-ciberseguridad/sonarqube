# Ciberseguridad

## Herramientas

- [SonarQube](https://docs.sonarqube.org/latest/setup/get-started-2-minutes/)
- [Damn Vulnerable Web Application](http://www.dvwa.co.uk)
- [OWASP Dependency-Check](https://owasp.org/www-project-dependency-check/)

## SonarQube

Arrancar el servicio con `docker-compose up -d` y acceder al [sitio web](http://localhost:9000).

Usuario `admin/admin`.

## SonarScanner

Lanzar SonarScanner con [Docker](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/).

```bash
docker run \
    --rm \
    --link sonarqube --network ciberseguridad_sonarnet \
    -e SONAR_HOST_URL="http://sonarqube:9000" \
    -e SONAR_LOGIN="c90cff9a40c4284a2dca7021860ff991f3bd526c" \
    -v "$(pwd):/usr/src" \
    sonarsource/sonar-scanner-cli \
    -Dsonar.projectKey=proyecto
```

## OWASP Dependency-Check

```bash
owasp-dependency.sh
```

El informe se genera en `odc-reports/dependency-check-report.html`.

## Análisis de un APK

- Renombrar a .zip y descomprimir.
- Convertir de dex a jar con dex2jar.

    ```bash
    brew install dex2jar
    d2j-dex2jar classes.dex
    ```

- Abrir el jar con [JD_GUI](http://java-decompiler.github.io).
- Descomprimir el jar para conseguir los .class.
- Fusionar las dos carpetas para tener los .class y los .java juntos.

    ```bash
    docker run -ti -v $(pwd):/usr/src --link sonarqube --network ciberseguridad_sonarnet newtmitch/sonar-scanner:alpine \
      -Dsonar.java.binaries=/usr/src \
      -Dsonar.projectKey=MyProjectKey \
      -Dsonar.projectName="My Project Name" \
      -Dsonar.projectVersion=1
    ```
  
- Referencia: [Descompilar aplicaciones Android](https://medium.com/@alvareztech/descompilar-aplicaciones-android-8e7519732f23)

## Analizar código Kotlin

```bash
docker run -ti -v $(pwd):/usr/src --link sonarqube --network ciberseguridad_sonarnet newtmitch/sonar-scanner:alpine \
  -Dsonar.exclusions='**/*.java' \
  -Dsonar.projectKey=MyProjectKey \
  -Dsonar.projectName="My Project Name" \
  -Dsonar.projectVersion=1
```

## Integración con IntelliJ

[SonarQube IntelliJ Community Plugin](https://github.com/sonar-intellij-plugin/sonar-intellij-plugin)
