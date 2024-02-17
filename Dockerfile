FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install maven -y
RUN mvn clean install 

FROM openjdk:17-jdk-slim

EXPOSE 8080
WORKDIR /app
COPY --from=build /target/spring-angular-0.0.1-SNAPSHOT.jar /app/app.jar

ENTRYPOINT [ "java", "-jar", "/app/app.jar" ]