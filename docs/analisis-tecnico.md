# Análisis Técnico

## Objetivo

Analizar tecnologías y justificar las decisiones adoptadas para la evolución de NEXUS.

## Alternativas evaluadas

### Aplicación de consola

Ventajas:

- Fácil implementación.
- Menor complejidad.
- Consumo reducido de recursos.

Desventajas:

- Interfaz limitada.
- Menor atractivo visual.
- Difícil expansión.

---

### Windows Forms

Ventajas:

- Integración directa con C#.
- Desarrollo rápido.
- Compatible con SQL Server.
- Ideal para proyectos académicos.

Desventajas:

- Capacidades gráficas limitadas frente a motores especializados.

---

### Unity

Ventajas:

- Motor profesional.
- Soporte para 2D y 3D.
- Alta escalabilidad.

Desventajas:

- Mayor complejidad.
- Curva de aprendizaje más elevada.

## Alternativas de almacenamiento

### Archivos de texto

Ventajas:

- Fácil implementación.

Desventajas:

- Poco escalables.
- Organización limitada.

### SQL Server

Ventajas:

- Almacenamiento estructurado.
- Seguridad.
- Consultas eficientes.
- Compatibilidad con .NET.

Desventajas:

- Requiere configuración inicial.

## Decisiones recomendadas

### Interfaz gráfica

Se recomienda Windows Forms porque:

- Ya se utiliza C#.
- Permite reutilizar el código existente.
- Cumple con los objetivos académicos del proyecto.

### Persistencia

Se recomienda SQL Server porque:

- Permite guardar progreso.
- Facilita las consultas.
- Soporta crecimiento futuro.

### Arquitectura

Se recomienda arquitectura en capas separando:

- Presentación.
- Lógica del juego.
- Acceso a datos.

## Fuentes técnicas

- Microsoft Learn C#
- Microsoft Learn Windows Forms
- Microsoft Learn SQL Server
- Documentación oficial .NET

## Verificación mediante IA

La propuesta fue contrastada mediante herramientas de inteligencia artificial para validar:

- Arquitectura por capas.
- Diseño de base de datos.
- Buenas prácticas de programación orientada a objetos.
- Escalabilidad del sistema.

## Conclusión

La combinación de Windows Forms, SQL Server y arquitectura en capas representa la opción más adecuada para evolucionar NEXUS desde un prototipo de consola hacia un videojuego gráfico mantenible, escalable y alineado con los objetivos del proyecto.