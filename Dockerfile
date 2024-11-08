FROM maven:3.8.6 AS build
# Establecer el directorio de trabajo
WORKDIR /app
# Copiar el archivo pom.xml
COPY pom.xml ./pom.xml
# Copiar el código fuente
COPY src ./src
# Construir el JAR
RUN mvn clean package -DskipTests -f ./pom.xml

# Etapa de ejecución
FROM openjdk:17-jdk-slim
# Establecer el directorio de trabajo
WORKDIR /app
# Copiar el archivo JAR desde la etapa de construcción
COPY --from=build /app/target/*.jar app.jar
# Exponer el puerto
EXPOSE 8003

# Configurar las variables de entorno por defecto
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:6543/postgres?sslmode=require
ENV SPRING_DATASOURCE_USERNAME=postgres.gbxuojquibukppijatpv
ENV SPRING_DATASOURCE_PASSWORD=0PdVadsLIfzGJ32r
ENV SPRING_JPA_DATABASE_PLATFORM=org.hibernate.dialect.PostgreSQLDialect
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=update
ENV SPRING_JPA_SHOW_SQL=true
ENV SERVER_PORT=8003

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", \
            "-jar", \
            "app.jar", \
            "--spring.datasource.url=${SPRING_DATASOURCE_URL}", \
            "--spring.datasource.username=${SPRING_DATASOURCE_USERNAME}", \
            "--spring.datasource.password=${SPRING_DATASOURCE_PASSWORD}", \
            "--spring.jpa.database-platform=${SPRING_JPA_DATABASE_PLATFORM}", \
            "--spring.jpa.hibernate.ddl-auto=${SPRING_JPA_HIBERNATE_DDL_AUTO}", \
            "--spring.jpa.show-sql=${SPRING_JPA_SHOW_SQL}", \
            "--server.port=${SERVER_PORT}"]