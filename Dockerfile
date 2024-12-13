# Use a base image with Java runtime
#FROM openjdk:17-jdk-alpine
#FROM eclipse-temurin:21-jdk-jammy
FROM bellsoft/liberica-openjre-alpine-musl:17

WORKDIR /app

#Following are the build commands, to be executed on the Host machine - if you are using jre base image
# Ensure clean workspace
#./mvnw clean package -DskipTests
##cp -v ./target/spring-petclinic-*.jar ./target/spring-petclinic.jar
##java -Djava.security.egd=file:/dev/./urandom -jar ./target/spring-petclinic.jar

COPY  ./target/spring-petclinic.jar  /spring-petclinic.jar
EXPOSE 8080
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/spring-petclinic.jar"]