FROM maven:3-eclipse-temurin-17-focal

WORKDIR /usr/src/app

COPY pom.xml /usr/src/app
COPY ./src/test/java /usr/src/app/src/test/java

CMD mvn test




# Download and cache dependencies to improve build performance
# RUN mvn dependency:resolve

# Copy the source code (tests) into the container
# COPY ./src/test/java /usr/src/app/src/test/java

# Default command to run the tests
# CMD ["mvn", "test"]
