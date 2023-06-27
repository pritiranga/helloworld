# Stage 1: Build stage
FROM maven:3.8.3-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package

# Stage 2: Final stage
FROM adoptopenjdk:11-jre-hotspot
WORKDIR /app
COPY --from=build /app/target/helloworld-1.1.jar ./app.jar
CMD ["java", "-jar", "app.jar"]
