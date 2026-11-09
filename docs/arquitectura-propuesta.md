# Arquitectura propuesta para NEXUS

Esta es una propuesta futura; no representa la organización implementada actualmente.

~~~text
POO Nexus/
├── Program.cs
├── POO Nexus.csproj
├── Dominio/
│   ├── Personaje.cs
│   ├── Cadete.cs
│   ├── Enemigo.cs
│   ├── Robot.cs
│   ├── Objeto.cs
│   ├── Inventario.cs
│   ├── Mapa.cs
│   └── Mision.cs
├── Aplicacion/
│   └── Juego.cs
└── Presentacion/
    └── MenuConsola.cs
~~~

| Capa | Responsabilidad |
|---|---|
| Presentación | Menús, entradas y mensajes. |
| Aplicación | Coordinación del ciclo y casos de uso. |
| Dominio | Personajes, objetos, inventario, mapa y misión. |

## Mejoras
1. Separar las clases en archivos sin alterar las reglas.
2. Desacoplar la consola de la lógica de juego.
3. Validar rangos de edad, energía, estabilidad y opciones.
4. Hacer configurable el generador aleatorio para pruebas.
5. Añadir pruebas unitarias de movimiento, inventario, daño y misión.
6. Diseñar guardado de partidas solo si se requiere persistencia.

Implementar por etapas: modularización, compilación y pruebas de regresión, extracción de presentación y servicios, pruebas automatizadas.
