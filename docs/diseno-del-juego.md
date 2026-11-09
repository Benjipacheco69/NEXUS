# Diseño del juego NEXUS v2.0

## Concepto
NEXUS es un juego de exploración y supervivencia para consola, ambientado en el año 2297. El jugador controla a un cadete que investiga una anomalía en una realidad desconocida y debe regresar al punto de extracción.

## Objetivo
Completar la misión «La anomalía perdida»: llegar a la zona de anomalía, encontrar el núcleo energético, sobrevivir al encuentro con la entidad y regresar a extracción.

## Requisitos de inmersión
- Edad mínima: 18 años.
- Energía inicial mínima: 30.
- Estabilidad inicial mínima: 40.
- Energía y estabilidad superiores a 100 se ajustan a 100.
- Si no se cumplen los requisitos, la inmersión se rechaza.

## Mapa y exploración
El mapa es una cuadrícula de 3 × 3. El cadete comienza en la esquina superior izquierda (extracción) y la anomalía se encuentra en la esquina inferior derecha. Los movimientos disponibles son norte (N), sur (S), este (E) y oeste (O). No se permite salir de los límites.

Cada movimiento válido consume 5 puntos de energía y 2 de estabilidad. Las zonas visitadas se marcan con X; E representa extracción y J la posición actual al mostrar el mapa.

## Menú
| Opción | Función |
|---|---|
| 1 | Moverse y explorar |
| 2 | Analizar anomalía |
| 3 | Recuperar energía |
| 4 | Mostrar estado |
| 5 | Mostrar mapa |
| 6 | Ver inventario |
| 7 | Usar objeto |
| 8 | Atacar |
| 9 | Escapar |
| 10 | Analizar entidad |
| 11 | Ver misión |
| 0 | Salir |

## Recursos y objetos
- **Célula de energía:** recupera 25 puntos de energía.
- **Escudo:** añade 20 puntos de protección.
- **Módulo de ataque:** aumenta el ataque en 5.
- **Analizador:** permite consultar información de una entidad.
- **Descanso:** recupera 15 puntos de energía.
- **Análisis de anomalía:** consume 8 puntos de energía e intenta obtener una pista IRIS.
- **Inventario:** capacidad máxima de ocho objetos.

## Eventos aleatorios
Al explorar pueden aparecer objetos, robots, enemigos, distorsiones que reducen estabilidad, fugas de energía, daños al sistema, registros IRIS o zonas sin eventos.

## Combate
El cadete puede atacar, usar objetos, analizar una entidad o escapar. Los enemigos contraatacan; el robot activa una defensa que reduce a la mitad el daño recibido. Escapar consume 5 puntos de energía y tiene una probabilidad del 50 % de éxito.

- Enemigo derrotado: 20 XP.
- Robot derrotado: 30 XP.
- Misión completada: 100 XP y un módulo de ataque de valor 10.

## Alcance
El juego es una aplicación de consola. No implementa interfaz gráfica, conexión en red, base de datos ni guardado persistente de partidas.
