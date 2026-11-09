# Arquitectura Propuesta

## Objetivo

Evolucionar NEXUS hacia una aplicación gráfica utilizando Windows Forms y SQL Server mediante una arquitectura organizada en capas.

## Diagrama de arquitectura

Windows Forms (Interfaz)

↓

Lógica del Juego

↓

Acceso a Datos

↓

SQL Server

## Capa de presentación

Responsabilidades:

- Mostrar pantallas.
- Mostrar estadísticas.
- Mostrar inventario.
- Mostrar misiones.
- Mostrar mapa interactivo.

Formularios propuestos:

- FrmMenuPrincipal
- FrmExploracion
- FrmInventario
- FrmMisiones
- FrmEstadisticas

## Capa de lógica

Responsable de las reglas del juego.

### Clase Jugador

Atributos:

- Nombre
- Edad
- Energía
- Estabilidad
- Nivel
- Experiencia

### Clase Inventario

Gestiona objetos obtenidos.

### Clase Mision

Gestiona objetivos y recompensas.

### Clase Mapa

Controla sectores y exploración.

### Clase Partida

Gestiona el progreso general.

### Clase Anomalia

Representa eventos especiales.

## Capa de acceso a datos

Responsable de:

- Guardar partidas.
- Cargar partidas.
- Consultar progreso.
- Consultar inventario.

Clase principal:

- ConexionBD

## Ventajas

### Mantenibilidad

Cada componente tendrá una función específica.

### Escalabilidad

Permitirá agregar:

- Nuevas misiones.
- Nuevos mapas.
- Nuevos objetos.
- Logros.

### Reutilización

La lógica del juego podrá utilizarse en futuras versiones.

## Conclusión

La arquitectura por capas mejora la organización del proyecto y facilita futuras expansiones.
