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

# Set default environment variables
ENV PORT=10000
ENV SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/reviews
ENV SPRING_DATASOURCE_USERNAME=postgres
ENV SPRING_DATASOURCE_PASSWORD=postgres
ENV JWT_SECRET=mySecretKeyForJWTTokenGenerationThatIsAtLeast256BitsLong

CMD ["java", "-jar", "app.jar", "--server.port=${PORT}"]
