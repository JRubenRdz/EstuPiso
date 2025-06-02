FROM openjdk:21-jdk-slim

RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# Buscar el JAR generado y copiarlo como app.jar
RUN JAR_FILE=$(find target -name "*.jar" -not -name "*sources*" -not -name "*javadoc*" | head -1) && \
    cp "$JAR_FILE" app.jar && \
    echo "JAR encontrado: $JAR_FILE"

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]