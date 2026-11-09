# Arquitectura actual de NEXUS v2.0

NEXUS es una aplicación de consola en C#. Las clases están agrupadas físicamente en `POO Nexus/Program.cs`; los comentarios internos indican las secciones lógicas.

| Clase | Responsabilidad |
|---|---|
| Program | Punto de entrada; instancia Juego e inicia la partida. |
| Personaje | Clase abstracta con nombre, energía, ataque y comportamiento común. |
| Cadete | Jugador; administra estabilidad, XP, escudo, exploración e inventario. |
| Enemigo | Entidad que contraataca y entrega 20 XP al ser derrotada. |
| Robot | Entidad cuya defensa reduce a la mitad el daño recibido; entrega 30 XP. |
| TipoObjeto / Objeto | Categorías y características de los objetos. |
| Inventario | Lista de objetos con capacidad máxima de ocho. |
| Mapa | Cuadrícula, posición, movimientos y zonas especiales. |
| Mision | Objetivos, progreso y recompensa. |
| Juego | Coordina menú, exploración, eventos, encuentros y finalización. |

## Relaciones y POO
- Cadete, Enemigo y Robot heredan de Personaje.
- Cadete contiene un Inventario; este mantiene objetos Objeto.
- Juego coordina Cadete, Mapa, Mision y una entidad activa Personaje.
- Abstracción: Personaje es abstracta.
- Encapsulamiento: atributos privados y métodos públicos.
- Herencia: especialización de Personaje.
- Polimorfismo: sobrescritura de RecibirDano, AlAparecer, Reaccionar, GetRecompensaXP y MostrarInformacion.
- Composición: Cadete contiene Inventario.

## Flujo
~~~text
Program.Main -> Juego.Iniciar -> CrearCadete y validar
 -> crear Mapa y Mision -> entregar objetos iniciales
 -> ciclo de menú -> ProcesarOpcion -> acciones/eventos/combate
 -> comprobar resultado y finalizar
~~~

## Limitaciones
Las clases están en un solo archivo; Juego combina consola y coordinación; la entrada valida formato numérico pero no todos los rangos; el progreso no se guarda al cerrar; no se incluyen pruebas automatizadas.
