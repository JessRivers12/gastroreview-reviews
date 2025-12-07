# Build stage
FROM maven:3.9.5-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests -q

# Run stage
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/reviews-service-1.0.0.jar app.jar
EXPOSE 10000

ENTRYPOINT ["java", "-jar", "app.jar"]
CMD ["--server.port=10000", \
     "--spring.datasource.url=${SPRING_DATASOURCE_URL:-jdbc:postgresql://localhost:5432/reviews}", \
     "--spring.datasource.username=${SPRING_DATASOURCE_USERNAME:-postgres}", \
     "--spring.datasource.password=${SPRING_DATASOURCE_PASSWORD:-postgres}"]
