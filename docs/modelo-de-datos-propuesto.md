# Modelo de datos propuesto para NEXUS

## 1. Objetivo y alcance

El modelo relacional de SQL Server permitirá registrar jugadores y guardar el estado completo de cada partida de NEXUS. Se diseña a partir de las clases y atributos que ya existen en H3/v2.0, más los datos mínimos necesarios para reconstruir la sesión.

La base de datos es una propuesta para la siguiente etapa. El prototipo actual no utiliza SQL Server ni guarda partidas.

## 2. Decisiones de modelado

- Los datos de identidad (nombre y edad) pertenecen a Jugador.
- Los recursos y el progreso pertenecen a Partida, porque un jugador puede tener más de una partida.
- Las nueve casillas se almacenan por partida para reconstruir el mapa explorado.
- Los cuatro objetivos se almacenan por partida para recuperar su estado individual.
- Cada objeto del inventario se guarda como una instancia individual, igual que la lista actual de Inventario. La aplicación debe validar que no existan más de ocho instancias.
- El encuentro activo se almacena aparte para poder continuar una partida incluso si se cerró durante un combate.
- Las claves foráneas mantienen la integridad entre jugador, partida y sus componentes.

## 3. Entidades y campos

### Jugador

| Campo | Tipo SQL Server | Regla |
|---|---|---|
| IdJugador | INT IDENTITY | PK |
| Nombre | NVARCHAR(50) | Obligatorio |
| Edad | INT | >= 18 |
| FechaRegistro | DATETIME2 | Fecha de creación |

### Partida

| Campo | Tipo SQL Server | Regla |
|---|---|---|
| IdPartida | INT IDENTITY | PK |
| IdJugador | INT | FK a Jugador |
| FechaInicio | DATETIME2 | Obligatorio |
| FechaGuardado | DATETIME2 | Último guardado |
| Estado | VARCHAR(15) | EN_CURSO, COMPLETADA, DERROTADA o ABANDONADA |
| Energia | INT | 0 a 100 |
| Estabilidad | INT | 0 a 100 |
| Ataque | INT | >= 0 |
| Escudo | INT | >= 0 |
| Experiencia | INT | >= 0 |
| ZonasExploradas | INT | >= 0 |
| PistasIris | INT | 0 a 3 |
| FilaActual | TINYINT | 0 a 2 |
| ColumnaActual | TINYINT | 0 a 2 |

### CeldaPartida

| Campo | Tipo SQL Server | Regla |
|---|---|---|
| IdPartida | INT | PK compuesta y FK |
| Fila | TINYINT | PK compuesta, 0 a 2 |
| Columna | TINYINT | PK compuesta, 0 a 2 |
| EstadoCelda | CHAR(1) | E, X o - |

Cada partida debe tener exactamente nueve registros. La posición actual se guarda en Partida; el estado de la celda conserva la información de exploración.

### ObjetivoPartida

| Campo | Tipo SQL Server | Regla |
|---|---|---|
| IdPartida | INT | PK compuesta y FK |
| NumeroObjetivo | TINYINT | PK compuesta, 1 a 4 |
| Descripcion | NVARCHAR(150) | Texto del objetivo |
| Cumplido | BIT | 0 pendiente, 1 cumplido |

Los cuatro objetivos corresponden a llegar a la anomalía, encontrar el núcleo, sobrevivir al Guardián y regresar a extracción.

### ItemCatalogo

| Campo | Tipo SQL Server | Regla |
|---|---|---|
| IdItem | INT IDENTITY | PK |
| Nombre | NVARCHAR(80) | Obligatorio |
| Tipo | VARCHAR(20) | Celula, Escudo, ModuloAtaque o Analizador |
| Valor | INT | Valor aplicado por el objeto |
| Descripcion | NVARCHAR(150) | Descripción |

El catálogo inicial debe reflejar los objetos del código: Célula de energía (25), Escudo (20), Módulo de ataque (5), Analizador (0) y Módulo desconocido (10, tipo ModuloAtaque).

### InventarioPartida

| Campo | Tipo SQL Server | Regla |
|---|---|---|
| IdInventario | INT IDENTITY | PK |
| IdPartida | INT | FK a Partida |
| IdItem | INT | FK a ItemCatalogo |
| ValorObjeto | INT | Copia del valor aplicado a esa instancia |

Cada fila representa un objeto individual. La aplicación valida que la cantidad total de filas de una partida no supere ocho.

### EncuentroPartida

| Campo | Tipo SQL Server | Regla |
|---|---|---|
| IdEncuentro | INT IDENTITY | PK |
| IdPartida | INT | FK y UNIQUE: máximo un encuentro activo |
| TipoEntidad | VARCHAR(10) | Enemigo o Robot |
| NombreEntidad | NVARCHAR(80) | Nombre visible |
| EnergiaEntidad | INT | > 0 mientras siga activo |
| AtaqueEntidad | INT | >= 0 |
| DefensaActiva | BIT | Estado especial del robot |
| EsGuardian | BIT | Indica si corresponde al encuentro de misión |

Cuando no existe encuentro activo, no debe existir una fila asociada en esta tabla.

## 4. Relaciones

~~~mermaid
erDiagram
 JUGADOR ||--o{ PARTIDA : inicia
 PARTIDA ||--|{ CELDA_PARTIDA : contiene
 PARTIDA ||--|{ OBJETIVO_PARTIDA : registra
 PARTIDA ||--o{ INVENTARIO_PARTIDA : contiene
 ITEM_CATALOGO ||--o{ INVENTARIO_PARTIDA : clasifica
 PARTIDA ||--o| ENCUENTRO_PARTIDA : mantiene
~~~

## 5. Reglas de integridad

1. Una partida pertenece a un único jugador.
2. Un jugador puede tener varias partidas.
3. Cada partida tiene nueve celdas y cuatro objetivos.
4. Cada partida tiene como máximo un encuentro activo.
5. El inventario tiene un máximo de ocho objetos individuales; se valida en la capa de aplicación dentro de una operación transaccional.
6. Energía y estabilidad se mantienen entre 0 y 100.
7. Pistas IRIS se mantienen entre 0 y 3.
8. La fila y columna actuales deben estar entre 0 y 2.
9. El estado de partida solo admite EN_CURSO, COMPLETADA, DERROTADA o ABANDONADA.

## 6. Guardado y recuperación

El guardado debe ejecutarse dentro de una transacción:
1. Actualizar el registro Partida.
2. Actualizar las nueve filas de CeldaPartida.
3. Actualizar los cuatro registros de ObjetivoPartida.
4. Reemplazar las instancias de InventarioPartida por el inventario vigente.
5. Insertar o actualizar EncuentroPartida si existe una entidad activa; eliminarla si el encuentro terminó.
6. Confirmar la transacción solo si todas las operaciones fueron correctas; en caso contrario, revertirla.

Para cargar, consultar Partida por IdPartida y recuperar jugador, celdas, objetivos, objetos y encuentro. Con esos datos se reconstruyen las instancias del dominio antes de mostrar FrmExploracion.

## 7. Script de creación

El archivo [nexus-schema.sql](sql/nexus-schema.sql) contiene el DDL inicial para crear la base de datos, tablas, restricciones e insertar el catálogo de objetos. Debe ejecutarse en SQL Server Management Studio o una herramienta compatible, con permisos para crear la base de datos.

## 8. Datos que no se agregan sin necesidad

El modelo no incluye niveles, árbol de habilidades, tiempo de juego, logros, mapas de tamaños mayores ni misiones secundarias porque no forman parte de la versión base del código. Si se incorporan en otra etapa, se documentarán y modelarán como ampliaciones independientes.

## 9. Conclusión

El modelo permite guardar y reconstruir el estado que realmente utiliza NEXUS: personaje, recursos, mapa 3×3, objetivos, inventario y encuentro activo. De esta manera, SQL Server respalda la continuidad del videojuego sin introducir mecánicas ajenas al prototipo H3/v2.0.
