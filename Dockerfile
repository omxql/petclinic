# Use a base image with Java runtime
#FROM openjdk:17-jdk-alpine
FROM eclipse-temurin:21-jdk-jammy

WORKDIR /app

#For Host machine build, run the following commands to perform maven build
#If you are using jre base image for final image output, its recommended to perform maven build on Host machine with JDK installed
#./mvnw clean package -DskipTests
#cp -v ./target/spring-petclinic-*.jar spring-petclinic.jar
#java -Djava.security.egd=file:/dev/./urandom -jar spring-petclinic.jar

# Copy the necessary files for building the application
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
COPY src ./src

# Create the mvn.sh script
#Note: The here-doc (<<EOF) block evaluates backtick while creating the file itself.
#Hence avoid evaluation while creating, but keep literals as is with here-doc (<<'EOF')
RUN cat > mvn.sh <<'EOF'
export USR=`id -un`
echo "Container is running as user ${USR}"
echo "Maven cache directory is ..."
echo -en "/root/.m2/repository"
#During runtime fetches the maven cache directory
#./mvnw help:evaluate -Dexpression=settings.localRepository -q -DforceStdout
echo -e "\nStarting build process"
./mvnw clean package -DskipTests
cp -v ./target/spring-petclinic-*.jar spring-petclinic.jar
echo $PWD/spring-petclinic.jar
rm -rf .mvn/ src/ target/ mvnw pom.xml
echo "Build process completed successfully"
EOF
#RUN echo "Content of mvn.sh" && cat mvn.sh

# Run the build process with Maven, using a cache mount for the maven repository
RUN --mount=type=cache,target=/root/.m2/repository bash mvn.sh

#ARG CACHEBUST=001
RUN echo "Arg CACHEBUST effects change in the imageSha. CACHEBUST=$CACHEBUST"

#RUN sleep infinity
#RUN exit 

# Expose the port for the application
EXPOSE 8080

# Command to run the application
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "spring-petclinic.jar"]
