# Builder Stage: Gradle 빌드 환경 (JDK 17)
FROM gradle:7.6.1-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle clean build -x test

# Runner Stage: 실행 환경 (JRE 17)
FROM openjdk:17-jre-slim
WORKDIR /app
EXPOSE 8080
COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]