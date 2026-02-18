USE magi_db;

-- 1. eva_units
CREATE TABLE IF NOT EXISTS eva_units
(
    unit_id          VARCHAR(10) PRIMARY KEY,
    designation      VARCHAR(100) NOT NULL,
    status           VARCHAR(20)  NOT NULL
        CHECK (status IN ('operational', 'maintenance', 'destroyed')),
    activation_count INT DEFAULT 0
);

-- 2. pilots (referencia eva_units)

CREATE TABLE IF NOT EXISTS pilots
(
    pilot_id         VARCHAR(10) PRIMARY KEY,
    name             VARCHAR(100) NOT NULL,
    age              INT          NOT NULL,
    status           VARCHAR(20)  NOT NULL
        CHECK (status IN ('active', 'inactive', 'suspended')),
    assigned_unit    VARCHAR(10) DEFAULT NULL,
    recruitment_date DATE         NOT NULL,

    CONSTRAINT fk_pilot_unit
        FOREIGN KEY (assigned_unit) REFERENCES eva_units (unit_id)
);

-- 3. sync_sessions (referencia pilots y eva_units)
-- Asumiendo que los tipos de campo REAL son porcentajes no enteros
-- se cambian los tipos de datos a DECIMAL para poder obtener
-- porcentajes no
CREATE TABLE IF NOT EXISTS sync_sessions
(
    session_id           INT PRIMARY KEY AUTO_INCREMENT,
    pilot_id             VARCHAR(10)   NOT NULL,
    unit_id              VARCHAR(10)   NOT NULL,
    sync_rate            DECIMAL(5, 2) NOT NULL,
    session_date         DATETIME      NOT NULL,
    duration_min         INT           NOT NULL,
    mental_contamination DECIMAL(5, 2) DEFAULT 0.00,
    status               VARCHAR(20)   NOT NULL
        CHECK (status IN ('completed', 'aborted', 'critical')),

    CONSTRAINT chk_sync_rate
        CHECK (sync_rate BETWEEN 0 AND 100),
    CONSTRAINT chk_mental_contamination
        CHECK (mental_contamination BETWEEN 0 AND 100),

    CONSTRAINT fk_session_pilot
        FOREIGN KEY (pilot_id) REFERENCES pilots (pilot_id),
    CONSTRAINT fk_session_unit
        FOREIGN KEY (unit_id) REFERENCES eva_units (unit_id)
);

-- 4. pilot_medical (referencia pilots y sync_sessions)
CREATE TABLE IF NOT EXISTS pilot_medical
(
    record_id      INT PRIMARY KEY AUTO_INCREMENT,
    pilot_id       VARCHAR(10) NOT NULL,
    session_id     INT DEFAULT NULL,
    heart_rate_avg INT,
    neural_stress  DECIMAL(5, 2),
    recovery_hours DECIMAL(5, 2),
    notes          TEXT,
    record_date    DATETIME    NOT NULL,

    CONSTRAINT chk_neural_stress
        CHECK (neural_stress IS NULL OR neural_stress BETWEEN 0 AND 100),

    CONSTRAINT fk_medical_pilot
        FOREIGN KEY (pilot_id) REFERENCES pilots (pilot_id),
    CONSTRAINT fk_medical_session
        FOREIGN KEY (session_id) REFERENCES sync_sessions (session_id)
);
