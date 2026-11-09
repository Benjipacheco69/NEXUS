# Modelo de datos propuesto para NEXUS

## Modelo actual
NEXUS v2.0 no utiliza base de datos. Los datos se mantienen en memoria mediante objetos, listas y arreglos.

| Elemento | Datos principales | Relación |
|---|---|---|
| Personaje | nombre, energía, ataque | Base de Cadete, Enemigo y Robot. |
| Cadete | edad, estabilidad, XP, escudo, zonas, pistas | Contiene Inventario. |
| Objeto | nombre, tipo, valor | Se almacena en Inventario. |
| Inventario | lista y capacidad | Pertenece al Cadete. |
| Mapa | matriz, fila, columna | Coordinado por Juego. |
| Mision | nombre, objetivos, estados, recompensa | Coordinada por Juego. |

~~~text
Personaje (abstracto)
 ├── Cadete ── Inventario ── Objeto
 ├── Enemigo
 └── Robot
Juego ── Cadete / Mapa / Mision / entidad actual
~~~

## Persistencia futura (no implementada)
Podrían crearse entidades Partida, CadeteGuardado, ObjetoCatalogo, InventarioPartida, EstadoMapa, MisionPartida y ObjetivoPartida. Las claves y restricciones dependerán del motor elegido.

No existen tablas SQL, ORM ni guardado de partidas en la versión actual.
