# Build stage
FROM maven:3.9.5-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .
COPY src ./src
RUN mvn clean package -DskipTests -q

# Run stage
FROM eclipse-temurin:21-jre-slim
WORKDIR /app
COPY --from=build /app/target/reviews-service-1.0.0.jar app.jar
EXPOSE ${PORT:-8083}
ENV SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
ENV SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
ENV SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
ENV JWT_SECRET=${JWT_SECRET}
ENV PORT=${PORT:-8083}
CMD ["java", "-jar", "app.jar"]
