# Etapa 1: Build
FROM maven:3.9.4-openjdk-21-slim AS build

WORKDIR /app

# Copiar pom.xml y descargar dependencias
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar código y compilar
COPY src ./src
RUN mvn clean package -DskipTests

# Debug en build
RUN echo "=== Build completado ===" && ls -la target/

# Etapa 2: Runtime
FROM openjdk:21-jre-slim

WORKDIR /app

# Copiar JAR desde etapa build
COPY --from=build /app/target/EstuPiso-*.jar app.jar

# Verificar que se copió
RUN ls -la app.jar

EXPOSE 8080

# Variables de entorno
ENV JAVA_OPTS="-Xmx512m -Xms256m"

CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]