# Use an official lightweight OpenJDK runtime as a base image
FROM openjdk:25-jdk-slim
# Set the working directory inside the container
WORKDIR /app
ARG JAR_FILE=build/libs/demo-0.0.1-SNAPSHOT.jar
# Copy the built JAR into the container
COPY ${JAR_FILE} app.jar
# Command to run the application
ENTRYPOINT ["java","-jar","app.jar"]