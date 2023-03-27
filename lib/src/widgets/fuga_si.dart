import 'package:flutter/material.dart';
import 'package:install_inspect/src/providers/providers.dart';
import 'package:install_inspect/src/widgets/reparado_no.dart';
import 'package:install_inspect/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FugaSI extends StatelessWidget {
  const FugaSI(
      {super.key,
      required this.concentracion,
      required this.reparado,
      required this.fechaReparacion,
      //required this.fechaReparacion2,
      required this.horaReparacion,
      required this.concentracionFuga,
      required this.faltaComponentes,
      required this.fechaCompraNuevoComponente,
      required this.fechaReparacionNuevoComponente,
      required this.concentracionMetano});

  final TextEditingController concentracion;
  final TextEditingController reparado;
  //final TextEditingController fechaReparacion;

  // REPARADO SI

  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController concentracionFuga;

  // REPARADO NO

  final TextEditingController faltaComponentes;
  final TextEditingController fechaCompraNuevoComponente;
  final TextEditingController fechaReparacionNuevoComponente;
  final TextEditingController concentracionMetano;

  @override
  Widget build(BuildContext context) {
    final esReparado = Provider.of<ReparadoProvider>(context);
    final hayfugas = Provider.of<FugaProvider>(context);

    return Column(
      children: [
        FormFugaSi(
            controlador: concentracion,
            hinText: 'Concentración previa recuperación'),
        const SizedBox(
          height: 10,
        ),
        CampoPudoSerRapado(
            reparado: reparado,
            hinText: '¿Pudo ser reparado?',
            fechaReparacion: fechaReparacion,
            horaReparacion: horaReparacion,
            concentracionFuga: concentracionFuga,
            faltaComponentes: faltaComponentes,
            fechaCompraNuevoComponente: fechaCompraNuevoComponente,
            fechaReparacionNuevoComponente: fechaReparacionNuevoComponente,
            concentracionMetano: concentracionMetano),
        const SizedBox(
          height: 10,
        ),
        (hayfugas.getFuga == 'Si' && esReparado.getReparado == 'Si')
            ? ReparadoSi(
                fechaReparacion: fechaReparacion,
                horaReparacion: horaReparacion,
                concentracionFuga: concentracionFuga)
            : Container(),
        (hayfugas.getFuga == 'Si' && esReparado.getReparado == 'No')
            ? ReparadoNo(
                faltaComponentes: faltaComponentes,
                fechaCompraNuevoComponente: fechaCompraNuevoComponente,
                fechaReparacionNuevoComponente: fechaReparacionNuevoComponente,
                concentracionMetano: concentracionMetano)
            : Container(),
        const SizedBox(
          height: 10,
        ),
        /*CampoFecha(
            controlador: fechaReparacion, hinText: 'Fecha de reparación'),
        */
      ],
    );
  }
}

class FormFugaSi extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;

  const FormFugaSi(
      {super.key, required this.controlador, required this.hinText});

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
          controller: controlador,
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

class CampoPudoSerRapado extends StatelessWidget {
  const CampoPudoSerRapado(
      {super.key,
      required this.reparado,
      required this.hinText,
      required this.fechaReparacion,
      required this.horaReparacion,
      required this.concentracionFuga,
      required this.faltaComponentes,
      required this.fechaCompraNuevoComponente,
      required this.fechaReparacionNuevoComponente,
      required this.concentracionMetano});

  final TextEditingController reparado;
  final String hinText;

  //REPARADO SI
  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController concentracionFuga;

  // REPARADO NO

  final TextEditingController faltaComponentes;
  final TextEditingController fechaCompraNuevoComponente;
  final TextEditingController fechaReparacionNuevoComponente;
  final TextEditingController concentracionMetano;

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
          controller: reparado,
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
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            mostrarAlerta(context),
          },
        ),
      ),
    );
  }

  mostrarAlerta(BuildContext context) {
    final fueReperado = Provider.of<ReparadoProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("¿Pudo ser reparado?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                reparado.text = 'No';
                fueReperado.setReparado = reparado.text;
                // REPARADO NO
                faltaComponentes.text = '';
                fechaCompraNuevoComponente.text = '';
                fechaReparacionNuevoComponente.text = '';
                concentracionMetano.text = '';
                // REPARADO SI
                fechaReparacion.text = '';
                horaReparacion.text = '';
                concentracionFuga.text = '';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                //REPARADO SI
                reparado.text = 'Si';
                fueReperado.setReparado = reparado.text;
                fechaReparacion.text = '';
                horaReparacion.text = '';
                concentracionFuga.text = '';
                // REPARADO NO
                faltaComponentes.text = '';
                fechaCompraNuevoComponente.text = '';
                fechaReparacionNuevoComponente.text = '';
                concentracionMetano.text = '';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
