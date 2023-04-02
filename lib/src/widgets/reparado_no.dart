import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:install_inspect/src/widgets/image_picker.dart';
import 'package:install_inspect/src/widgets/widgets.dart';
import 'dart:convert';

class ReparadoNo extends StatefulWidget {
  const ReparadoNo(
      {super.key,
      required this.faltaComponentes,
      required this.fechaCompraNuevoComponente,
      required this.fechaReparacionNuevoComponente,
      required this.concentracionMetano,
      required this.foto,
      required this.fotoTermodinamica});

  final TextEditingController faltaComponentes;
  final TextEditingController fechaCompraNuevoComponente;
  final TextEditingController fechaReparacionNuevoComponente;
  final TextEditingController concentracionMetano;
  final TextEditingController foto;
  final TextEditingController fotoTermodinamica;

  @override
  State<ReparadoNo> createState() => _ReparadoNoState();
}

class _ReparadoNoState extends State<ReparadoNo> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CampoTexto(
          textoController: widget.faltaComponentes,
          hinText: 'Reparación falta de componentes',
        ),
        CampoFecha(
            controlador: widget.fechaCompraNuevoComponente,
            hinText: 'Fecha de compra nuevo componente'),
        CampoFecha(
            controlador: widget.fechaReparacionNuevoComponente,
            hinText: 'Fecha de reparacion usando nuevo componente'),
        CampoTexto(
            textoController: widget.concentracionMetano,
            hinText: 'Concentración de Metano'),
        widget.fotoTermodinamica.text != 'null' &&
                widget.fotoTermodinamica.text != ''
            ? SizedBox(
                width: 200,
                height: 100,
                child: (widget.fotoTermodinamica.text != 'null' &&
                        widget.fotoTermodinamica.text != '')
                    ? Image.memory(base64Decode(widget.fotoTermodinamica.text))
                    : const Text(''),
              )
            : const SizedBox(),
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
