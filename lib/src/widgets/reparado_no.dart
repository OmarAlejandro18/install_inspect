import 'package:flutter/material.dart';
import 'package:install_inspect/src/widgets/widgets.dart';

class ReparadoNo extends StatelessWidget {
  const ReparadoNo(
      {super.key,
      required this.faltaComponentes,
      required this.fechaCompraNuevoComponente,
      required this.fechaReparacionNuevoComponente,
      required this.concentracionMetano});

  final TextEditingController faltaComponentes;
  final TextEditingController fechaCompraNuevoComponente;
  final TextEditingController fechaReparacionNuevoComponente;
  final TextEditingController concentracionMetano;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CampoTexto(
          textoController: faltaComponentes,
          hinText: 'Reparación falta de componentes',
        ),
        CampoFecha(
            controlador: fechaCompraNuevoComponente,
            hinText: 'Fecha de compra nuevo componente'),
        CampoFecha(
            controlador: fechaCompraNuevoComponente,
            hinText: 'Fecha de reparacion usando nuevo componente'),
        CampoTexto(
            textoController: concentracionMetano,
            hinText: 'Concentración de Metano'),
      ],
    );
  }
}

class CampoTexto extends StatelessWidget {
  final TextEditingController textoController;
  final String hinText;

  const CampoTexto(
      {super.key, required this.textoController, required this.hinText});

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
          controller: textoController,
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
