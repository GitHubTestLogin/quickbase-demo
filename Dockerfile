FROM openjdk:25-jdk-slim
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} /build/libs/app.jar
ENTRYPOINT ["java","-jar","/app.jar"]