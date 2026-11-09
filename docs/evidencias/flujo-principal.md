# Flujo principal — NEXUS v2.0

~~~mermaid
flowchart TD
 A[Iniciar programa] --> B[Crear Juego]
 B --> C[Solicitar datos del cadete]
 C --> D{¿Cumple requisitos?}
 D -- No --> E[Rechazar inmersión]
 D -- Sí --> F[Crear mapa y misión]
 F --> G[Entregar objetos iniciales]
 G --> H[Mostrar menú]
 H --> I[Leer y procesar opción]
 I --> J[Explorar, analizar o descansar]
 I --> K[Inventario, objetos o combate]
 I --> L[Consultar estado, mapa o misión]
 J --> M{¿Sesión continúa?}
 K --> M
 L --> M
 M -- Sí --> H
 M -- No --> N[Mostrar resultado]
 E --> N
~~~
