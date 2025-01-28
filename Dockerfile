FROM openjdk:18-jdk-alpine
WORKDIR /app
COPY ./target/FlowSystem.jar /app/FlowSystem.jar
EXPOSE 9090
ENTRYPOINT ["java", "-jar", "/app/FlowSystem.jar"]