# Feature Specification: Reservas de sala

**Feature Branch**: `001-reservas-sala`
**Created**: 2026-10-01
**Status**: Draft

## User Scenarios & Testing

### User Story 1 — Reservar una sala (Priority: P1)

Como estudiante autenticado, quiero reservar una sala de estudio por un intervalo de tiempo
para tener dónde trabajar con mi grupo.

**Why this priority**: sin reservas, la app no tiene propósito.

**Independent Test**: se puede probar creando una reserva y comprobando que queda registrada.

**Acceptance Scenarios**:

1. **Dado** que la sala A está libre, **Cuando** la reservo de 09:00 a 10:00, **Entonces** la
   reserva queda registrada a mi nombre.
2. **Dado** que elijo como inicio las 10:00 y como fin las 09:00, **Cuando** intento reservar,
   **Entonces** la reserva se rechaza con el mensaje "La hora de fin debe ser posterior a la de inicio".
3. **Dado** que la sala A ya está reservada de 09:00 a 10:00, **Cuando** intento reservarla de
   09:30 a 10:30, **Entonces** la reserva se rechaza con el mensaje exacto
   "La sala ya está reservada en ese horario".

### Edge Cases

- Una reserva no puede solaparse con otra reserva de la misma sala.

## Requirements

### Functional Requirements

- **FR-001**: El estudiante elige una sala, una hora de inicio y una hora de fin.
- **FR-002**: Cuando la reserva cumple las reglas de negocio, queda registrada a nombre del estudiante.
- **FR-003**: La hora de fin debe ser posterior a la hora de inicio; si no lo es, la reserva se rechaza
  con el mensaje exacto "La hora de fin debe ser posterior a la de inicio".
- **FR-004**: El sistema rechaza una reserva si su intervalo se solapa con el de otra reserva de la
  misma sala. El rechazo muestra el mensaje exacto "La sala ya está reservada en ese horario".

### Key Entities

- **Reserva**: sala, estudiante, inicio y fin.
- **Sala**: identificada por su nombre (Sala A, Sala B, Sala C).

## Success Criteria

- **SC-001**: Un estudiante completa una reserva en menos de 30 segundos.
