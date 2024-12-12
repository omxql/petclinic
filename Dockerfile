# Use a base image with Java runtime
#FROM openjdk:17-jdk-alpine
#FROM bellsoft/liberica-openjre-alpine-musl:17

FROM eclipse-temurin:21-jdk-jammy
 
WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src
RUN  ./mvnw package
EXPOSE 8080
COPY ./target/spring-petclinic-*.jar /spring-petclinic.jar
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]

