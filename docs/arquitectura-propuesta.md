# Arquitectura propuesta para NEXUS de escritorio

## 1. Objetivo

Evolucionar el videojuego existente NEXUS H3/v2.0 desde consola hacia una aplicación de escritorio C# con Windows Forms y SQL Server. La evolución debe reutilizar las clases y reglas actuales, desacoplar la lógica de la consola y agregar guardado/carga de partidas.

Esta arquitectura es una propuesta de implementación para las siguientes etapas. No afirma que los formularios ni la base de datos ya estén implementados.

## 2. Principios de diseño

1. **Continuidad del juego:** mantener el mapa 3×3, recursos, eventos, objetos, entidades, combate y misión actual.
2. **Separación de responsabilidades:** la interfaz no debe contener reglas de combate o exploración.
3. **Reutilización:** adaptar las clases existentes antes de crear sistemas nuevos que dupliquen sus responsabilidades.
4. **Persistencia consistente:** una partida debe poder reconstruirse con el mismo estado después de cerrarla y volver a abrirla.
5. **Interacción por eventos:** los controles Windows Forms invocan servicios de aplicación; no llaman directamente a SQL ni modifican atributos privados del dominio.

## 3. Diagrama de arquitectura

~~~mermaid
flowchart TD
 UI[Windows Forms: formularios y controles] --> APP[Servicios de aplicación / controlador de partida]
 APP --> DOM[Dominio: Cadete, Juego, Mapa, Mision, Inventario y entidades]
 APP --> REP[Repositorios de persistencia]
 REP --> DB[(SQL Server)]
 APP --> UI
~~~

La capa de dominio no debe depender de Windows Forms ni de SQL Server. La capa de presentación no debe ejecutar consultas SQL.

## 4. Organización propuesta de la solución

Se recomienda mantener el prototipo de consola como referencia histórica y agregar un proyecto de escritorio a la solución:

~~~text
NEXUS/
├── POO Nexus.slnx
├── POO Nexus/                     # Prototipo H3/v2.0 de consola
│   ├── POO Nexus.csproj
│   └── Program.cs
├── NEXUS.WinForms/                # Nuevo proyecto de escritorio
│   ├── NEXUS.WinForms.csproj
│   ├── Program.cs
│   ├── Forms/
│   │   ├── FrmMenuPrincipal.cs
│   │   ├── FrmNuevaPartida.cs
│   │   ├── FrmExploracion.cs
│   │   ├── FrmInventario.cs
│   │   └── FrmResultado.cs
│   ├── Application/
│   │   └── ServicioPartida.cs
│   ├── Domain/
│   │   ├── Personaje.cs
│   │   ├── Cadete.cs
│   │   ├── Enemigo.cs
│   │   ├── Robot.cs
│   │   ├── Objeto.cs
│   │   ├── Inventario.cs
│   │   ├── Mapa.cs
│   │   ├── Mision.cs
│   │   └── Juego.cs
│   └── Infrastructure/
│       ├── ConexionBD.cs
│       ├── RepositorioJugador.cs
│       └── RepositorioPartida.cs
└── docs/
~~~

La estructura es orientativa. Si se decide crear una biblioteca de clases independiente para Domain, deberá referenciarse desde el proyecto WinForms. No se debe copiar y mantener dos implementaciones distintas de las reglas del juego.

## 5. Proyecto Windows Forms

Configuración técnica objetivo:
- SDK de proyecto: Microsoft.NET.Sdk.
- Target framework: net10.0-windows.
- UseWindowsForms: true.
- OutputType: WinExe.
- Lenguaje: C#.

El proyecto WinForms debe tener su propio punto de entrada que inicialice ApplicationConfiguration y abra FrmMenuPrincipal. No se debe cambiar el proyecto de consola a WinExe mientras siga dependiendo de su Main actual y no exista el nuevo formulario de inicio.

Para SQL Server se recomienda utilizar el paquete Microsoft.Data.SqlClient y consultas parametrizadas.

## 6. Capa de presentación: formularios y controles

### FrmMenuPrincipal

Controles:
- btnNuevaPartida.
- btnContinuar.
- btnSalir.

Comportamiento:
- Nueva partida abre FrmNuevaPartida.
- Continuar consulta partidas guardadas disponibles; si no hay, muestra un mensaje.
- Salir solicita confirmación si existe una partida en curso sin guardar.

### FrmNuevaPartida

Controles:
- txtNombre.
- nudEdad.
- nudEnergia.
- nudEstabilidad.
- btnIniciar.
- lblValidacion.

Comportamiento:
- Validar nombre no vacío.
- Validar edad >= 18, energía >= 30 y estabilidad >= 40.
- Limitar energía y estabilidad a 100.
- Si la validación falla, mostrar el motivo y permanecer en el formulario.
- Si es válida, crear el estado inicial del Cadete, el Mapa(3), la Mision y los objetos iniciales (célula y analizador), y abrir FrmExploracion.

### FrmExploracion

Distribución:
- PanelMapa: nueve botones o controles visuales, uno por casilla del mapa 3×3.
- PanelEstado: etiquetas y ProgressBar para energía y estabilidad; etiquetas para ataque, escudo, XP, nombre y pistas.
- PanelMision: cuatro objetivos y su estado.
- lstRegistro: mensajes de acciones y eventos.
- Botones de movimiento: Norte, Sur, Este y Oeste.
- Botones de acción: Analizar anomalía, Descansar, Inventario, Estado y Misión.

Interacción:
1. El usuario pulsa una dirección.
2. El formulario llama a ServicioPartida.Mover(direccion).
3. El servicio valida límites y encuentro activo, ejecuta el movimiento y resuelve la zona/evento.
4. El servicio devuelve un resultado con mensajes y estado actualizado.
5. El formulario refresca mapa, recursos, objetivos, controles habilitados y registro.
6. Si aparece una entidad, se habilitan las acciones de encuentro y se deshabilitan movimiento, descanso y análisis de anomalía.

### Panel o modo de combate en FrmExploracion

Controles:
- lblEntidadNombre.
- ProgressBar de energía de la entidad.
- btnAtacar.
- btnUsarObjeto.
- btnEscapar.
- btnAnalizarEntidad.

Reglas de interacción:
- Atacar ejecuta el ataque del Cadete; si la entidad sobrevive, se procesa su reacción.
- Usar objeto permite seleccionar un objeto válido del inventario y aplicar su efecto.
- Escapar descuenta 5 de energía y muestra si el intento tuvo éxito; si falla, la entidad reacciona.
- Analizar entidad solo está disponible si existe una entidad y el Cadete posee un Analizador.
- Al derrotar la entidad se actualiza XP, se limpia el encuentro y, si era el Guardián, se marca el tercer objetivo.
- Durante el encuentro no se permite movimiento, descanso ni análisis de anomalía.

### FrmInventario

Controles:
- DataGridView o ListView para objetos.
- Columna de nombre, tipo y efecto.
- btnUsar y btnCerrar.

Comportamiento:
- Mostrar los objetos individuales y respetar la capacidad máxima de ocho.
- El usuario selecciona un objeto y pulsa Usar.
- El servicio aplica el efecto. Célula, Escudo y Módulo de ataque se consumen; Analizador no se consume.
- Actualizar la vista después de usar un objeto.

### FrmResultado

Muestra victoria, derrota o salida voluntaria; resumen de XP, objetivos y estado final. Permite regresar al menú y guardar el resultado.

## 7. Capa de aplicación y dominio

### ServicioPartida

Actúa como fachada entre formularios y dominio. Operaciones previstas:
- CrearPartida(datosCadete).
- Mover(direccion).
- AnalizarAnomalia().
- Descansar().
- Atacar().
- Escapar().
- AnalizarEntidad().
- UsarObjeto(id o índice seleccionado).
- ObtenerEstado().
- ObtenerMapa().
- ObtenerInventario().
- ObtenerMision().
- GuardarPartida().
- CargarPartida(idPartida).

Debe devolver resultados estructurados (por ejemplo, éxito, mensajes, estado actualizado y si existe encuentro) en lugar de escribir directamente en la consola.

### Adaptación de clases existentes

| Clase actual | Responsabilidad que conserva |
|---|---|
| Personaje | Datos y comportamiento común de entidades |
| Cadete | Recursos, ataque, escudo, XP, pistas e inventario |
| Enemigo | Reacción y recompensa de enemigo |
| Robot | Defensa especial, reacción y recompensa de robot |
| Objeto | Tipo y valor del objeto |
| Inventario | Colección y capacidad de ocho objetos |
| Mapa | Matriz 3×3, posición, extracción y anomalía |
| Mision | Cuatro objetivos y recompensa de 100 XP |
| Juego | Coordinación del estado y reglas de la sesión |

Las clases deben extraerse gradualmente de Program.cs a archivos propios. En esa refactorización se reemplazarán Console.WriteLine/ReadLine por resultados y operaciones invocables desde ServicioPartida. La interfaz no debe duplicar las reglas.

## 8. Capa de infraestructura y SQL Server

Responsabilidades:
- Abrir conexiones mediante Microsoft.Data.SqlClient.
- Ejecutar consultas parametrizadas.
- Guardar y recuperar jugador, partida, celdas, objetivos, inventario y encuentro activo.
- Usar transacciones para que un guardado completo no quede parcialmente aplicado.
- Manejar errores de conexión y mostrar mensajes comprensibles sin cerrar inesperadamente el juego.

Clases propuestas:
- ConexionBD: obtiene la cadena de conexión desde configuración segura.
- RepositorioJugador: crea y consulta jugadores.
- RepositorioPartida: crea, guarda, lista y recupera partidas.
- Repositorios auxiliares solo si la implementación lo requiere.

No almacenar contraseñas de SQL Server en el repositorio. Utilizar configuración local excluida de Git o autenticación integrada cuando el entorno lo permita.

## 9. Guardado y recuperación

Un guardado debe incluir estado del cadete, posición, celdas del mapa, objetivos, objetos y encuentro activo. Se recomienda guardar automáticamente después de cada acción que cambie el estado y ofrecer también una opción Guardar partida.

La operación debe ejecutarse en una transacción SQL. Al cargar, se reconstruyen las instancias del dominio desde los registros y se valida que los datos sean coherentes con las reglas del juego.

## 10. Requisitos de calidad y pruebas

- La lógica del dominio debe poder probarse sin abrir formularios.
- Validar límites del mapa y costos de movimiento.
- Probar cada evento, efecto de objeto y reacción de entidad.
- Verificar el orden de los cuatro objetivos y la condición de victoria.
- Verificar que el inventario nunca supere ocho objetos.
- Probar guardado y recuperación con y sin encuentro activo.
- Probar errores de conexión, partida inexistente y datos inválidos.
- Verificar que la interfaz se actualice después de cada acción.

## 11. Secuencia de implementación

1. Crear el proyecto Windows Forms sin eliminar el prototipo de consola.
2. Extraer clases del archivo Program.cs y eliminar dependencia de Console en la lógica.
3. Crear ServicioPartida y probar sus operaciones.
4. Construir menú, registro y pantalla de exploración.
5. Implementar inventario y modo de combate.
6. Crear la base de datos mediante el script documentado.
7. Implementar repositorios y guardado/carga transaccional.
8. Ejecutar pruebas funcionales y de persistencia.
9. Capturar evidencias reales y actualizar documentación.

## 12. Criterio de aceptación

La arquitectura estará correctamente implementada cuando la aplicación permita jugar la misión existente desde Windows Forms, aplique las mismas reglas del prototipo y pueda guardar y recuperar una partida desde SQL Server sin perder estado.
