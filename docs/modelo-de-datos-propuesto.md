# Modelo de Datos Propuesto

## Objetivo

Permitir almacenar el progreso del jugador utilizando SQL Server.

## Tabla Jugador

| Campo | Tipo |
|---------|---------|
| IdJugador | INT |
| Nombre | VARCHAR(50) |
| Edad | INT |
| Energia | INT |
| Estabilidad | INT |
| Nivel | INT |
| Experiencia | INT |

## Tabla Partida

| Campo | Tipo |
|---------|---------|
| IdPartida | INT |
| IdJugador | INT |
| FechaGuardado | DATETIME |
| Profundidad | INT |

## Tabla Mision

| Campo | Tipo |
|---------|---------|
| IdMision | INT |
| Nombre | VARCHAR(100) |
| Descripcion | VARCHAR(200) |
| Recompensa | VARCHAR(100) |

## Tabla ProgresoMision

| Campo | Tipo |
|---------|---------|
| IdProgreso | INT |
| IdJugador | INT |
| IdMision | INT |
| Estado | VARCHAR(20) |

## Tabla Item

| Campo | Tipo |
|---------|---------|
| IdItem | INT |
| Nombre | VARCHAR(100) |
| Tipo | VARCHAR(50) |
| Descripcion | VARCHAR(200) |

## Tabla Inventario

| Campo | Tipo |
|---------|---------|
| IdInventario | INT |
| IdJugador | INT |
| IdItem | INT |
| Cantidad | INT |

## Tabla Anomalia

| Campo | Tipo |
|---------|---------|
| IdAnomalia | INT |
| Nombre | VARCHAR(100) |
| Tipo | VARCHAR(50) |
| Efecto | VARCHAR(100) |

## Relaciones

Jugador

- Tiene partidas
- Tiene inventario
- Tiene progreso de misiones

Inventario

- Contiene Items

ProgresoMision

- Referencia Misiones

## Estrategia de persistencia

SQL Server almacenará:

- Jugadores.
- Inventario.
- Misiones.
- Estadísticas.
- Profundidad.
- Progreso general.

## Conclusión

El modelo propuesto permite crecer sin modificar significativamente la estructura de la base de datos.