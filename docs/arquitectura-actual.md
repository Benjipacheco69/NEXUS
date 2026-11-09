# Arquitectura actual de NEXUS H3/v2.0

## 1. Descripción general

La versión existente de NEXUS es una aplicación de consola escrita en C# y dirigida a .NET 10. El punto de entrada crea un objeto Juego y ejecuta su método Iniciar. El juego ya utiliza varias clases de Programación Orientada a Objetos; no es correcto describirlo como una aplicación formada únicamente por la clase Program.

Las clases están agrupadas físicamente en el archivo POO Nexus/Program.cs. Por tanto, existe separación lógica de responsabilidades mediante clases, pero todavía no existe separación en archivos, proyectos o capas.

## 2. Estructura de clases observada

| Clase | Responsabilidad actual |
|---|---|
| Program | Punto de entrada. Crea Juego y llama a Iniciar. |
| Personaje | Clase abstracta base. Define nombre, energía, ataque, daño, reacción e información. |
| Cadete | Personaje controlado por el usuario. Gestiona edad, estabilidad, XP, escudo, exploración, pistas e inventario. |
| Enemigo | Entidad que contraataca y entrega 20 XP al ser derrotada. |
| Robot | Entidad con defensa activa que reduce a la mitad el daño recibido; entrega 30 XP. |
| Objeto | Representa un objeto, su tipo y valor. |
| Inventario | Administra una lista de objetos con capacidad máxima de ocho. |
| Mapa | Mantiene una matriz de caracteres 3×3, posición del cadete y validación de movimiento. |
| Mision | Mantiene nombre, objetivos, estado de cumplimiento y recompensa XP. |
| Juego | Coordina registro, mapa, misión, menú, exploración, eventos, encuentros y finalización. |

### Relaciones principales

- Cadete hereda de Personaje.
- Enemigo hereda de Personaje.
- Robot hereda de Personaje.
- Cadete contiene un Inventario.
- Inventario administra objetos Objeto.
- Juego coordina Cadete, Mapa, Mision y la entidad actual (Personaje).
- Mision contiene cuatro objetivos y sus indicadores de cumplimiento.

## 3. Flujo de ejecución actual

1. Program.Main crea Juego.
2. Juego.Iniciar presenta la introducción y solicita datos del cadete.
3. CrearCadete valida edad, energía y estabilidad.
4. Si se autoriza la inmersión, se crea Mapa(3), la misión La anomalía perdida y se entregan una célula de energía (+25) y un analizador.
5. Se muestra el menú dentro de un ciclo mientras la partida no haya terminado y el cadete conserve energía y estabilidad.
6. ProcesarOpcion deriva la selección a los métodos de juego.
7. El juego muestra el resultado de victoria, derrota o salida.

## 4. Reglas implementadas que debe preservar la migración

### Cadete y recursos

- Energía y estabilidad iniciales deben cumplir los mínimos 30 y 40; edad mínima 18.
- Energía máxima: 100.
- Ataque inicial: 10.
- Escudo y XP iniciales: 0.
- Movimiento válido: energía -5, estabilidad -2 y zonas exploradas +1.
- Analizar anomalía: energía -8 y una pista IRIS, con máximo de tres.
- Descansar: energía +15, limitada a 100.
- Escapar: energía -5 y resultado aleatorio.
- El escudo absorbe el daño antes de reducir energía.

### Mapa y misión

- Mapa 3×3; extracción en (0,0), anomalía en (2,2).
- No se permite salir de los límites del mapa.
- La misión exige llegar a anomalía, encontrar el núcleo, sobrevivir al Guardián y volver a extracción.
- La recompensa de misión es 100 XP y un módulo desconocido que añade 10 al ataque.

### Entidades y objetos

- Criatura: 30 de energía y 10 de ataque; recompensa 20 XP.
- Robot centinela: 30 de energía y 6 de ataque; defensa que reduce a la mitad el daño recibido; recompensa 30 XP.
- Guardián: se instancia como Enemigo con 50 de energía y 10 de ataque.
- Inventario: máximo ocho objetos individuales.
- Célula: +25 energía; escudo: +20 protección; módulo: +5 ataque; analizador: permite analizar entidades y no se consume.

## 5. Acoplamiento actual a la consola

La lógica y la interacción están acopladas porque muchas clases llaman directamente a Console.WriteLine y Juego utiliza Console.ReadLine para solicitar decisiones. Algunos métodos de clases de dominio también imprimen mensajes y leen datos indirectamente mediante el flujo de Juego.

Este acoplamiento es la principal tarea técnica de la migración: Windows Forms no debe depender de Console.ReadLine ni mostrar resultados mediante Console.WriteLine. Las reglas del juego deben devolver resultados o estados que los formularios puedan presentar.

## 6. Persistencia actual

No existe conexión a SQL Server ni mecanismo de guardado/carga. El estado del cadete, el mapa, el inventario, la misión y los encuentros viven en memoria durante la ejecución. Al cerrar el programa se pierde la partida.

## 7. Limitaciones y riesgos identificados

1. Las clases están agrupadas en un único archivo.
2. Las reglas de negocio están mezcladas con mensajes de consola.
3. Los métodos de Juego que procesan acciones son privados y deben exponerse a través de una interfaz de servicio controlada para Windows Forms.
4. No existe persistencia ni recuperación de encuentros activos.
5. La aleatoriedad dificulta repetir exactamente un escenario durante pruebas; conviene permitir inyectar una fuente aleatoria en pruebas automatizadas.
6. La solución actual es de consola; cambiar el proyecto existente directamente a Windows Forms sin crear formularios y adaptar el punto de entrada rompería la ejecución actual.

## 8. Base que se reutilizará

Se deben conservar las reglas y las responsabilidades de Personaje, Cadete, Enemigo, Robot, Objeto, Inventario, Mapa, Mision y Juego. La migración puede mover las clases a archivos separados y sustituir las salidas de consola por resultados estructurados, pero no debe alterar costos, recompensas, límites, posiciones ni condiciones de victoria sin una decisión de diseño documentada.

## 9. Conclusión

NEXUS H3/v2.0 ya cuenta con un modelo orientado a objetos y un ciclo de juego definido, aunque todavía ejecutado en consola. La siguiente etapa debe desacoplar la lógica de la interfaz, crear la presentación Windows Forms y agregar persistencia SQL Server sin perder la compatibilidad conceptual con el juego existente.
