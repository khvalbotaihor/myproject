FROM maven:3-eclipse-temurin-17-focal

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app
COPY ./src/test/java /usr/src/app/src/test/java

CMD mvn test
