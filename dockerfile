# Etapa 1: Construcción
FROM node:18 AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios para instalar dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install --only=production

# Copia el resto de los archivos de la aplicación
COPY . .

# Construye la aplicación (si es necesario, en caso de usar TypeScript, por ejemplo)
# RUN npm run build (Descomentar si es necesario)

# Etapa 2: Ejecución
FROM node:18-alpine AS runner

# Establece el directorio de trabajo
WORKDIR /app

# Copia las dependencias instaladas desde la etapa de construcción
COPY --from=builder /app/node_modules ./node_modules

# Copia el código fuente de la aplicación
COPY --from=builder /app .

# Exponemos el puerto 3000
EXPOSE 3000

# Comando para ejecutar la API
CMD ["node", "index.js"]

#HOLAAA