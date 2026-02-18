# MAGI Predictive Core

Sistema predictivo de sync_rate para pilotos de Evangelion, desarrollado por Melanie Peña

## Requisitos
- Python 
- En mi caso, utilice MariaDB para almacenar y manejar los datos

## Instalación

```bash
pip install -r requirements.txt
```

Se adjunta un `.env.example` que debe contener las credenciales de conexión la base de datos donde se generaron los datos sintéticos.
Renombrar este documento de ejemplo a `.env` y completar con las credenciales de MariaDB.

## Ejecución

```bash
# 1. Crear las tablas en DataGrip
sql/schema.sql

# 2. Generar datos sintéticos
python data/generate_data.py

# En caso de que no se quieran generar datos nuevos, se adjunta el dump de la base de datos con los datos utilizados para realizar la prueba técnica

# 3. Correr el notebook de ML
jupyter notebook notebooks/magi_ml.ipynb
```

Las queries SQL están en `sql/queries.sql` para ejecutar en DataGrip.  
Los outputs del modelo (gráficas y checkpoint) se guardan automáticamente en `outputs/`.

## Stack
- **Base de datos:** MariaDB
- **ML:** PyTorch, scikit-learn
- **Análisis:** pandas, matplotlib