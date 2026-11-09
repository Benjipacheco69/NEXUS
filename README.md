# NEXUS

**NEXUS** es un videojuego de exploración y supervivencia desarrollado en C# como proyecto académico de Programación Orientada a Objetos (POO). La historia se desarrolla en el año 2297: un cadete debe explorar una realidad desconocida, investigar una anomalía, enfrentarse a entidades y regresar al punto de extracción.

## Objetivo del proyecto

Aplicar conceptos de programación orientada a objetos mediante un juego interactivo ejecutado en consola, con mecánicas de exploración, administración de recursos, inventario, combate y cumplimiento de una misión.

## Funcionalidades implementadas

- **Creación del cadete:** ingreso de nombre, edad, energía y estabilidad inicial.
- **Exploración:** desplazamiento por un mapa de 3 × 3 mediante norte, sur, este y oeste.
- **Gestión de recursos:** control de energía, estabilidad, escudo, ataque y experiencia (XP).
- **Eventos aleatorios:** hallazgo de objetos, aparición de enemigos o robots, distorsiones de realidad, pérdida de recursos y pistas de IRIS.
- **Inventario:** capacidad máxima de ocho objetos; permite consultar y utilizar células de energía, escudos, módulos de ataque y analizadores.
- **Combate:** enfrentamientos contra criaturas, robots y el guardián de la anomalía. Cada tipo de entidad tiene comportamientos propios.
- **Análisis:** consulta de información de las entidades cuando se dispone de un analizador.
- **Misión principal:** llegar a la anomalía, encontrar el núcleo energético, sobrevivir al encuentro con la entidad y regresar al punto de extracción.
- **Menú de juego:** opciones para moverse, analizar, descansar, consultar estado, mapa, inventario, atacar, escapar, revisar la misión y salir.

## Tecnologías y requisitos

- **Lenguaje:** C#.
- **Plataforma:** .NET 10 (`net10.0`).
- **Tipo de aplicación:** consola.
- **Entorno recomendado:** Visual Studio Community con el SDK de .NET 10 instalado.
- **Control de versiones:** Git y GitHub.

El proyecto no requiere una base de datos ni conexión a Internet para ejecutar sus mecánicas principales. No incluye interfaz gráfica ni almacenamiento persistente de partidas.

## Estructura del repositorio

```text
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
```

> La carpeta `docs/` contiene la documentación del proyecto. Consulta los archivos existentes directamente en esa carpeta para revisar el diseño, análisis, propuestas y evidencias.

## Cómo ejecutar el proyecto

### Requisitos previos

1. Instalar el **SDK de .NET 10**.
2. Descargar o clonar este repositorio.
3. Abrir una terminal en la carpeta raíz del repositorio.

### Ejecución desde la terminal

Ejecuta los siguientes comandos en orden:

```bash
dotnet restore "POO Nexus/POO Nexus.csproj"
dotnet build "POO Nexus/POO Nexus.csproj"
dotnet run --project "POO Nexus/POO Nexus.csproj"
```

También puedes abrir el archivo `POO Nexus.slnx` con una versión compatible de Visual Studio, establecer el proyecto **POO Nexus** como proyecto de inicio y ejecutar con **F5**.

## Conceptos de programación orientada a objetos

El código organiza las responsabilidades en clases como `Juego`, `Personaje`, `Cadete`, `Enemigo`, `Robot`, `Inventario`, `Objeto`, `Mapa` y `Mision`.

- **Abstracción:** la clase base abstracta `Personaje` define características y comportamientos comunes.
- **Encapsulamiento:** los atributos se mantienen privados y se accede a ellos mediante métodos.
- **Herencia:** `Cadete`, `Enemigo` y `Robot` derivan de `Personaje`.
- **Polimorfismo:** las entidades redefinen comportamientos como recibir daño, reaccionar y mostrar información.
- **Composición:** `Cadete` utiliza un inventario y `Juego` coordina los objetos principales de la partida.

## Estado y alcance

Este repositorio contiene el código fuente y los archivos de proyecto necesarios para restaurar, compilar y ejecutar la aplicación. Los comandos anteriores describen el procedimiento de ejecución; la compilación y las pruebas deben realizarse en un entorno que tenga instalado el SDK de .NET 10.

## Control de versiones

Los cambios del proyecto se registran en Git mediante commits descriptivos. El archivo `.gitignore` excluye archivos temporales y resultados de compilación de Visual Studio y .NET, como las carpetas `bin/`, `obj/` y `.vs/`.

## Autoría

Proyecto académico **NEXUS** — Programación Orientada a Objetos.
