# Análisis técnico de NEXUS

## 1. Objetivo

Justificar la evolución del videojuego NEXUS H3/v2.0 hacia una aplicación de escritorio desarrollada en C# con Windows Forms y SQL Server. La decisión técnica debe responder al código existente y a las mecánicas reales del juego, no a una propuesta genérica.

## 2. Punto de partida técnico

El repositorio contiene una aplicación de consola dirigida a .NET 10. El punto de entrada crea Juego; esta clase coordina Cadete, Mapa, Mision y encuentros. Las clases Personaje, Cadete, Enemigo, Robot, Objeto e Inventario implementan las reglas de entidades, recursos, objetos y combate.

El juego ya tiene un mapa 3×3, movimiento cardinal, energía, estabilidad, eventos aleatorios, inventario de ocho objetos, combate y una misión de cuatro objetivos. No existe todavía interfaz gráfica, base de datos ni guardado persistente.

## 3. Alternativas de interfaz

### Aplicación de consola

Ventajas:
- Es la versión existente y permite validar las reglas.
- Tiene bajo costo de ejecución.
- Es fácil de ejecutar y depurar.

Limitaciones:
- Interacción mediante texto y selección numérica.
- No permite presentar el mapa como una cuadrícula de controles.
- No ofrece paneles simultáneos de recursos, misión, inventario y combate.

### Windows Forms

Ventajas:
- Es una tecnología de escritorio para C# y .NET.
- Permite representar el mapa 3×3 con nueve controles visuales.
- Permite mostrar energía y estabilidad con ProgressBar.
- Permite botones de movimiento y acciones de combate.
- Facilita construir formularios de menú, registro, exploración e inventario.
- Permite separar eventos de interfaz y lógica del juego.

Limitaciones:
- Está orientado a aplicaciones de escritorio Windows.
- No es un motor de videojuegos 3D ni ofrece por sí mismo animaciones complejas.
- Los formularios pueden quedar acoplados si contienen reglas de negocio en sus eventos.
- La lógica actual debe desacoplarse de Console.ReadLine y Console.WriteLine antes de reutilizarse correctamente.

**Decisión:** Windows Forms es adecuado para la siguiente etapa porque el objetivo académico es una aplicación de escritorio C# y el juego se basa en una cuadrícula 3×3, paneles de estado, botones y ventanas. No se necesita un motor 3D para representar la experiencia definida.

### Unity

Ventajas:
- Motor especializado para videojuegos 2D y 3D.
- Herramientas avanzadas de animación, escenas y físicas.

Desventajas para este alcance:
- Requiere migrar la presentación a otro entorno.
- Añade complejidad que no es necesaria para la interfaz de cuadrícula y formularios solicitada.
- No responde tan directamente al objetivo de aplicación de escritorio C# con Windows Forms.

**Decisión:** Unity no se selecciona para esta etapa. Podría evaluarse si el alcance futuro cambia a un videojuego visual 2D/3D.

## 4. Alternativas de persistencia

### Memoria del proceso

Es lo que utiliza el prototipo actual. Es simple, pero al cerrar el programa se pierde todo el estado.

### Archivos locales

Pueden guardar datos serializados, pero requieren diseñar y mantener el formato, las validaciones y la integridad de relaciones.

### SQL Server

Ventajas:
- Almacena datos estructurados y relacionados.
- Permite claves primarias, claves foráneas y restricciones.
- Permite consultar jugadores y partidas.
- Permite transacciones para evitar guardados parciales.
- Se integra con aplicaciones C# mediante Microsoft.Data.SqlClient.

Limitaciones:
- Requiere instalar/configurar un motor o instancia SQL Server.
- La aplicación debe gestionar errores de conexión, permisos y configuración.
- Se deben utilizar consultas parametrizadas y proteger las credenciales.

**Decisión:** SQL Server será el sistema de persistencia para jugadores, partidas, mapa, objetivos, inventario y encuentros. El prototipo de consola no se conectará a la base de datos hasta implementar la nueva capa de infraestructura.

## 5. Tecnología de acceso a datos

Se recomienda Microsoft.Data.SqlClient para conectar C# con SQL Server. Las operaciones se encapsularán en repositorios y no se escribirán consultas SQL dentro de los eventos de botones.

Buenas prácticas:
- Usar SqlConnection, SqlCommand y parámetros.
- No concatenar valores del usuario dentro de consultas SQL.
- Usar transacciones para guardar el estado completo de una partida.
- Disponer conexiones y comandos correctamente.
- No subir contraseñas ni cadenas de conexión con secretos al repositorio.

## 6. Arquitectura seleccionada

Se propone una arquitectura en capas:

| Capa | Responsabilidad | Ejemplos NEXUS |
|---|---|---|
| Presentación | Interacción visual | FrmMenuPrincipal, FrmNuevaPartida, FrmExploracion, FrmInventario |
| Aplicación | Coordinar casos de uso | ServicioPartida |
| Dominio | Reglas del videojuego | Cadete, Personaje, Mapa, Mision, Inventario, Enemigo, Robot |
| Infraestructura | Persistencia | ConexionBD, RepositorioPartida, RepositorioJugador |
| Base de datos | Guardado relacional | SQL Server |

La lógica del dominio no debe depender de Windows Forms ni de SQL Server. La interfaz llama a ServicioPartida y recibe un resultado que utiliza para actualizar los controles.

## 7. Correspondencia entre necesidad y decisión

| Necesidad real del videojuego | Solución técnica |
|---|---|
| Ver el mapa 3×3 | Panel con nueve botones/casillas |
| Moverse N/S/E/O | Cuatro botones conectados al servicio |
| Ver energía y estabilidad | ProgressBar y etiquetas |
| Ver objetivos de misión | Lista con cuatro estados |
| Gestionar objetos | ListView o DataGridView |
| Combatir entidades | Panel con energía de entidad y acciones |
| Continuar una partida | SQL Server y repositorios |
| Recuperar encuentro interrumpido | Registro de EncuentroPartida |

## 8. Riesgos y medidas de mitigación

| Riesgo | Consecuencia | Medida |
|---|---|---|
| Mantener Console en la lógica | Dificulta usar Windows Forms | Devolver resultados y estados en lugar de imprimir |
| Duplicar reglas en formularios | Comportamientos inconsistentes | Centralizar reglas en dominio/ServicioPartida |
| Guardado parcial | Partida inconsistente | Transacción SQL |
| No guardar encuentro activo | Se pierde el combate al continuar | Persistir entidad, energía, ataque y defensa |
| Credenciales expuestas | Acceso no autorizado | Configuración local segura y .gitignore |
| Eventos aleatorios difíciles de probar | Pruebas no reproducibles | Inyectar generador aleatorio en pruebas |
| Cambio de reglas durante migración | Se altera el juego H3 | Pruebas de regresión y tabla de reglas |

## 9. Decisiones fuera del alcance actual

No se implementarán en esta etapa mapas de tamaños superiores, niveles, habilidades, crafting, misiones secundarias, multijugador ni gráficos 3D. No son requisitos del juego base y podrían comprometer la coherencia con el código H3/v2.0.

## 10. Conclusión

Windows Forms y SQL Server son decisiones coherentes con la consigna y con las características actuales de NEXUS. Windows Forms permite convertir las opciones de consola en controles de escritorio; SQL Server permite guardar el estado que hoy solo existe en memoria. La condición técnica esencial es desacoplar primero la lógica del videojuego de la consola y reutilizar las reglas actuales sin duplicarlas.

## 11. Referencias técnicas oficiales

- Microsoft Learn — Windows Forms para .NET: https://learn.microsoft.com/dotnet/desktop/winforms/
- Microsoft Learn — Crear una aplicación Windows Forms: https://learn.microsoft.com/dotnet/desktop/winforms/get-started/create-app-visual-studio
- Microsoft Learn — Microsoft.Data.SqlClient: https://learn.microsoft.com/sql/connect/ado-net/introduction-microsoft-data-sqlclient-namespace
- Microsoft Learn — Transacciones locales en ADO.NET: https://learn.microsoft.com/dotnet/framework/data/adonet/local-transactions
- Microsoft Learn — C# y .NET: https://learn.microsoft.com/dotnet/
