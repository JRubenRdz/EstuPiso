FROM openjdk:21-jdk-slim

RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src

# Limpiar y construir con spring-boot específico
RUN mvn clean compile spring-boot:repackage -DskipTests

# Verificar estructura
RUN echo "=== Verificando estructura ===" && \
    ls -la target/ && \
    echo "=== Buscando JARs ===" && \
    find target -name "*.jar" -type f

# El JAR debería estar en target/ directamente
COPY target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]