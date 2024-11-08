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
COPY --from=build /app/src/main/resources/codefact.p12 ./
# Exponer el puerto
EXPOSE 8003
# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]