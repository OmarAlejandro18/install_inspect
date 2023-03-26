import 'package:flutter/material.dart';
import 'package:install_inspect/src/widgets/widgets.dart';

class ReparadoSi extends StatelessWidget {
  const ReparadoSi(
      {super.key,
      required this.fechaReparacion,
      required this.horaReparacion,
      required this.concentracionFuga});

  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController concentracionFuga;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoFecha(
            controlador: fechaReparacion, hinText: 'Fecha de reparación'),
        const SizedBox(
          height: 10,
        ),
        CampoTimePicker(
          controlador: horaReparacion,
          hinText: 'Hora de reparación',
        ),
        const SizedBox(
          height: 10,
        ),
        ConcentracionFuga(
            concentracionFuga: concentracionFuga,
            hinText: 'Concentración Fuga'),
      ],
    );
  }
}

class ConcentracionFuga extends StatelessWidget {
  final TextEditingController concentracionFuga;
  final String hinText;

  const ConcentracionFuga(
      {super.key, required this.concentracionFuga, required this.hinText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, -4),
              blurRadius: 6,
              color: Colors.black26,
            ),
          ],
        ),
        height: 60,
        child: TextFormField(
          controller: concentracionFuga,
          style: const TextStyle(
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 14),
            prefixIcon: const Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }
}
