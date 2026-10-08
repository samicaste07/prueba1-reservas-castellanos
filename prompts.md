# AGENTS.md — Reservas de sala

## Proyecto
App Flutter de reservas de salas. Backend: Supabase.

## Estructura
- `lib/domain/`: entidades, interfaz del repositorio y casos de uso. Dart puro.
- `lib/data/`: implementación del repositorio con Supabase.
- `lib/presentation/`: pantallas.
- `specs/001-reservas-sala/`: spec y plan del feature (GitHub Spec Kit).

## Comandos
- `flutter pub get`
- `flutter test`
- `flutter analyze`

## Convenciones
- Las pruebas de dominio usan `test/support/reservas_en_memoria.dart`, sin red.
- Código y mensajes al usuario en español.

Actualiza `specs/001-reservas-sala/spec.md` cumpliendo estrictamente con la convención de Spec-Driven Development:

1. Describe solo el QUÉ funcional: elimina toda mención a widgets.
2. Mantén los 2 escenarios originales y agrega 1 escenario nuevo dedicado al solapamiento con la sintaxis Dado/Cuando/Entonces:
   - Escenario 3 (solapamiento parcial): intenta reservar 09:30 a 10:30 cuando hay reserva de 09:00 a 10:00 -> se rechaza con el mensaje exacto 'La sala ya está reservada en ese horario'.
3. En Functional Requirements define claramente la regla de negocio y el mensaje de rechazo exacto.

Actualiza `test/crear_reserva_test.dart` para cubrir exhaustivamente la regla de no solapamiento:
- Rechazo por solapamiento parcial posterior y mensaje exacto 'La sala ya está reservada en ese horario'.
- Rechazo por solapamiento total contenido (dentro del rango existente).
- Rechazo por solapamiento contenedor (abarca antes y después del rango existente).
- Aceptación de reserva en el mismo horario en una sala diferente.

Implementa la regla de solapamiento en `lib/domain/crear_reserva.dart`:

1. Consulta las reservas existentes con `repositorio.reservasDeSala(solicitud.salaId)`.
2. Comprueba si alguna se solapa con `solicitud.inicio.isBefore(reserva.fin) && solicitud.fin.isAfter(reserva.inicio)`.
3. Si hay solapamiento, devuelve `ResultadoReserva.rechazada('La sala ya está reservada en ese horario')`.
4. Asegura que `lib/presentation/reserva_page.dart` llame a `widget.crearReserva` en lugar de saltarse el caso de uso insertando directo en Supabase.