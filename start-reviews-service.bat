@echo off
setlocal enabledelayedexpansion

echo ================================================
echo Starting Reviews Service on port 8083
echo Using Neon Database
echo Endpoints: http://localhost:8083/graphql
echo           http://localhost:8083/graphiql
echo ================================================

REM Set environment variables
set "SPRING_DATASOURCE_URL=jdbc:postgresql://ep-patient-credit-adceyqvj-pooler.c-2.us-east-1.aws.neon.tech:5432/neondb?sslmode=require"
set "SPRING_DATASOURCE_USERNAME=neondb_owner"
set "SPRING_DATASOURCE_PASSWORD=npg_GduJi8PA2vTb"
set "PORT=8083"
set "JWT_SECRET=mySecretKeyForJWTTokenGenerationThatIsAtLeast256BitsLong"
set "EUREKA_CLIENT_ENABLED=false"

java -jar target\reviews-service-1.0.0.jar %*
