# Use a base image with Java runtime
#FROM openjdk:17-jdk-alpine
FROM bellsoft/liberica-openjre-alpine-musl:17
#Test line
#FROM eclipse-temurin:21-jdk-jammy
 
WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src
RUN  ./mvnw package
EXPOSE 8080
RUN cp -v ./target/spring-petclinic-*.jar /spring-petclinic.jar && ls -l /spring-petclinic.jar
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]

