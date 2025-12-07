# Desplegar Reviews Service en Render (Gratis)

## Pasos para desplegar en Render

### 1. Conecta tu repositorio GitHub a Render
- Ve a https://dashboard.render.com
- Click en **New +** → **Web Service**
- Selecciona **Deploy an existing repository**
- Conecta tu cuenta de GitHub y selecciona el repositorio `gastroreview-reviews`

### 2. Configura el Web Service
- **Name**: `reviews-service`
- **Runtime**: Java
- **Build Command**: `mvn clean package -DskipTests`
- **Start Command**: `java -jar target/reviews-service-1.0.0.jar`
- **Plan**: Free (sin costo)

### 3. Agrega Variables de Entorno
En la sección **Environment**, agrega:

```
SPRING_DATASOURCE_URL=jdbc:postgresql://ep-patient-credit-adceyqvj-pooler.c-2.us-east-1.aws.neon.tech:5432/neondb?sslmode=require
SPRING_DATASOURCE_USERNAME=neondb_owner
SPRING_DATASOURCE_PASSWORD=npg_GduJi8PA2vTb
PORT=8083
JWT_SECRET=mySecretKeyForJWTTokenGenerationThatIsAtLeast256BitsLong
EUREKA_CLIENT_ENABLED=false
```

### 4. Deploy
- Click en **Create Web Service**
- Render compilará e iniciará automáticamente tu aplicación
- Verás la URL de tu servicio en pocos minutos

### 5. Accede a tu servicio
Una vez desplegado:
- **GraphQL API**: `https://tu-servicio.onrender.com/graphql`
- **GraphQL UI**: `https://tu-servicio.onrender.com/graphiql`

## Notas Importantes

- ⚠️ **No cambies las credenciales de Neon** en Render. Usa exactamente las mismas que aparecen arriba.
- 🔄 **Los deploys gratuitos duermen después de 15 minutos de inactividad**. El primer request los despierta (tarda ~30 segundos).
- 📊 **La tabla `reviews` ya existe en Neon** y el servicio la usa automáticamente.
- 🔐 **Las variables están en el archivo `render.yaml`** si quieres copiarlas directamente.

## Solución de problemas

Si ves errores en el deploy:

1. **Error de compilación**: Verifica que el `pom.xml` esté correcto
2. **Error de conexión a BD**: Confirma que las credenciales de Neon sean exactas
3. **Puerto no disponible**: Render asigna el puerto automáticamente (ignora el 8083)

## Próximos pasos

Una vez desplegado, puedes:
- Usar el endpoint GraphQL desde tu frontend
- Consultar reviews de la tabla en Neon
- Ver análisis de sentimientos en tiempo real
