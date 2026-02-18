# QUERY 1
# Ranking de Pilotos: Obtén el promedio de sync_rate por piloto, ordenado de mayor a
# menor, incluyendo el nombre del piloto, la cantidad total de sesiones y su mejor registro histórico.
# Solo pilotos activos.
# NOTA : EN LA GENERACIÓN DE DATOS SE ESTABLECIO QUE UN PILOTO ACTIVO DEBIA LLEGAR
# A CIERTO NUMERO DE SESIONES PARA CONSIDERARSE ACTIVO, QUE FUE DE 40, POR ENDE, TODOS LOS RESULTADOS TIENEN 40
# LO QUE SEBE REALIZAR CONSTA EN UNIR LOS REGISTROS DE LAS SESIONES CON LOS RESPECTIVOS DATOS DE LOS
# PILOTOS ACTIVOS. DE LA TABLA DE SESIONES ES POSIBLE OBTENER LOS RESULTADOS NUMERICOS QUE DEBEN IR
# CON SUS RESPECTIVAS AGREGACIONES COMO
# - MAX: OBTIENE EL SYNC MAS ALTO DE LOS REGISTROS
# - AVG : OBTIENE EL PROMEDIO DE LOS SYNC PRESENTES EN TODOS LOS REGISTROS
# - COUNT: OBTIENE EL TOTAL DE VECES QUE APARECE EL PILOTO EN LOS REGISTROS, DE NUEVO, ES 40 POR LA GENERACION
# ESTOS RESULTADOS SE AGRUPAN PARA OBTENER SOLO UN REGISTRO POR CADA PILOTO ACTIVO
SELECT p.name               AS nombre_piloto,
       p.pilot_id           AS id_piloto,
       COUNT(se.session_id) AS total_sesiones,
       AVG(se.sync_rate)    AS promedio_sync,
       MAX(se.sync_rate)    AS mejor_sync_historico
FROM pilots p
         JOIN sync_sessions se ON p.pilot_id = se.pilot_id
WHERE p.status = 'active'
GROUP BY p.pilot_id, p.name
ORDER BY promedio_sync DESC;


# QUERY 2
#  Tendencia Mensual: Para cada piloto activo, calcula el promedio mensual de sync_rate de
# los últimos 6 meses. El resultado debe mostrar piloto, mes y promedio, permitiendo identificar
# tendencias de mejora o declive.
# EL PROCESO DE ESTA QUERY ES SIMILAR AL APPROACH ANTERIOR, EL CAMBIO FUNDAMENTAL ESTA EN QUE SE AÑADE
# EL CAMPO DE AÑO-MES, QUE AYUDA A VER EL PROMEDIO POR MES, DENTRO DE LOS ULTIMOS 6 MESES PEDIDOS POR ENUNCIADO,
# DE NUEVO, SE OBTIENE EL PROMEDIO CON LA FUNCION AVG Y SE AGRUPA POR LOS CAMPOS QUE CONTIENEN LOS DATOS DEL PILOTO Y
# EL AÑO-MES. SE PUEDE NOTAR COMO CAMBIA EL SYNC DE LOS PILOTOS CON VARIAS FLUCTUACIONES A LO LARGO DE LOS MESES
# COMO LA MEJORA CONTINUA DE VALENTINA PEÑA HASTA EL 2025-11 DONDE RECAE
SELECT p.name,
       DATE_FORMAT(se.session_date, '%Y-%m') AS ano_mes,
       AVG(se.sync_rate)                     AS promedio_sync_por_mes
FROM pilots p
         JOIN sync_sessions se ON p.pilot_id = se.pilot_id
WHERE p.status = 'active'
  AND se.session_date >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
GROUP BY p.pilot_id, p.name, ano_mes
ORDER BY p.name, ano_mes;

# QUERY 3
# revisar
# Detección de Anomalías: Encuentra todas las sesiones donde el sync_rate se desvió más
# de 2 desviaciones estándar del promedio histórico de ese mismo piloto. Incluye el nombre del
# piloto, la fecha, el sync_rate y la desviación.
# PRIMERO, SE REALIZA UNA SUBQUERY (CTE) PARA OBTENER LOS DATOS RELEVANTES DE LOS REGISTROS DE SESIONES
# ES DECIR EL PROMEDIO SYNC POR PILOTO Y LA AGREGACION STDDEV CALCULA CUANTO VARIA LAS SESIONES CON RESPECTO
# AL PROMEDIO SYNC CALCULADO. CON ESTOS DATOS, SE PARTE DESDE LOS REGISTROS DE SESIONES PARA UNIR A LOS DATOS
# DE LOS STATS CON LOS DATOS DE LOS PILOTOS, SE INCLUYE LA CLAUSULA WHERE PARA CUMPLIR QUE LA RESTA DEL SYNC RATE OBTENIDO
# EN LA SESION CON EL PROMEDIO HISTORICO, SEA MAYOR QUE DOS VECES LA DESVIACION ESTANDAR OBTENIDA.
WITH stats_piloto AS (SELECT pilot_id,
                             AVG(sync_rate)    AS promedio,
                             STDDEV(sync_rate) AS dev_estandar
                      FROM sync_sessions
                      GROUP BY pilot_id)
SELECT p.name                     AS nombre_piloto,
       se.session_date            AS fecha_sesion,
       se.sync_rate               AS sync_obtenido,
       sp.dev_estandar            AS desv_stand,
       se.sync_rate - sp.promedio AS diferencia_syncs
FROM sync_sessions se
         JOIN pilots p ON p.pilot_id = se.pilot_id
         JOIN stats_piloto sp ON sp.pilot_id = se.pilot_id
WHERE ABS(se.sync_rate - sp.promedio) > 2 * sp.dev_estandar;

# QUERY 4
# Para cada combinación piloto-unidad, calcula el promedio de
# sync_rate y la cantidad de sesiones. Identifica cuál es la mejor unidad para cada piloto (la que
# produce el sync_rate promedio más alto).
# PRIMERO SE REALIZAN DOS SUBQUERIES, LA PRIMERA OBTIENE LAS ESTADISTICAS COMO EL PROMEDIO Y LA CANTIDAD DE SESIONES, UNIENDO
# LOS DATOS DE LAS SESIONES CON LOS DATOS DE LOS PILOTOS, TOMANDO ESTA SUBQUERY COMO BASE SE UTILIZA LA FUNCIÓN ROW_NUMBER
# PARA OBTENER UN RANKING A PARTIR DE LA SUBQUERY ANTERIOR, SE REALIZA LA PARTICION SOBRE EL NOMBRE DEL PILOTO (TAMBIEN PUEDE SER POR SU ID)
# ORDENANDO POR SOBRE EL PROMEDIO DE SYNC DEL PILOTO DE MANERA DESCENDIENTE. FINALMENTE, SE HACE UNA LLAMADA A ESTA ULTIMA SUBQUERY OBTIENENDO SOLO
# LOS RESULTADOS FINALES QUE TENGAN EL RANKING 1
WITH stats_pilot AS (SELECT p.name               AS nombre_piloto,
                            se.unit_id           AS unidad_EVA,
                            AVG(sync_rate)       AS promedio_sync,
                            COUNT(se.session_id) AS sesiones_totales
                     FROM sync_sessions se
                              JOIN pilots p ON p.pilot_id = se.pilot_id
                     GROUP BY p.name, se.unit_id),
     rank_sesiones AS (SELECT *,
                              ROW_NUMBER() over (PARTITION BY sp.nombre_piloto ORDER BY sp.promedio_sync DESC) AS orden_de_syncs
                       FROM stats_pilot sp)
SELECT nombre_piloto,
       unidad_EVA,
       promedio_sync,
       sesiones_totales
FROM rank_sesiones
WHERE orden_de_syncs = 1
ORDER BY promedio_sync DESC;

#QUERY 5
# Genera un reporte que muestre, por piloto: tasa de sesiones abortadas/
# críticas, promedio de mental_contamination, promedio de neural_stress, y un flag 'HIGH_RISK'
# si la tasa de sesiones problemáticas supera el 20% o el promedio de mental_contamination
# supera 60.
# SE UNEN PILOTOS, SESIONES Y REGISTROS MÉDICOS, LEFT JOIN PORQUE NO TODAS LAS SESIONES TIENEN REGISTRO MÉDICO.
# SE UTILIZA LA FUNCIÓN CASE WHEN PARA CONTAR SOLO LAS SESIONES PROBLEMÁTICAS (ABORTED, CTRICIAL) Y SE CALCULA SU TASA SOBRE EL TOTAL. TAMBIÉN SE PROMEDIAN
# LA CONTAMINACIÓN MENTAL Y EL ESTRÉS NEURAL. EL FLAG HIGH_RISK SE ACTIVA SI LA TASA SUPERA 20%O EL PROMEDIO DE CONTAMINACIÓN MENTAL SUPERA 60.
SELECT p.name,
       COUNT(s.session_id)                                                  AS total_sesiones,
       SUM(CASE WHEN s.status IN ('aborted', 'critical') THEN 1 ELSE 0 END) AS sesiones_problematicas,
       ROUND(
               SUM(CASE WHEN s.status IN ('aborted', 'critical') THEN 1 ELSE 0 END)
                   / COUNT(s.session_id) * 100, 2
       )                                                                    AS tasa_problematica_pct,
       ROUND(AVG(s.mental_contamination), 2)                                AS avg_mental_contamination,
       ROUND(AVG(m.neural_stress), 2)                                       AS avg_neural_stress,
       CASE
           WHEN SUM(CASE WHEN s.status IN ('aborted', 'critical') THEN 1 ELSE 0 END)
                    / COUNT(s.session_id) * 100 > 20
               OR AVG(s.mental_contamination) > 60
               THEN 'HIGH_RISK'
           ELSE 'OK'
           END                                                              AS flag_riesgo
FROM pilots p
         JOIN sync_sessions s ON p.pilot_id = s.pilot_id
         LEFT JOIN pilot_medical m ON s.session_id = m.session_id
GROUP BY p.pilot_id, p.name
ORDER BY tasa_problematica_pct DESC;


# QUERY 6
# No se realizo :(

# QUERY 7
# Escribe una consulta que liste las unidades operacionales
# junto con su piloto asignado (si tiene), el último sync_rate registrado para esa combinación, y los
# días transcurridos desde la última sesión. Incluye unidades sin piloto asignado.
# PRIMERO SE OBTIENE EN UN CTE LA ÚLTIMA SESIÓN REGISTRADA POR UNIDAD USANDO ROW_NUMBER ORDENADO POR FECHA DESCENDIENTE.
# LUEGO SE UNEN LAS UNIDADES CON SUS PILOTOS ACTIVOS ASIGNADOS Y CON LA ÚLTIMA SESIÓN, AMBOS CON LEFT JOIN PARA INCLUIR
# UNIDADES QUE NO TIENEN PILOTO ASIGNADO O SIN SESIONES REGISTRADAS. SE FILTRAN SOLO LAS UNIDADES OPERACIONALES Y SE MUESTRA
# CUÁNTOS DÍAS HAN PASADO DESDE LA ÚLTIMA SESIÓN CON DATEDIFF. LAS FECHAS DEL DATASET GENERADO VAN DESDE EL 2025 AL 2026!
WITH ult_sesion AS (SELECT pilot_id                                                            AS nombre_piloto,
                           unit_id                                                             AS unidad_EVA,
                           sync_rate                                                           AS sync_obtenida,
                           session_date                                                        AS fecha_sesion,
                           ROW_NUMBER() OVER (PARTITION BY unit_id ORDER BY session_date DESC) AS orden_sesiones
                    FROM sync_sessions)
SELECT e.unit_id,
       e.designation,
       p.name                           AS piloto_asignado,
       us.sync_obtenida                 AS ultimo_sync_rate,
       DATEDIFF(NOW(), us.fecha_sesion) AS dias_desde_ultima_sesion
FROM eva_units e
         LEFT JOIN pilots p ON e.unit_id = p.assigned_unit AND p.status = 'active'
         LEFT JOIN ult_sesion us ON e.unit_id = us.unidad_EVA AND us.orden_sesiones = 1
WHERE e.status = 'operational'
ORDER BY dias_desde_ultima_sesion ASC;
