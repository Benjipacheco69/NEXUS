# Diagrama de clases — NEXUS v2.0

~~~mermaid
classDiagram
 class Personaje {
  <<abstract>>
  -string nombre
  -int energia
  -int ataque
  +RecibirDano(int dano)
  +AlAparecer()
  +Reaccionar(Cadete cadete)
  +MostrarInformacion()*
 }
 class Cadete
 class Enemigo
 class Robot
 class Objeto
 class Inventario
 class Mapa
 class Mision
 class Juego
 Personaje <|-- Cadete
 Personaje <|-- Enemigo
 Personaje <|-- Robot
 Cadete *-- Inventario
 Inventario o-- Objeto
 Juego --> Cadete
 Juego --> Mapa
 Juego --> Mision
 Juego --> Personaje
~~~

Diagrama documental de las relaciones observadas. Las clases siguen agrupadas en Program.cs.
