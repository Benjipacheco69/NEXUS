# Diseño del Juego - NEXUS

## Visión del juego

NEXUS es un videojuego de exploración de realidades alternativas donde el jugador asume el rol de un explorador digital autorizado para ingresar a dimensiones desconocidas generadas por una inteligencia artificial llamada IRIS.

La misión principal consiste en explorar diferentes sectores del Nexus, analizar anomalías, recolectar pistas y descubrir los secretos ocultos detrás de IRIS. Durante la exploración se deben administrar cuidadosamente la energía y la estabilidad mental, ya que ambos recursos son necesarios para sobrevivir dentro de las realidades alternativas.

La propuesta parte directamente del proyecto desarrollado en H3, conservando las mecánicas actuales e incorporando nuevas funcionalidades para transformarlo en un videojuego gráfico desarrollado con Windows Forms y SQL Server.

---

## Ciclo principal de juego

Inicio del juego

↓

Registro del explorador

↓

Validación de requisitos

↓

Menú principal

↓

Exploración de realidades

↓

Analizar anomalías

↓

Obtener pistas de IRIS

↓

Completar misiones

↓

Obtener recompensas

↓

Desbloquear nuevas zonas

↓

Continuar explorando

↓

Descubrir el origen de IRIS

---

## Mecánicas y reglas

### Exploración

La exploración es la mecánica principal del juego.

Cada exploración:

- Incrementa la profundidad.
- Consume energía.
- Reduce estabilidad.
- Descubre sectores nuevos del mapa.
- Puede activar eventos aleatorios.

### Energía

Representa la capacidad física del explorador.

Reglas:

- Explorar consume energía.
- Analizar anomalías consume energía.
- Algunos eventos reducen energía.
- Objetos especiales pueden restaurarla.
- Si llega a cero, la partida termina.

### Estabilidad

Representa la resistencia mental frente a las anomalías dimensionales.

Reglas:

- Algunas zonas reducen estabilidad.
- Las anomalías pueden afectarla.
- Objetos especiales permiten recuperarla.
- Si llega a cero, la sesión termina.

### Sistema de pistas IRIS

Actualmente existen tres pistas.

La evolución propuesta incorpora:

- Fragmentos de historia.
- Registros ocultos.
- Archivos secretos de IRIS.
- Desbloqueo de nuevas realidades.

### Sistema de misiones

Se incorporarán misiones principales y secundarias.

Ejemplos:

**Primer Contacto**
- Encontrar tres fragmentos de IRIS.

**Investigación Dimensional**
- Analizar cinco anomalías.

**Distorsión Temporal**
- Explorar diez sectores desconocidos.

Las misiones otorgarán experiencia, objetos y acceso a nuevas zonas.

### Sistema de inventario

Objetos consumibles:

- Batería Energética (+20 energía)
- Estimulante Mental (+15 estabilidad)
- Kit de Reparación

Objetos especiales:

- Fragmento IRIS
- Llave Dimensional
- Artefacto Cuántico

### Sistema de experiencia y niveles

El jugador obtendrá experiencia al:

- Explorar sectores.
- Completar misiones.
- Analizar anomalías.

Ejemplos:

Nivel 2:
- +10 Energía máxima.

Nivel 3:
- Menor consumo energético.

Nivel 4:
- Mayor resistencia mental.

Nivel 5:
- Acceso a nuevas realidades.

### Sistema de habilidades

Se propone un árbol de progresión.

Explorador:
- Menor consumo de energía.

Científico:
- Mayor probabilidad de encontrar pistas.

Ingeniero:
- Mejora de objetos obtenidos.

### Sistema de anomalías avanzadas

Tipos propuestos:

- Anomalía energética.
- Anomalía mental.
- Anomalía temporal.
- Anomalía beneficiosa.
- Anomalía IRIS.

### Mapa de realidades

Actualmente existe un mapa 3x3.

La evolución propone:

- Mapas 10x10.
- Mapas 15x15.
- Mapas 20x20.

Cada sector podrá contener:

- Anomalías.
- Recursos.
- Misiones.
- Eventos.
- Portales.

### Eventos aleatorios

Durante la exploración podrán ocurrir:

- Tormentas dimensionales.
- Colapso energético.
- Mensajes secretos de IRIS.
- Tecnología antigua.
- Recursos raros.

### Sistema narrativo

Las pistas encontradas formarán una historia progresiva.

El jugador descubrirá:

- Registros de exploradores.
- Información sobre IRIS.
- El origen del Nexus.
- La verdadera naturaleza de las realidades alternativas.

---

## Diseño de pantallas

### Pantalla 1: Menú principal

- Nueva partida
- Continuar
- Configuración
- Salir

### Pantalla 2: Exploración

Elementos visibles:

- Barra de energía.
- Barra de estabilidad.
- Mapa interactivo.
- Botones de exploración.
- Inventario.
- Misiones.

### Pantalla 3: Misiones

Mostrará:

- Misiones activas.
- Objetivos.
- Recompensas.
- Estado de avance.

### Pantalla 4: Inventario

Mostrará:

- Objetos obtenidos.
- Cantidades.
- Descripción.
- Uso de consumibles.

### Pantalla 5: Estadísticas

Mostrará:

- Sectores explorados.
- Misiones completadas.
- Tiempo de juego.
- Anomalías analizadas.

---

## Experiencia de usuario

### Legibilidad

- Fuentes claras.
- Alto contraste.
- Información organizada.

### Jerarquía visual

Prioridad visual:

1. Energía.
2. Estabilidad.
3. Mapa.
4. Objetivos.

### Retroalimentación

Cada acción informará sus consecuencias mediante mensajes visuales.

Ejemplos:

- Exploración completada.
- Anomalía detectada.
- Pista obtenida.
- Misión completada.

### Navegación

La navegación se realizará mediante botones gráficos y ventanas organizadas.

---

## Alcance y restricciones

### Funcionalidades prioritarias

- Exploración.
- Gestión de energía.
- Gestión de estabilidad.
- Sistema de misiones.
- Inventario.
- Guardado de partidas.
- Persistencia SQL Server.

### Funcionalidades opcionales

- Sistema de logros.
- Fabricación de objetos.
- Habilidades avanzadas.
- Múltiples finales.

### Restricciones técnicas

- Desarrollo en C#.
- Windows Forms.
- SQL Server.
- Compatibilidad con laboratorios académicos.

---

## Conclusión

La propuesta mantiene todas las mecánicas desarrolladas en H3 y las amplía con una interfaz gráfica, almacenamiento persistente y sistemas de progreso que transforman el prototipo de consola en un videojuego completo y escalable.
