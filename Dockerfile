FROM maven:3.8.6 AS build
WORKDIR /app
COPY pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests -f ./pom.xml

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8003

# Configuración por defecto
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://aws-0-us-west-1.pooler.supabase.com:6543/postgres?user=postgres.gbxuojquibukppijatpv&password=0PdVadsLIfzGJ32r&sslmode=require
ENV SPRING_JPA_DATABASE_PLATFORM=org.hibernate.dialect.PostgreSQLDialect
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=update
ENV SPRING_JPA_SHOW_SQL=true

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", \
            "-Dspring.datasource.url=${SPRING_DATASOURCE_URL}", \
            "-Dspring.jpa.database-platform=${SPRING_JPA_DATABASE_PLATFORM}", \
            "-Dspring.jpa.hibernate.ddl-auto=${SPRING_JPA_HIBERNATE_DDL_AUTO}", \
            "-Dspring.jpa.show-sql=${SPRING_JPA_SHOW_SQL}", \
            "-jar", "app.jar"]