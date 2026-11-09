# Diagrama de clases de NEXUS

## 1. Modelo de clases actual H3/v2.0

Las clases existen en el archivo POO Nexus/Program.cs. El diagrama representa las relaciones que se observan en el código actual.

~~~mermaid
classDiagram
 class Program {
  +Main(args)
 }
 class Juego {
  -Cadete jugador
  -Mapa mapa
  -Mision mision
  -Personaje entidadActual
  -bool enfrentandoGuardian
  -bool terminado
  +Iniciar()
  -CrearCadete()
  -Moverse()
  -Atacar()
  -Escapar()
  -UsarObjeto()
 }
 class Personaje {
  <<abstract>>
  -string nombre
  -int energia
  -int ataque
  +RecibirDano(dano)
  +AlAparecer()
  +Reaccionar(cadete)
  +GetRecompensaXP()
  +MostrarInformacion()
 }
 class Cadete {
  -int edad
  -int estabilidad
  -int xp
  -int escudo
  -int zonasExploradas
  -int pistasIris
  -Inventario inventario
  +Explorar()
  +AnalizarAnomalia()
  +Atacar(objetivo)
  +UsarObjeto(numero)
 }
 class Enemigo
 class Robot {
  -bool defensaActiva
 }
 class Objeto {
  -string nombre
  -TipoObjeto tipo
  -int valor
 }
 class Inventario {
  -List~Objeto~ objetos
  -int capacidad
  +Agregar(objeto)
  +Obtener(numero)
  +Eliminar(numero)
  +Tiene(tipo)
 }
 class Mapa {
  -char[,] celdas
  -int fila
  -int columna
  +Mover(direccion)
  +EnExtraccion()
  +EnAnomalia()
  +Mostrar()
 }
 class Mision {
  -string nombre
  -string[] objetivos
  -bool[] cumplidos
  -int recompensaXP
  +Cumplir(indice)
  +EstaCompleta()
  +Mostrar()
 }
 Program --> Juego
 Juego --> Cadete
 Juego --> Mapa
 Juego --> Mision
 Juego --> Personaje
 Personaje <|-- Cadete
 Personaje <|-- Enemigo
 Personaje <|-- Robot
 Cadete *-- Inventario
 Inventario o-- Objeto
~~~

## 2. Organización física objetivo

En la siguiente etapa se propone separar las clases actuales en archivos propios y mantenerlas dentro de una capa de dominio. ServicioPartida será la fachada que los formularios utilizarán. Los repositorios se encargarán de SQL Server.

~~~mermaid
classDiagram
 class FrmExploracion
 class ServicioPartida {
  +CrearPartida(datos)
  +Mover(direccion)
  +Atacar()
  +Escapar()
  +UsarObjeto(id)
  +ObtenerEstado()
  +GuardarPartida()
  +CargarPartida(id)
 }
 class Juego
 class Cadete
 class Mapa
 class Mision
 class Inventario
 class RepositorioPartida {
  +Guardar(estado)
  +Cargar(id)
 }
 class ConexionBD
 FrmExploracion --> ServicioPartida
 ServicioPartida --> Juego
 Juego --> Cadete
 Juego --> Mapa
 Juego --> Mision
 Cadete *-- Inventario
 ServicioPartida --> RepositorioPartida
 RepositorioPartida --> ConexionBD
~~~

## 3. Notas de interpretación

- El primer diagrama describe el código actual, no una arquitectura ya separada en proyectos.
- El segundo diagrama es una propuesta para la etapa Windows Forms + SQL Server.
- No se debe duplicar la lógica del juego en los formularios.
- Antes de conectar la interfaz, las salidas de consola deben sustituirse por resultados que la interfaz pueda mostrar.
