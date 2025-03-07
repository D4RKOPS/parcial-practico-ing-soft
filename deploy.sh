#!/bin/bash


if ! command -v docker &> /dev/null; then
    echo "Docker no está instalado. Por favor, instálalo antes de continuar."
    exit 1
fi
echo "Construyendo la imagen de Docker..."
docker build -t devops-evaluation-app .
if [ $? -ne 0 ]; then
    echo "Error al construir la imagen."
    exit 1
fi

echo "Eliminando contenedores anteriores..."
docker stop devops-container 2>/dev/null && docker rm devops-container 2>/dev/null


echo "Ejecutando el contenedor..."
docker run -d -p 8080:8080 --name devops-container -e PORT=8080 -e NODE_ENV=production devops-evaluation-app


sleep 5


echo "Verificando la aplicación..."
if curl -s http://localhost:8080/health | grep "OK"; then
    echo "La aplicación está funcionando correctamente."
else
    echo "Error: La aplicación no responde correctamente."
    exit 1
fi

echo "Despliegue exitoso."
exit 0
