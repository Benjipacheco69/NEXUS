# Guía de interacción e implementación Windows Forms

## 1. Propósito

Esta guía convierte el diseño de NEXUS H3/v2.0 en una especificación de interfaz implementable. La versión actual es de consola; los formularios y controles descritos aquí son el objetivo de la siguiente etapa.

La prioridad es trasladar las acciones existentes del menú a controles gráficos sin cambiar las reglas del videojuego.

## 2. Recorrido del usuario

1. Abrir NEXUS y ver el menú principal.
2. Seleccionar Nueva partida o Continuar.
3. Si es nueva partida, registrar al cadete y validar requisitos.
4. Entrar a la pantalla de exploración.
5. Consultar mapa, energía, estabilidad, inventario y objetivos.
6. Moverse por el mapa y resolver los eventos.
7. Cuando aparece una entidad, resolver el encuentro.
8. Llegar a la anomalía, derrotar al Guardián y regresar a extracción.
9. Ver el resultado y guardar el progreso en SQL Server.

## 3. Formulario FrmMenuPrincipal

### Controles

| Nombre | Tipo | Acción |
|---|---|---|
| lblTitulo | Label | Muestra NEXUS |
| btnNuevaPartida | Button | Abre FrmNuevaPartida |
| btnContinuar | Button | Consulta partidas EN_CURSO |
| btnSalir | Button | Cierra la aplicación |

### Reglas

- Si no hay partidas guardadas, Continuar informa que no existen partidas disponibles.
- Si hay varias, se muestra una lista con jugador, fecha y estado para elegir una.
- Si existe una partida sin guardar, al salir se solicita confirmación.
- La disponibilidad real de Continuar depende de la implementación de SQL Server.

## 4. Formulario FrmNuevaPartida

### Controles

| Nombre | Tipo | Restricción |
|---|---|---|
| txtNombre | TextBox | Obligatorio, máximo 50 caracteres |
| nudEdad | NumericUpDown | Mínimo 18 |
| nudEnergia | NumericUpDown | 30 a 100 |
| nudEstabilidad | NumericUpDown | 40 a 100 |
| btnIniciar | Button | Valida y crea partida |
| btnCancelar | Button | Regresa al menú |
| lblError | Label | Muestra validaciones |

### Acción Iniciar

1. Comprobar que el nombre no esté vacío.
2. Validar edad >= 18.
3. Validar energía >= 30 y <= 100.
4. Validar estabilidad >= 40 y <= 100.
5. Crear Cadete con ataque 10, XP 0 y escudo 0.
6. Crear Mapa de tamaño 3.
7. Crear la misión La anomalía perdida con sus cuatro objetivos.
8. Agregar una Célula de energía (+25) y un Analizador.
9. Crear el registro de Partida y sus nueve celdas y cuatro objetivos en SQL Server.
10. Abrir FrmExploracion.

Si una validación falla, no se debe crear una partida parcial.

## 5. Formulario FrmExploracion

### Distribución recomendada

- Encabezado: nombre del cadete y estado de la sesión.
- Columna izquierda: mapa 3×3.
- Columna central: registro de eventos y acciones.
- Columna derecha: recursos y objetivos.
- Franja inferior: botones de movimiento y acciones.

### Controles

| Nombre | Tipo | Función |
|---|---|---|
| pnlMapa | Panel | Contiene las nueve casillas |
| btnCelda00 a btnCelda22 | Button/Panel | Representa cada casilla |
| lblNombreCadete | Label | Nombre |
| pbEnergia | ProgressBar | Energía 0–100 |
| pbEstabilidad | ProgressBar | Estabilidad 0–100 |
| lblAtaque | Label | Ataque actual |
| lblEscudo | Label | Protección actual |
| lblXP | Label | Experiencia |
| lblPistas | Label | Pistas IRIS 0/3 |
| lstRegistro | ListBox | Mensajes y eventos |
| chkObjetivo1 a chkObjetivo4 | CheckBox de solo lectura | Progreso de misión |
| btnNorte, btnSur, btnEste, btnOeste | Button | Movimiento |
| btnAnalizarAnomalia | Button | Analiza anomalía |
| btnDescansar | Button | Recupera energía |
| btnInventario | Button | Abre FrmInventario |
| btnGuardar | Button | Guarda la partida |
| btnMision | Button | Muestra objetivos |

Las casillas se identifican por fila y columna. El estado visual debe distinguir extracción (E), posición del jugador (J), visitadas (X) y sin explorar (-). La posición del jugador se representa visualmente sin destruir el dato de extracción o visita que se debe recuperar al retirar el marcador.

### Acción de movimiento

Al pulsar un botón:
1. Verificar que no exista un encuentro activo.
2. Enviar N, S, E u O a ServicioPartida.Mover.
3. El servicio valida los límites.
4. Si el movimiento es válido, aplicar el costo de 5 energía y 2 estabilidad y aumentar zonas exploradas.
5. Resolver extracción, anomalía o evento aleatorio.
6. Devolver mensajes y el estado actualizado.
7. Refrescar mapa, barras, objetivos y registro.
8. Guardar el estado si la persistencia ya está habilitada.

Si la dirección sale del mapa, informar el error sin descontar recursos.

### Acciones adicionales

- **Analizar anomalía:** bloqueada durante encuentros; consume 8 de energía y suma una pista hasta un máximo de tres.
- **Descansar:** bloqueado durante encuentros; recupera 15 de energía hasta 100.
- **Inventario:** abre FrmInventario y actualiza los datos al cerrar.
- **Misión:** muestra los cuatro objetivos en orden.
- **Guardar:** persiste el estado completo, incluido el encuentro si existe.

## 6. Encuentro y combate

El panel de combate puede estar integrado en FrmExploracion o en un UserControl. No es necesario abrir una ventana modal si el panel puede actualizarse dentro de la pantalla principal.

| Control | Condición | Resultado |
|---|---|---|
| btnAtacar | Existe entidad activa | Cadete ataca; entidad reacciona si sigue viva |
| btnUsarObjeto | Existe entidad activa | Selección y uso de objeto válido |
| btnEscapar | Existe entidad activa | Energía -5; intento aleatorio |
| btnAnalizarEntidad | Existe entidad y analizador | Muestra información de la entidad |

Al iniciar un encuentro:
- Mostrar nombre, tipo y energía de la entidad.
- Deshabilitar movimiento, descanso y análisis de anomalía.
- Habilitar las acciones válidas de combate.

Al finalizar:
- Si la entidad es derrotada, otorgar XP según su tipo.
- Si era el Guardián, marcar el tercer objetivo de la misión.
- Si se escapa con éxito del encuentro con el Guardián, la lógica actual de Juego.TerminarEncuentro marca el objetivo de sobrevivir al encuentro como cumplido. La misión aún exige regresar al punto de extracción.
- Si el intento de escape falla, la entidad reacciona.
- Actualizar estado y persistir.

## 7. Formulario FrmInventario

Mostrar una lista de objetos individuales, no un catálogo de objetos disponibles. Cada fila contiene nombre, tipo y efecto.

El usuario selecciona una fila y pulsa Usar:
- Célula: recuperar 25 de energía, máximo 100; consumir instancia.
- Escudo: sumar 20 puntos de escudo; consumir instancia.
- Módulo de ataque: sumar 5 al ataque; consumir instancia.
- Analizador: no se consume; se utiliza con Analizar entidad.

No permitir agregar objetos si ya existen ocho. Mostrar un mensaje si el inventario está lleno.

## 8. Contrato entre formulario y lógica

Los formularios no deben ejecutar las reglas directamente. Deben invocar métodos de ServicioPartida y actualizar la vista con el resultado.

Una respuesta de operación debe contener, como mínimo:
- Exito: si la acción fue aceptada.
- Mensajes: texto que se añade al registro.
- EstadoCadete: recursos y estadísticas actuales.
- EstadoMapa: posición y celdas.
- EstadoMision: objetivos cumplidos.
- EncuentroActivo: datos de la entidad si existe.
- PartidaTerminada: indica si debe mostrarse FrmResultado.

Se recomienda usar clases de resultado (por ejemplo, ResultadoAccion y EstadoPartida) para evitar que los formularios lean directamente atributos privados del dominio.

## 9. Acceso a SQL Server desde la aplicación

- La presentación llama a ServicioPartida.
- ServicioPartida utiliza repositorios.
- Los repositorios utilizan Microsoft.Data.SqlClient.
- Las consultas deben usar parámetros.
- Las operaciones de guardado deben utilizar una transacción.
- La cadena de conexión debe configurarse localmente y no contener secretos en archivos versionados.

El esquema inicial está documentado en ../sql/nexus-schema.sql.

## 10. Estados visuales y accesibilidad

- Energía y estabilidad deben mostrar valor numérico además de la barra.
- Los botones no disponibles deben quedar deshabilitados y explicar el motivo.
- Los mensajes importantes (entidad detectada, daño, objeto encontrado, objetivo cumplido, derrota o victoria) deben aparecer en el registro.
- No comunicar resultados únicamente mediante color.
- Confirmar acciones que puedan abandonar una partida sin guardar.

## 11. Pruebas de aceptación de la interfaz

1. Registro rechaza edad 17, energía 29 o estabilidad 39.
2. Registro acepta los mínimos 18, 30 y 40.
3. Movimiento fuera del mapa no consume recursos.
4. Movimiento válido descuenta exactamente 5 energía y 2 estabilidad.
5. El mapa muestra posición y celdas visitadas correctamente.
6. No se permite descansar ni moverse durante un encuentro.
7. Atacar aplica el ataque actual del cadete.
8. Robot reduce a la mitad el daño recibido.
9. El escudo absorbe daño antes que la energía.
10. Escape descuenta 5 de energía y resuelve éxito/fracaso.
11. Analizar entidad requiere un analizador.
12. El inventario nunca supera ocho objetos.
13. El Guardián solo se considera superado al terminar su encuentro.
14. La misión solo se completa al regresar a extracción después de cumplir los objetivos previos.
15. Guardar y continuar restaura mapa, recursos, objetivos, inventario y encuentro.

## 12. Criterio final

La interfaz se acepta cuando un usuario puede completar la misión existente utilizando controles Windows Forms, sin recurrir a la consola para jugar, y cuando la presentación refleja fielmente el estado y las reglas que mantiene la lógica del dominio.
