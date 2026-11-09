# Arquitectura Actual de NEXUS

## Descripción general

La versión actual de NEXUS fue desarrollada como una aplicación de consola en C#. El sistema permite registrar un explorador, explorar realidades, administrar energía y estabilidad, encontrar pistas y visualizar un mapa.

Toda la lógica se encuentra dentro de una única clase llamada Program.

## Estructura actual

Program

- Main()
- InicializarMapa()
- ExplorarMapa()
- MostrarMapa()
- MostrarEstado()
- DibujarBarra()

## Funcionalidades implementadas

### Registro del explorador

Solicita:

- Nombre
- Edad
- Energía inicial
- Estabilidad inicial

### Exploración

- Incrementa profundidad.
- Consume energía.
- Reduce estabilidad.
- Actualiza el mapa.

### Análisis de anomalías

- Consume energía.
- Obtiene pistas de IRIS.

### Recuperación de energía

- Restaura energía hasta un máximo de 100.

### Mapa

Se implementa mediante una matriz bidimensional de caracteres:

char[,]

Tamaño actual:

3x3

### Estado del jugador

Muestra:

- Nombre
- Edad
- Energía
- Estabilidad
- Profundidad
- Pistas obtenidas

## Limitaciones actuales

### Arquitectura monolítica

Toda la lógica está concentrada en Program.

### Ausencia de clases especializadas

No existen clases para:

- Jugador
- Inventario
- Misión
- Partida
- Anomalía

### Sin persistencia

No existe:

- Base de datos.
- Guardado de partidas.
- Recuperación de progreso.

### Interfaz limitada

La interacción ocurre exclusivamente por consola.

## Conclusión

La versión H3 demuestra el funcionamiento básico del juego pero requiere una reorganización para soportar una interfaz gráfica y nuevas funcionalidades.
