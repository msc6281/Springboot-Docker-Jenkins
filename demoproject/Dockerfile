#===== Stage 1 Build the application ===#
FROM maven:3.9.16-eclipse-temurin-17 AS build

WORKDIR /build

#copy pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

#copy the source code
COPY src ./src

#package the application
RUN mvn clean package -DskipTests

#==== Stage 2 Run the applicaion ===#
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

#copy the build jar from the build stage
COPY --from=build /build/src/target/demoproject-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar", "app.jar"]
