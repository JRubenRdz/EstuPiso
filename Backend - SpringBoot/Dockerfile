# Usar imagen base de OpenJDK 21 (matching tu pom.xml)
FROM openjdk:21-jdk-slim

# Instalar Maven
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de configuración Maven primero (para cache de dependencias)
COPY pom.xml .

# Descargar dependencias (se cachea si pom.xml no cambia)
RUN mvn dependency:go-offline -B

# Copiar código fuente
COPY src ./src

# Construir la aplicación
RUN mvn clean package -DskipTests

# Exponer el puerto 8080
EXPOSE 8080

# Ejecutar la aplicación (el nombre del JAR coincide con tu artifactId)
CMD ["java", "-jar", "target/EstuPiso-0.0.1-SNAPSHOT.jar"]