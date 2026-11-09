# Análisis técnico de NEXUS v2.0

## Identificación
- Lenguaje: C#.
- Tipo: aplicación de consola.
- Framework objetivo: .NET 10 (`net10.0`).
- Proyecto: `POO Nexus/POO Nexus.csproj`.
- Código: `POO Nexus/Program.cs`.

## Funcionalidades
Creación y validación del cadete, mapa 3 × 3, movimiento, eventos aleatorios, pistas IRIS, objetos, inventario, combate, experiencia y misión de cuatro objetivos.

## Fortalezas
- Aplica abstracción, encapsulamiento, herencia y polimorfismo.
- Modela entidades mediante clases.
- Limita inventario y movimientos fuera del mapa.
- Usa int.TryParse para entradas numéricas.
- Separa mapa y misión en clases propias.

## Aspectos por mejorar
| Aspecto | Observación | Recomendación |
|---|---|---|
| Organización | Clases en un archivo. | Separar archivos. |
| Validación | No todos los rangos están controlados. | Validar límites y repetir solicitudes. |
| Estabilidad | Algunos eventos pueden reducirla sin límite superior/inferior centralizado. | Centralizar reglas de recursos. |
| Aleatoriedad | Eventos dependen de Random. | Permitir semilla configurable en pruebas. |
| Persistencia | No se guardan partidas. | Diseñar guardado si se requiere. |
| Pruebas | No hay pruebas automatizadas incluidas. | Crear proyecto de pruebas. |

## Pruebas recomendadas
1. Rechazo por edad menor de 18, energía menor de 30 o estabilidad menor de 40.
2. Ajuste de valores iniciales superiores a 100.
3. Movimientos fuera de límites.
4. Coste de energía y estabilidad por movimiento.
5. Capacidad máxima del inventario.
6. Recuperación de energía y uso de escudo.
7. Reducción de daño del robot.
8. Recompensas XP.
9. Cumplimiento de objetivos y regreso a extracción.
10. Fin por energía cero, estabilidad cero y salida voluntaria.

## Ejecución
Se requiere SDK .NET 10:
~~~bash
dotnet restore "POO Nexus/POO Nexus.csproj"
dotnet build "POO Nexus/POO Nexus.csproj"
dotnet run --project "POO Nexus/POO Nexus.csproj"
~~~

Prioridades: modularizar, reforzar validaciones y automatizar pruebas. La persistencia y la interfaz gráfica son mejoras futuras.
