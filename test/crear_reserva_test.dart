import 'package:flutter_test/flutter_test.dart';
import 'package:reservas_sala/domain/crear_reserva.dart';
import 'package:reservas_sala/domain/reserva.dart';

import 'support/reservas_en_memoria.dart';

DateTime hora(int h, [int m = 0]) => DateTime(2026, 10, 14, h, m);

void main() {
  late ReservasEnMemoria repositorio;
  late CrearReserva crearReserva;

  setUp(() {
    repositorio = ReservasEnMemoria();
    crearReserva = CrearReserva(repositorio);
  });

  test('acepta una reserva válida y la guarda', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza una reserva cuyo fin no es posterior al inicio', () async {
    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(9),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La hora de fin debe ser posterior a la de inicio');
    expect(repositorio.reservas, isEmpty);
  });

  test('rechaza el solapamiento parcial posterior con el mensaje exacto', () async {
    await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(9, 30),
      fin: hora(10, 30),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La sala ya está reservada en ese horario');
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza una reserva contenida dentro del horario existente', () async {
    await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(12),
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(10),
      fin: hora(11),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La sala ya está reservada en ese horario');
    expect(repositorio.reservas, hasLength(1));
  });

  test('rechaza una reserva que contiene el horario existente', () async {
    await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(10),
      fin: hora(11),
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u2',
      inicio: hora(9),
      fin: hora(12),
    ));

    expect(resultado.aceptada, isFalse);
    expect(resultado.mensaje, 'La sala ya está reservada en ese horario');
    expect(repositorio.reservas, hasLength(1));
  });

  test('acepta el mismo horario cuando la reserva es para otra sala', () async {
    await crearReserva(SolicitudReserva(
      salaId: 'Sala A',
      usuarioId: 'u1',
      inicio: hora(9),
      fin: hora(10),
    ));

    final resultado = await crearReserva(SolicitudReserva(
      salaId: 'Sala B',
      usuarioId: 'u2',
      inicio: hora(9),
      fin: hora(10),
    ));

    expect(resultado.aceptada, isTrue);
    expect(resultado.reserva?.salaId, 'Sala B');
    expect(repositorio.reservas, hasLength(2));
  });
}
