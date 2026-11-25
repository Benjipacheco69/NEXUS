# Hito 4 – Reto de programación: método Move

## Método seleccionado
`GameSession.Move(string d)` en `Nexus.WinForms/Form1.cs`.

## Propósito
Procesar el desplazamiento del cadete por el mapa de 3 × 3 y actualizar su posición, recursos, zonas exploradas y eventos.

## Parámetro
- `d`: dirección del movimiento. Valores admitidos: `N`, `S`, `E` y `O` (también se aceptan minúsculas y espacios externos).

## Condiciones
- No permite desplazarse mientras exista una entidad activa.
- La dirección debe ser válida.
- La nueva posición debe permanecer dentro del mapa.
- Al llegar a la anomalía se activa el encuentro con el Guardián.
- Al regresar a extracción se comprueba el cumplimiento de los objetivos.

## Resultado
Actualiza la posición y el estado de la partida, o informa una excepción cuando la acción no es válida.

## Mejora funcional aplicada
Antes, una dirección desconocida no cambiaba las coordenadas, pero el método continuaba descontando energía y estabilidad e incrementaba las zonas exploradas. Ahora se valida la dirección antes de modificar el estado. Una entrada inválida produce `ArgumentException` y no consume recursos ni altera el progreso.

## Verificación manual que debe realizarse en el equipo
1. Iniciar una partida y registrar energía, estabilidad y zonas exploradas.
2. Probar `N`, `S`, `E` y `O` desde posiciones donde el movimiento sea posible.
3. Intentar una dirección inválida desde una prueba controlada del método.
4. Confirmar que la dirección inválida no modifica posición, energía, estabilidad ni zonas exploradas.
5. Confirmar que una dirección que sale del mapa sigue siendo rechazada.

## Control de versiones
Después de ejecutar las pruebas en Visual Studio:
- Revisar los cambios en `Form1.cs`.
- Crear un commit descriptivo, por ejemplo: `Validar direcciones antes de mover al cadete`.
- Publicar con push y verificar el commit en GitHub.

> Las pruebas y el commit deben ejecutarse desde el equipo del estudiante. Este paquete contiene el cambio de código, pero no afirma que se haya ejecutado ni publicado.
