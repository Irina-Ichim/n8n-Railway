# n8n en Railway

Proyecto para desplegar n8n en Railway.

## Despliegue en Railway

### 1. Crear repositorio en GitHub

```bash
cd n8n-railway
git init
git add .
git commit -m "Initial commit: n8n para Railway"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/n8n-railway.git
git push -u origin main
```

### 2. Configurar en Railway

1. Ve a [railway.app](https://railway.app) e inicia sesión
2. Click en **"New Project"**
3. Selecciona **"Deploy from GitHub repo"**
4. Conecta tu repositorio `n8n-railway`

### 3. Variables de entorno (OBLIGATORIAS)

En Railway, ve a tu servicio > **Variables** y añade:

| Variable | Valor | Descripción |
|----------|-------|-------------|
| `N8N_ENCRYPTION_KEY` | `genera-una-clave-unica-aqui` | Clave para encriptar credenciales |
| `N8N_HOST` | `tu-app.up.railway.app` | Se autoconfigura con el dominio |
| `WEBHOOK_URL` | `https://tu-app.up.railway.app/` | URL para webhooks |
| `N8N_EDITOR_BASE_URL` | `https://tu-app.up.railway.app/` | URL del editor |

#### Generar clave de encriptación

Puedes usar esta para generar una clave segura:
```bash
openssl rand -hex 32
```

O usar un UUID online.

### 4. Base de datos (Opcional pero recomendado)

Para persistencia de datos, añade PostgreSQL:

1. En Railway, click en **"+ New"** > **"Database"** > **"PostgreSQL"**
2. Railway creará automáticamente la variable `DATABASE_URL`
3. Añade esta variable a tu servicio n8n:

| Variable | Valor |
|----------|-------|
| `DB_TYPE` | `postgresdb` |
| `DB_POSTGRESDB_HOST` | `${{Postgres.PGHOST}}` |
| `DB_POSTGRESDB_PORT` | `${{Postgres.PGPORT}}` |
| `DB_POSTGRESDB_DATABASE` | `${{Postgres.PGDATABASE}}` |
| `DB_POSTGRESDB_USER` | `${{Postgres.PGUSER}}` |
| `DB_POSTGRESDB_PASSWORD` | `${{Postgres.PGPASSWORD}}` |

### 5. Dominio personalizado (Opcional)

1. En Railway > Settings > Domains
2. Añade tu dominio personalizado o usa el gratuito `.up.railway.app`

## Variables de entorno completas

```env
# Obligatorias
N8N_ENCRYPTION_KEY=tu-clave-secreta-aqui
N8N_HOST=0.0.0.0
WEBHOOK_URL=https://tu-dominio.up.railway.app/

# Opcionales
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=tu-password-seguro

# Timezone
GENERIC_TIMEZONE=Europe/Madrid
TZ=Europe/Madrid
```

## Migrar workflows desde Docker local

1. En tu n8n local, exporta los workflows (Settings > Export)
2. En n8n de Railway, importa los workflows (Settings > Import)
3. Reconfigura las credenciales (no se exportan por seguridad)

## Costos estimados en Railway

- **Hobby Plan**: $5/mes incluye suficientes recursos para n8n básico
- **Pro Plan**: Para uso intensivo con más ejecuciones

## Troubleshooting

### El servicio no arranca
- Verifica que `N8N_ENCRYPTION_KEY` esté configurada
- Revisa los logs en Railway

### Webhooks no funcionan
- Asegúrate de que `WEBHOOK_URL` tenga el dominio correcto con `https://`

### Credenciales no se guardan
- Necesitas PostgreSQL para persistencia
- Sin BD, los datos se pierden en cada redeploy
