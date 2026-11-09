# Diseño del videojuego NEXUS

## 1. Identidad y objetivo

NEXUS es un videojuego de exploración, supervivencia y combate ambientado en el año 2297. El jugador controla a un cadete autorizado para ingresar en una realidad desconocida donde se detectó una anomalía. Debe explorar el mapa, administrar sus recursos, superar encuentros y regresar al punto de extracción.

Este diseño parte del videojuego H3/v2.0 que ya existe en el repositorio. La versión actual es de consola y contiene las mecánicas descritas en la sección 3. La versión de escritorio con Windows Forms y SQL Server es la evolución prevista; no se presenta como una funcionalidad ya implementada.

## 2. Experiencia que debe ofrecer el juego

El jugador debe sentir que está realizando una incursión de riesgo controlado. Cada movimiento consume recursos y puede activar un evento. El combate obliga a decidir entre atacar, usar un objeto o intentar escapar. La misión no termina al llegar a la anomalía: el cadete debe sobrevivir y volver a extracción.

Los recursos principales son:
- **Energía:** representa la capacidad física y operativa del cadete.
- **Estabilidad:** representa su resistencia ante las distorsiones de la realidad.
- **Escudo:** absorbe daño antes de que disminuya la energía.
- **Ataque:** determina el daño base infligido a una entidad.
- **Experiencia (XP):** recompensa obtenida por derrotar entidades y completar la misión.
- **Pistas IRIS:** registros encontrados durante la exploración.

## 3. Mecánicas implementadas en H3/v2.0

### 3.1 Registro y autorización de inmersión

Al iniciar, el juego solicita nombre, edad, energía y estabilidad iniciales. La inmersión se rechaza si:
- La edad es menor de 18 años.
- La energía inicial es menor de 30.
- La estabilidad inicial es menor de 40.

Los valores de energía y estabilidad superiores a 100 se limitan a 100. El cadete comienza con ataque base de 10, cero XP y cero escudo.

### 3.2 Mapa y desplazamiento

El mapa es una matriz de 3 filas por 3 columnas. El cadete comienza en la coordenada (0,0), que corresponde al punto de extracción. La anomalía principal está en la esquina opuesta, coordenada (2,2).

El jugador puede desplazarse al norte, sur, este u oeste. Un movimiento que salga de los límites se rechaza y no consume recursos. Cada movimiento válido:
- Aumenta el contador de zonas exploradas.
- Reduce 5 puntos de energía.
- Reduce 2 puntos de estabilidad.
- Puede activar el evento de la casilla.

La matriz conserva las casillas visitadas. La posición actual se muestra como J, la extracción se identifica como E, las zonas visitadas como X y las no exploradas como -.

### 3.3 Eventos de exploración

Al entrar en una zona que no sea la extracción ni la anomalía principal, el juego selecciona uno de siete resultados posibles:
1. Encontrar un objeto.
2. Encontrar un robot centinela o una criatura de la anomalía.
3. Distorsión de realidad: estabilidad -10.
4. Encontrar un registro de IRIS y obtener una pista.
5. Fuga del traje: energía -10.
6. Daño del sistema: energía -5 y estabilidad -5.
7. No encontrar nada.

La selección es aleatoria; por eso no se puede garantizar que el jugador encuentre un evento específico en cada recorrido.

### 3.4 Energía y estabilidad

La energía no puede superar 100 y llega a cero cuando el cadete pierde toda su capacidad. La estabilidad se reduce por movimientos y ciertos eventos. La partida termina si la energía o la estabilidad llegan a cero.

Acciones y costos implementados:
| Acción o evento | Efecto |
|---|---:|
| Movimiento válido | Energía -5; estabilidad -2 |
| Analizar anomalía | Energía -8 |
| Descansar | Recupera 15 de energía, hasta 100 |
| Distorsión | Estabilidad -10 |
| Fuga del traje | Energía -10 |
| Daño del sistema | Energía -5; estabilidad -5 |
| Escapar de un encuentro | Energía -5 |

### 3.5 Inventario y objetos

El inventario admite un máximo de ocho objetos individuales. Al iniciar, el cadete recibe una célula de energía y un analizador.

| Objeto | Efecto implementado |
|---|---|
| Célula de energía | Recupera 25 de energía, hasta 100 |
| Escudo | Añade 20 puntos de protección |
| Módulo de ataque | Aumenta el ataque en 5 |
| Analizador | Permite consultar información de una entidad; no se consume al analizar |
| Módulo desconocido | Recompensa final que aumenta el ataque en 10 |

Si el inventario está lleno, no se puede agregar otro objeto. Los objetos consumibles se eliminan del inventario al utilizarlos; el analizador permanece disponible.

### 3.6 Combate

Cuando aparece una entidad, el jugador no puede moverse, descansar ni analizar la anomalía. Debe resolver el encuentro mediante las opciones disponibles:
- **Atacar:** el cadete inflige daño igual a su ataque actual.
- **Usar objeto:** puede activar una célula, un escudo o un módulo de ataque.
- **Escapar:** consume 5 de energía y tiene una probabilidad aleatoria de éxito o fracaso.
- **Analizar entidad:** requiere que el inventario contenga un analizador.

Si la entidad continúa viva después de la acción, reacciona y ataca al cadete. El escudo del cadete absorbe daño antes de reducir su energía.

Entidades y reglas:
| Entidad | Energía inicial | Ataque | Comportamiento |
|---|---:|---:|---|
| Criatura de la anomalía | 30 | 10 | Contraataca |
| Robot centinela | 30 | 6 | Activa defensa y recibe la mitad del daño |
| Guardián de la anomalía | 50 | 10 | Encuentro obligatorio de la misión; se comporta como Enemigo |

Recompensas por derrota:
- Enemigo: 20 XP.
- Robot: 30 XP.
- Guardián: aplica la recompensa de Enemigo, 20 XP.

### 3.7 Análisis de anomalía y pistas IRIS

La opción de analizar anomalía no está disponible durante un encuentro. Consume 8 de energía y aumenta el contador de pistas IRIS hasta un máximo de tres. Los eventos aleatorios también pueden entregar una pista. Las tres pistas no son un requisito de la misión principal actual.

### 3.8 Misión principal: La anomalía perdida

La misión tiene cuatro objetivos, en este orden:
1. Llegar a la zona de anomalía.
2. Encontrar el núcleo energético.
3. Sobrevivir al encuentro con la entidad guardiana.
4. Regresar al punto de extracción.

Al llegar a (2,2), el juego marca los dos primeros objetivos y crea al Guardián con 50 de energía y 10 de ataque. Cuando termina ese encuentro, el tercer objetivo se marca como cumplido. Al regresar a (0,0), si los tres objetivos anteriores están completos, se completa la misión, se otorgan 100 XP y un módulo desconocido (+10 ataque).

## 4. Ciclo de juego implementado

~~~mermaid
flowchart TD
 A[Iniciar NEXUS] --> B[Ingresar datos del cadete]
 B --> C{¿Cumple requisitos?}
 C -- No --> D[Inmersión rechazada]
 C -- Sí --> E[Crear mapa, misión y objetos iniciales]
 E --> F[Mostrar menú]
 F --> G{Elegir acción}
 G --> H[Moverse]
 G --> I[Analizar anomalía]
 G --> J[Descansar]
 G --> K[Consultar estado, mapa, inventario o misión]
 G --> L[Usar objeto, atacar, escapar o analizar entidad]
 H --> M[Resolver zona o evento]
 I --> N[Obtener pista si corresponde]
 L --> O[Resolver reacción de entidad]
 M --> P{¿Energía o estabilidad en cero?}
 N --> P
 O --> P
 K --> F
 P -- No --> Q{¿Misión completa o salida?}
 Q -- No --> F
 Q -- Sí --> R[Mostrar resultado]
 P -- Sí --> R
 D --> R
~~~

## 5. Diseño de la futura versión Windows Forms

La interfaz gráfica debe presentar las mismas reglas del prototipo. No debe reemplazar el mapa 3×3 por mapas de otro tamaño ni introducir niveles, habilidades, crafting o misiones secundarias como si ya existieran.

### 5.1 Menú principal

Botones:
- Nueva partida.
- Continuar partida (se habilitará cuando exista una partida guardada).
- Salir.

### 5.2 Registro del cadete

Campos: nombre, edad, energía inicial y estabilidad inicial. El botón Iniciar valida los mismos límites de H3. Si los datos no cumplen, se muestra un mensaje y no se crea la partida.

### 5.3 Pantalla de exploración

Distribución funcional:
- Centro: mapa 3×3 con nueve casillas visuales.
- Panel superior o lateral: nombre, energía, estabilidad, ataque, escudo y XP.
- Panel de misión: cuatro objetivos con estado pendiente/completado.
- Registro de eventos: mensajes de movimientos, hallazgos, daños y resultados.
- Controles de movimiento: Norte, Sur, Este y Oeste.
- Acciones: Analizar anomalía, Descansar, Estado, Inventario y Misión.

Al pulsar una dirección, la interfaz solicita al servicio de juego el movimiento. Si es válido, se actualizan mapa, recursos y registro. Si el movimiento no es válido, se informa sin consumir recursos.

### 5.4 Pantalla o panel de encuentro

Cuando aparece una entidad:
- Se muestra nombre, tipo y energía de la entidad.
- Se habilitan Atacar, Usar objeto, Escapar y Analizar entidad.
- Se deshabilitan movimiento, descanso y análisis de anomalía.
- Después de la acción del jugador, se representa la reacción de la entidad si sigue viva.
- Al derrotarla o escapar con éxito, se actualiza el estado del encuentro.

### 5.5 Inventario

Lista de objetos individuales con nombre, tipo y efecto. El usuario selecciona un objeto y pulsa Usar. El sistema valida el índice/selección, aplica el efecto y elimina el objeto consumible. El analizador permanece en el inventario.

### 5.6 Resultado de misión

Al completar los cuatro objetivos y regresar a extracción, se muestra la victoria, los 100 XP y el módulo desconocido. La aplicación podrá guardar el estado final en SQL Server.

## 6. Reglas de persistencia previstas

Para que Continuar partida reproduzca la sesión correctamente, SQL Server deberá guardar como mínimo:
- Identidad del jugador.
- Estado del cadete: energía, estabilidad, ataque, escudo, XP, zonas exploradas y pistas.
- Posición y nueve celdas del mapa.
- Estado de los cuatro objetivos.
- Objetos del inventario.
- Encuentro activo, si lo hubiera, incluyendo tipo, energía, ataque, defensa del robot y si es el Guardián.
- Estado de la partida y fecha de guardado.

## 7. Alcance y exclusiones

**Incluido en H3/v2.0:** mapa 3×3, movimientos cardinales, recursos, eventos aleatorios, objetos, inventario, enemigos, robots, combate, análisis, pistas y misión principal.

**Objetivo de las siguientes etapas:** Windows Forms, SQL Server, guardado y recuperación de partidas, y separación del código en capas.

**No comprometido para esta etapa:** mapas 10×10 o mayores, árbol de habilidades, niveles, crafting, misiones secundarias, múltiples finales, juego en línea o gráficos 3D. Podrán evaluarse en futuras ampliaciones, pero no forman parte del alcance base.

## 8. Criterio de aceptación del diseño

El diseño se considerará coherente cuando cada pantalla y acción de Windows Forms tenga correspondencia con una mecánica implementada o una ampliación identificada explícitamente; cuando las reglas y recompensas coincidan con el código H3/v2.0; y cuando el modelo de datos permita guardar y reconstruir una partida sin perder su estado.
