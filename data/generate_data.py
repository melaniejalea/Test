import random
from datetime import datetime, timedelta
import pymysql
import os
from dotenv import load_dotenv

# Variables del entorno
load_dotenv()

DB_CONFIG = {
    "host":     os.getenv("DB_HOST", "localhost"),
    "port":     int(os.getenv("DB_PORT")),
    "user":     os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "database": os.getenv("DB_NAME"),
}

# Reproducibilidad
random.seed(42)


# UNIDADES EVAs
EVA_UNITS = [
    {"unit_id": "EVA-00", "designation": "Unit-00 Prototype",       "status": "operational"},
    {"unit_id": "EVA-01", "designation": "Unit-01 Test Type",       "status": "operational"},
    {"unit_id": "EVA-02", "designation": "Unit-02 Production Type", "status": "operational"},
    {"unit_id": "EVA-03", "designation": "Unit-03 Experimental",    "status": "maintenance"},
    {"unit_id": "EVA-04", "designation": "Unit-04 Mass Production", "status": "destroyed"},
    {"unit_id": "EVA-05", "designation": "Unit-05 Advanced Type",   "status": "operational"},
]

# PILOTOS
# Se asume que un piloto podía haber tenido un EVA antes de ser suspendido o inactivo
PILOTS = [
    {"pilot_id": "PILOT-001", "name": "Carlos Muñoz",     "age": 17, "status": "active",    "assigned_unit": "EVA-01", "recruitment_date": "2025-03-01"},
    {"pilot_id": "PILOT-002", "name": "Valentina Peña",   "age": 20, "status": "active",    "assigned_unit": "EVA-00", "recruitment_date": "2025-03-15"},
    {"pilot_id": "PILOT-003", "name": "Diego Fernández",  "age": 18, "status": "active",    "assigned_unit": "EVA-02", "recruitment_date": "2025-04-01"},
    {"pilot_id": "PILOT-004", "name": "Sofía Herrera",    "age": 17, "status": "inactive",  "assigned_unit": "EVA-03", "recruitment_date": "2025-05-10"},
    {"pilot_id": "PILOT-005", "name": "Matías Contreras", "age": 19, "status": "suspended", "assigned_unit": "EVA-04", "recruitment_date": "2025-06-01"},
    {"pilot_id": "PILOT-006", "name": "Camila Torres",    "age": 16, "status": "active",    "assigned_unit": "EVA-05", "recruitment_date": "2025-04-20"},
    {"pilot_id": "PILOT-007", "name": "Tomás Vargas",     "age": 32, "status": "inactive",  "assigned_unit": "EVA-03", "recruitment_date": "2025-07-01"},
    {"pilot_id": "PILOT-008", "name": "Isidora Pizarro",  "age": 17, "status": "active",    "assigned_unit": "EVA-01", "recruitment_date": "2025-02-01"},
]

# Fechas de inicio y fin del período de sesiones (12 meses)
START_D = datetime(2025, 3, 1)
END_D   = datetime(2026, 3, 1)
TOTAL_D = (END_D - START_D).days

########################################################################
# REGISTRO DE SESIONES
########################################################################
def generate_sessions():
    sessions = []

    # Cantidad de sesiones por estado del piloto para desginar su status
    sessions_per_status = {
        "active":    40,
        "inactive":  10,
        "suspended": 5,
    }

    for pilot in PILOTS:

        # Los inactivos/suspendidos solo tienen sesiones hasta cierto punto del año
        if pilot["status"] == "suspended":
            cutoff = START_D + timedelta(days=int(TOTAL_D * 0.25))
        elif pilot["status"] == "inactive":
            cutoff = START_D + timedelta(days=int(TOTAL_D * 0.60))
        else:
            cutoff = END_D

        n_sessions       = sessions_per_status[pilot["status"]]
        dias_disponibles = (cutoff - START_D).days

        # Nos aseguramos de tener más días disponibles que sesiones a generar
        if dias_disponibles < n_sessions:
            dias_disponibles = n_sessions

        # Elegimos n_sessions números aleatorios dentro del rango (sin repetir)
        # y los ordenamos para que las sesiones queden en orden cronológico
        dias_elegidos = sorted(random.sample(range(dias_disponibles), n_sessions))

        # Convertimos esos números de día en fechas reales
        session_dates = [START_D + timedelta(days=d) for d in dias_elegidos]

        for session_date in session_dates:

            # El piloto usa su unidad asignada el 80% del tiempo
            # El 20% restante usa otra unidad (sesiones cruzadas o préstamos)
            if random.random() < 0.80:
                unit_id = pilot["assigned_unit"]
            else:
                otras_unidades = [u["unit_id"] for u in EVA_UNITS if u["unit_id"] != pilot["assigned_unit"]]
                unit_id = random.choice(otras_unidades)

            # Sync rate entre 0 y 100 (según lo definido en el esquema)
            # Si cae bajo 15, la sesión fue problemática (~10-15% del total)
            sync_rate = round(random.uniform(0, 100), 2)

            if sync_rate < 15:
                session_status = random.choice(["aborted", "critical"])
            else:
                session_status = "completed"

            # Contaminación mental alta si la sesión fue problemática
            if session_status in ("aborted", "critical"):
                mental_contamination = round(random.uniform(50, 90), 2)
            else:
                mental_contamination = round(random.uniform(0, 40), 2)

            sessions.append({
                "pilot_id":             pilot["pilot_id"],
                "unit_id":              unit_id,
                "sync_rate":            sync_rate,
                "session_date":         session_date + timedelta(
                                            hours=random.randint(6, 21),
                                            minutes=random.randint(0, 59)),
                "duration_min":         random.randint(15, 120),
                "mental_contamination": mental_contamination,
                "status":               session_status,
            })

    return sessions

########################################################################
# REGISTRO mÉDICO
########################################################################
def generate_medical(sessions: list):
    records = []

    for session in sessions:
        # El 15% de las sesiones no tiene registro médico
        if random.random() > 0.85:
            continue

        if session["status"] == "critical":
            heart_rate    = random.randint(120, 170)
            neural_stress = round(random.uniform(65, 100), 2)
            recovery_hrs  = round(random.uniform(18, 48), 2)
            notes         = "Caso crítico! Reposo obligatorio."
        elif session["status"] == "aborted":
            heart_rate    = random.randint(100, 130)
            neural_stress = round(random.uniform(40, 70), 2)
            recovery_hrs  = round(random.uniform(8, 18), 2)
            notes         = "Sesión interrumpida."
        else:  # no sucedió nada
            heart_rate    = random.randint(65, 100)
            neural_stress = round(random.uniform(5, 40), 2)
            recovery_hrs  = round(random.uniform(2, 8), 2)
            notes         = "Sin complicaciones"

        records.append({
            "pilot_id":       session["pilot_id"],
            "session_id":     session["session_id"],
            "heart_rate_avg": heart_rate,
            "neural_stress":  neural_stress,
            "recovery_hours": recovery_hrs,
            "notes":          notes,
            "record_date":    session["session_date"],
        })

    return records

########################################################################
# INSERCIONES
########################################################################
def insert():
    conn = pymysql.connect(**DB_CONFIG)
    cur  = conn.cursor()

    try:
        # Insertamos las unidades EVA
        for unit in EVA_UNITS:
            cur.execute(
                "INSERT IGNORE INTO eva_units (unit_id, designation, status, activation_count) VALUES (%s, %s, %s, %s)",
                (unit["unit_id"], unit["designation"], unit["status"], random.randint(5, 80))
            )

        # Insertamos los pilotos
        for pilot in PILOTS:
            cur.execute(
                "INSERT IGNORE INTO pilots (pilot_id, name, age, status, assigned_unit, recruitment_date) VALUES (%s, %s, %s, %s, %s, %s)",
                (pilot["pilot_id"], pilot["name"], pilot["age"], pilot["status"], pilot["assigned_unit"], pilot["recruitment_date"])
            )

        conn.commit()

        # Generamos e insertamos las sesiones
        sessions = generate_sessions()
        for session in sessions:
            cur.execute(
                "INSERT INTO sync_sessions (pilot_id, unit_id, sync_rate, session_date, duration_min, mental_contamination, status) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                (session["pilot_id"], session["unit_id"], session["sync_rate"],
                 session["session_date"].strftime("%Y-%m-%d %H:%M:%S"),
                 session["duration_min"], session["mental_contamination"], session["status"])
            )
            # Guardamos el id generado por MariaDB para usarlo en los registros médicos
            session["session_id"] = cur.lastrowid

        conn.commit()

        # Generamos e insertamos los registros médicos
        medical = generate_medical(sessions)
        for record in medical:
            cur.execute(
                "INSERT INTO pilot_medical (pilot_id, session_id, heart_rate_avg, neural_stress, recovery_hours, notes, record_date) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                (record["pilot_id"], record["session_id"], record["heart_rate_avg"],
                 record["neural_stress"], record["recovery_hours"], record["notes"],
                 record["record_date"].strftime("%Y-%m-%d %H:%M:%S"))
            )

        conn.commit()
        print("Inserción completada")

    except Exception as e:
        conn.rollback()
        print(f" Error: {e}")
        raise

    finally:
        cur.close()
        conn.close()


if __name__ == "__main__":
    insert()