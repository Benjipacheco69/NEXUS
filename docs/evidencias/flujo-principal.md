# Flujos de NEXUS

## 1. Flujo real de la versión H3/v2.0 (consola)

~~~mermaid
flowchart TD
 A[Program.Main] --> B[Crear Juego]
 B --> C[Solicitar nombre edad energía estabilidad]
 C --> D{¿Edad >=18, energía >=30 y estabilidad >=40?}
 D -- No --> E[Rechazar inmersión y terminar]
 D -- Sí --> F[Crear Cadete, Mapa 3x3 y Mision]
 F --> G[Entregar célula +25 y analizador]
 G --> H[Mostrar menú]
 H --> I{Seleccionar opción}
 I --> J[Moverse]
 I --> K[Analizar anomalía]
 I --> L[Descansar]
 I --> M[Consultar estado mapa inventario o misión]
 I --> N[Usar objeto atacar escapar o analizar entidad]
 J --> O[Validar dirección y límites]
 O --> P{¿Movimiento válido?}
 P -- No --> H
 P -- Sí --> Q[Consumir energía 5 y estabilidad 2]
 Q --> R[Resolver extracción anomalía o evento aleatorio]
 K --> S[Consumir 8 energía y sumar pista hasta 3]
 L --> T[Recuperar 15 energía hasta 100]
 N --> U[Aplicar acción y reacción de entidad si sigue viva]
 M --> H
 R --> V{¿Fin de partida?}
 S --> V
 T --> V
 U --> V
 V -- No --> H
 V -- Sí --> W[Mostrar resultado]
 E --> W
~~~

## 2. Flujo objetivo de la versión Windows Forms

Este flujo representa cómo deberá interactuar el usuario cuando se implemente la aplicación de escritorio. No describe una versión ya publicada.

~~~mermaid
flowchart TD
 A[Iniciar aplicación] --> B[FrmMenuPrincipal]
 B --> C[Nueva partida]
 B --> D[Continuar]
 B --> E[Salir]
 C --> F[FrmNuevaPartida]
 F --> G[Validar datos del cadete]
 G --> H{¿Datos válidos?}
 H -- No --> F
 H -- Sí --> I[Crear estado inicial de juego]
 I --> J[FrmExploracion]
 D --> K[Consultar partidas en SQL Server]
 K --> L{¿Existe partida guardada?}
 L -- No --> B
 L -- Sí --> M[Reconstruir estado y encuentro]
 M --> J
 J --> N[Usuario pulsa control]
 N --> O[ServicioPartida ejecuta regla del juego]
 O --> P[Actualizar mapa recursos misión y registro]
 P --> Q{¿Hay encuentro?}
 Q -- Sí --> R[Mostrar controles de combate]
 Q -- No --> S[Mostrar controles de exploración]
 R --> T[Guardar estado en SQL Server]
 S --> T
 T --> U{¿Misión terminada o sesión cerrada?}
 U -- No --> J
 U -- Sí --> V[FrmResultado y guardado final]
~~~

## 3. Correspondencia entre acciones y controles

| Acción actual | Control Windows Forms propuesto | Resultado esperado |
|---|---|---|
| Moverse N/S/E/O | Cuatro botones direccionales | Actualiza posición, energía, estabilidad y evento |
| Analizar anomalía | btnAnalizarAnomalia | Consume 8 energía y puede sumar pista |
| Descansar | btnDescansar | Recupera 15 energía hasta 100 |
| Mostrar estado | Panel de estado | Presenta atributos del cadete |
| Mostrar mapa | PanelMapa 3×3 | Presenta posición y casillas visitadas |
| Consultar inventario | btnInventario | Abre lista de objetos |
| Usar objeto | btnUsarObjeto | Aplica efecto y consume el objeto correspondiente |
| Atacar | btnAtacar | Daño del cadete y posible contraataque |
| Escapar | btnEscapar | Consume 5 energía; éxito o fallo aleatorio |
| Analizar entidad | btnAnalizarEntidad | Muestra información si hay analizador |
| Ver misión | Panel de objetivos | Muestra los cuatro objetivos y su progreso |

## 4. Regla de coherencia

Los diagramas separan el flujo que existe hoy del flujo que se construirá. La versión Windows Forms deberá conservar las reglas del flujo actual y agregar persistencia, no sustituir el videojuego por una experiencia distinta.
