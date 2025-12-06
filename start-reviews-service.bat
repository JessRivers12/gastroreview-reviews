@echo off
set DATABASE_URL=postgresql://neondb_owner:npg_GduJi8PA2vTb@ep-patient-credit-adceyqvj-pooler.c-2.us-east-1.aws.neon.tech:5432/neondb?sslmode=require
set DATABASE_USERNAME=neondb_owner
set DATABASE_PASSWORD=npg_GduJi8PA2vTb
set PORT=8083
set JWT_SECRET=mySecretKeyForJWTTokenGenerationThatIsAtLeast256BitsLong
set EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=http://localhost:8761/eureka/

echo ================================================
echo Starting Reviews Service on port 8083
echo Using Neon Database
echo Endpoints: http://localhost:8083/graphql
echo           http://localhost:8083/graphiql
echo ================================================
java -jar target\reviews-service-1.0.0.jar
