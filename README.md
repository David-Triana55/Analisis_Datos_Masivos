# Análisis de Datos Masivos — Online Retail II

Proyecto final de la materia **Análisis de Datos Masivos** (Uniagustiniana).
Pipeline de Big Data sobre el dataset Online Retail II usando Apache Hadoop,
Apache Spark, PostgreSQL y Grafana, orquestado con Docker Compose.

## Requisitos

- Docker Desktop 4.x o superior (con Docker Compose v2)
- 8 GB de RAM disponibles

## Cómo ejecutar

### 1. Iniciar el stack

```bash
docker compose up -d
```

El primer arranque descarga las imágenes y puede tardar varios minutos.
Verificar que todos los servicios estén activos con:

```bash
docker compose ps
```

### 2. Subir el dataset a HDFS y ejecutar el notebook

Abrir Jupyter en http://localhost:8888 (el token aparece en
`docker compose logs jupyter`). Abrir `notebooks/etl_retail.ipynb`
y ejecutar las celdas en orden. El notebook lee el CSV desde HDFS,
genera cinco tablas de agregación y las escribe en PostgreSQL.

### 3. Ver el dashboard

Abrir Grafana en http://localhost:3000 con credenciales `admin / admin123`.

## Detener los contenedores

```bash
docker compose down
```

Los volúmenes de datos se conservan. Para eliminarlos también:

```bash
docker compose down -v
```

## Estructura del repositorio


├── README.md
├── docker-compose.yaml
├── consultas/
│   ├── estacionalidad_mensual.sql
│   ├── top_productos.sql
│   ├── ventas_por_dia_semana.sql
│   ├── ventas_por_pais.sql
│   └── ventas_por_precio.sql
├── dashboard/
│   └── top-10-paises-por-revenue.json
├── notebooks/
│   └── etl_retail.ipynb
├── resultados/
│   ├── top_productos.csv
│   ├── ventas_por_dia_semana.csv
│   ├── ventas_por_mes.csv
│   ├── ventas_por_pais.csv
│   └── ventas_por_precio.csv
└── data/
    ├── online_retail.csv

