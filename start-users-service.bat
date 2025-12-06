@echo off
set DATABASE_URL=jdbc:postgresql://neondb_owner:npg_GduJi8PA2vTb@ep-patient-credit-adceyqvj-pooler.c-2.us-east-1.aws.neon.tech:5432/neondb?sslmode=require
set DATABASE_USERNAME=neondb_owner
set DATABASE_PASSWORD=npg_GduJi8PA2vTb
set JWT_SECRET=mySecretKeyForJWTTokenGenerationThatIsAtLeast256BitsLong

echo ====================================
echo Starting Users Service on port 8081
echo Using Neon Database
echo ====================================
java -jar users-service\target\users-service-1.0.0.jar
