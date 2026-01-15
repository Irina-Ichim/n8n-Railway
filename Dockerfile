FROM n8nio/n8n:latest

# Configuración básica
ENV N8N_HOST=0.0.0.0
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production

# Configuración de timezone
ENV GENERIC_TIMEZONE=Europe/Madrid
ENV TZ=Europe/Madrid

# Habilitar runners para mejor rendimiento
ENV N8N_RUNNERS_ENABLED=true

# Directorio de datos
ENV N8N_USER_FOLDER=/home/node/.n8n

# Exponer puerto por defecto
EXPOSE 5678

# Script de inicio - Railway pasa PORT como variable de entorno
ENV PORT=5678
CMD ["sh", "-c", "n8n start --port=$PORT"]
