FROM n8nio/n8n:latest

# Railway asigna el puerto dinámicamente via $PORT
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=${PORT:-5678}
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production

# Configuración de timezone
ENV GENERIC_TIMEZONE=Europe/Madrid
ENV TZ=Europe/Madrid

# Habilitar runners para mejor rendimiento
ENV N8N_RUNNERS_ENABLED=true

# Directorio de datos
ENV N8N_USER_FOLDER=/home/node/.n8n

# Exponer puerto (Railway usa $PORT)
EXPOSE ${PORT:-5678}

# Healthcheck - aumentar tiempo de inicio para n8n
HEALTHCHECK --interval=30s --timeout=30s --start-period=120s --retries=5 \
  CMD wget --spider -q http://localhost:${PORT:-5678}/healthz || exit 1

# Comando de inicio
CMD ["n8n", "start"]
