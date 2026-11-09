# NEXUS

**NEXUS** es un videojuego de exploración, supervivencia y combate desarrollado en C# como proyecto académico de Programación Orientada a Objetos. La versión H3/v2.0 es una aplicación de consola funcional que sirve como base para su evolución a una aplicación de escritorio con **Windows Forms y SQL Server**.

La evolución debe conservar la identidad, los personajes, las reglas y la misión principal del juego existente. La interfaz gráfica y la persistencia en base de datos son objetivos de las siguientes etapas; todavía no forman parte de la versión de consola incluida en este repositorio.

## Estado del proyecto

| Componente | Estado |
|---|---|
| Juego de consola en C# | Implementado en el código actual |
| Mapa 3 × 3, exploración y eventos | Implementado |
| Cadete, inventario, objetos y combate | Implementado |
| Misión principal y extracción | Implementado |
| Interfaz Windows Forms | Propuesta para la siguiente etapa |
| Persistencia SQL Server | Propuesta para la siguiente etapa |
| Guardar y continuar partidas | Pendiente de implementación |
 
## Funcionalidades implementadas en H3/v2.0

- **Creación del cadete:** nombre, edad, energía y estabilidad iniciales. La inmersión exige edad mínima de 18 años, energía mínima de 30 y estabilidad mínima de 40; los recursos se limitan a un máximo de 100.
- **Exploración:** desplazamiento por un mapa de 3 × 3 mediante norte, sur, este y oeste. Cada movimiento válido consume 5 puntos de energía y 2 de estabilidad.
- **Gestión del personaje:** energía, estabilidad, ataque, escudo, experiencia, zonas exploradas y pistas de IRIS.
- **Eventos aleatorios:** objetos, enemigos, robots, distorsiones, pérdidas de recursos, registros de IRIS o zonas sin eventos.
- **Inventario:** capacidad máxima de ocho objetos. Incluye células de energía, escudos, módulos de ataque y analizadores.
- **Combate:** enfrentamientos contra criaturas, robots y el Guardián de la anomalía. Los enemigos y robots tienen comportamientos distintos.
- **Análisis:** analizar anomalías consume 8 puntos de energía y permite obtener hasta tres pistas de IRIS. Para analizar entidades se necesita un analizador.
- **Misión principal:** llegar a la anomalía situada en la esquina opuesta del mapa, encontrar el núcleo, sobrevivir al Guardián y regresar al punto de extracción.
- **Menú de juego:** movimiento, análisis, descanso, estado, mapa, inventario, uso de objetos, ataque, escape, análisis de entidad, misión y salida.

## Tecnologías de la versión actual

- Lenguaje: C#.
- Plataforma: .NET 10 (net10.0).
- Tipo de aplicación actual: consola.
- Entorno recomendado: Visual Studio Community con SDK de .NET 10.
- Control de versiones: Git y GitHub.

La versión actual no utiliza SQL Server, no contiene formularios Windows Forms y no guarda partidas de forma persistente.

## Arquitectura objetivo

La siguiente etapa transformará el juego en una aplicación de escritorio Windows Forms, manteniendo las reglas de NEXUS y separando responsabilidades:

1. **Presentación:** formularios, botones, mapa visual, barras de recursos y mensajes.
2. **Lógica del juego:** reglas de exploración, combate, inventario, misión y estado del cadete.
3. **Acceso a datos:** repositorios C# para guardar y recuperar partidas.
4. **Persistencia:** SQL Server para jugadores, partidas, mapa, objetivos, encuentros e inventario.

La propuesta detallada, el flujo de interacción y el plan de migración se encuentran en la carpeta docs/.

## Estructura del repositorio

~~~text
NEXUS/
├── README.md
├── .gitignore
├── POO Nexus.slnx
├── POO Nexus/
│   ├── POO Nexus.csproj
│   └── Program.cs
└── docs/
    ├── diseno-del-juego.md
    ├── arquitectura-actual.md
    ├── arquitectura-propuesta.md
    ├── modelo-de-datos-propuesto.md
    ├── analisis-tecnico.md
    ├── implementacion/
    │   └── guia-interaccion-winform.md
    ├── sql/
    │   └── nexus-schema.sql
    └── evidencias/
        ├── README.md
        ├── diagrama-clases.md
        └── flujo-principal.md
~~~

## Cómo ejecutar la versión actual

### Requisitos previos

1. Instalar el SDK de .NET 10.
2. Clonar o descargar este repositorio.
3. Abrir una terminal en la carpeta raíz del repositorio.

### Comandos

~~~bash
dotnet restore "POO Nexus/POO Nexus.csproj"
dotnet build "POO Nexus/POO Nexus.csproj"
dotnet run --project "POO Nexus/POO Nexus.csproj"
~~~

También se puede abrir POO Nexus.slnx con una versión compatible de Visual Studio, seleccionar el proyecto POO Nexus y ejecutar con F5.

## Programación orientada a objetos

El código actual contiene las clases Juego, Personaje, Cadete, Enemigo, Robot, Objeto, Inventario, Mapa y Mision.

- **Abstracción:** Personaje es una clase abstracta con características y comportamientos comunes.
- **Encapsulamiento:** los atributos se mantienen privados y se manipulan mediante métodos.
- **Herencia:** Cadete, Enemigo y Robot derivan de Personaje.
- **Polimorfismo:** las entidades redefinen comportamientos como recibir daño, reaccionar y mostrar información.
- **Composición:** Cadete contiene un Inventario y Juego coordina los objetos de la partida.

Las clases están agrupadas actualmente en Program.cs. La guía de migración propone separarlas en archivos sin alterar sus reglas de juego.

## Alcance y próximos pasos

La documentación describe el estado real del prototipo y especifica la solución futura. La interfaz Windows Forms, la conexión a SQL Server, el guardado/carga y las pruebas de integración deberán implementarse y verificarse en las siguientes etapas. No se consideran funcionalidades terminadas hasta que exista código ejecutable y evidencia de pruebas.

## Autoría

Proyecto académico NEXUS — Programación Orientada a Objetos.
