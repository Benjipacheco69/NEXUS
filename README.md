# NEXUS v2.0

## Descripción
NEXUS es un juego de exploración y supervivencia desarrollado en C#. El jugador controla a un cadete que debe investigar una anomalía en una realidad desconocida, administrar sus recursos, enfrentar entidades y regresar al punto de extracción.

## Objetivo del juego
Completar la misión **La anomalía perdida**:
1. Llegar a la zona de anomalía.
2. Encontrar el núcleo energético.
3. Sobrevivir al encuentro con la entidad.
4. Regresar al punto de extracción.

## Funcionalidades implementadas
- Registro y validación inicial del cadete.
- Exploración de un mapa de 3 × 3.
- Movimiento en cuatro direcciones con control de límites.
- Eventos aleatorios y hallazgo de objetos.
- Administración de energía, estabilidad, escudo y experiencia.
- Inventario con capacidad máxima de ocho objetos.
- Combate contra enemigos, robots y el guardián de la anomalía.
- Análisis de entidades mediante el analizador.
- Seguimiento de objetivos y recompensa por completar la misión.

## Tecnologías
- **Lenguaje:** C#.
- **Plataforma:** .NET 10 (`net10.0`).
- **Entorno recomendado:** Visual Studio compatible con .NET 10 o terminal con el SDK .NET 10.
- **Tipo de aplicación:** consola.

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
    └── evidencias/
        ├── README.md
        ├── diagrama-clases.md
        └── flujo-principal.md
~~~

**Nota:** las clases del código actual están agrupadas en `POO Nexus/Program.cs`. La separación en archivos y carpetas es una propuesta de mejora, no la estructura implementada.

## Cómo ejecutar el proyecto

### Desde Visual Studio
1. Clona o descarga este repositorio.
2. Abre `POO Nexus.slnx` con una versión de Visual Studio compatible con .NET 10.
3. Espera la restauración de dependencias.
4. Ejecuta el proyecto.

### Desde la terminal
Abre una terminal en la carpeta raíz del repositorio y ejecuta:

~~~bash
dotnet restore "POO Nexus/POO Nexus.csproj"
dotnet build "POO Nexus/POO Nexus.csproj"
dotnet run --project "POO Nexus/POO Nexus.csproj"
~~~

## Documentación técnica
La carpeta [docs](docs/) contiene la documentación del proyecto:

- [Diseño del juego](docs/diseno-del-juego.md): historia, reglas, mapa, menú, recursos y objetivos.
- [Arquitectura actual](docs/arquitectura-actual.md): clases, responsabilidades, relaciones y POO aplicada.
- [Arquitectura propuesta](docs/arquitectura-propuesta.md): organización modular y mejoras futuras.
- [Modelo de datos propuesto](docs/modelo-de-datos-propuesto.md): modelo en memoria y posible persistencia futura.
- [Análisis técnico](docs/analisis-tecnico.md): fortalezas, limitaciones y pruebas recomendadas.
- [Evidencias](docs/evidencias/README.md): diagramas y espacio para capturas reales.

## Alcance y limitaciones
La versión actual funciona por consola. No incorpora interfaz gráfica, base de datos, conexión en red ni guardado persistente de partidas. Las mejoras descritas en los documentos de arquitectura y modelo de datos son propuestas futuras.

## Autoría
Proyecto académico de Programación Orientada a Objetos (POO).
