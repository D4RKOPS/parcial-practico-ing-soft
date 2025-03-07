# Usa una imagen base de Node.js
FROM node:18-alpine

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY package.json ./
RUN npm install

# Copia el resto de los archivos de la aplicación
COPY . .

# Expone el puerto de la aplicación
EXPOSE 8080

# Define la variable de entorno por defecto
ENV NODE_ENV=production

# Comando para ejecutar la aplicación
CMD ["node", "app.js"]
