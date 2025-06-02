# filepath: Backend - SpringBoot/Dockerfile
FROM openjdk:21-jdk-slim

RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src

# Forzar la creación del JAR ejecutable
RUN mvn clean package -DskipTests spring-boot:repackage

# Debug: mostrar todo lo que se generó
RUN echo "=== Contenido completo de target/ ===" && \
    find target -type f -name "*.jar" && \
    echo "=== Archivos JAR encontrados ===" && \
    ls -la target/*.jar 2>/dev/null || echo "No hay JARs en la raíz de target/"

# Buscar específicamente el JAR ejecutable en la raíz de target/
RUN JAR_FILE=$(find target -maxdepth 1 -name "*.jar" -type f | head -1) && \
    if [ -z "$JAR_FILE" ]; then \
        echo "ERROR: No se encontró JAR ejecutable" && exit 1; \
    else \
        cp "$JAR_FILE" app.jar && \
        echo "JAR ejecutable encontrado: $JAR_FILE"; \
    fi

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]