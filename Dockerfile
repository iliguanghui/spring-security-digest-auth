FROM maven:3-eclipse-temurin-17 AS builder
COPY settings.xml /usr/share/maven/conf/settings.xml
WORKDIR /src
COPY pom.xml ./
RUN mvn dependency:go-offline -B
COPY ./src ./src
RUN mvn package -Dmaven.test.skip=true
FROM eclipse-temurin:17.0.10_7-jre-alpine as runner
WORKDIR /app
COPY --from=builder /src/target/*.jar ./app.jar
EXPOSE 8080/tcp
ENTRYPOINT ["/bin/sh", "-c", "exec java -jar app.jar"]