import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:install_inspect/src/db/insertar_inspeccion.dart';
import 'package:install_inspect/src/models/inspeccion_model.dart';
import 'package:install_inspect/src/providers/providers.dart';
import 'package:install_inspect/src/services/firebase_services.dart';
import 'package:install_inspect/src/widgets/image_picker.dart';
import 'package:install_inspect/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FormularioInspeccionScreen extends StatefulWidget {
  const FormularioInspeccionScreen({super.key});

  @override
  State<FormularioInspeccionScreen> createState() =>
      _FormularioInspeccionScreenState();
}

class _FormularioInspeccionScreenState
    extends State<FormularioInspeccionScreen> {
  final _formKey = GlobalKey<FormState>();

  final equipoComponente = TextEditingController();
  final fechaInicioInspeccion = TextEditingController();
  final horaInicioInspeccion = TextEditingController();
  final fechafinalizacionInspeccion = TextEditingController();
  final horafinalizacionInspeccion = TextEditingController();
  final temperatura = TextEditingController();
  final corrienteAireKMH = TextEditingController();
  final fuga = TextEditingController();

  // FUGA = SI
  final concentracion = TextEditingController();
  final reparado = TextEditingController();
  //final fechaReparacion = TextEditingController();

  // REPARADO SI
  final fechaReparacion = TextEditingController();
  final horaReparacion = TextEditingController();
  final concentracionFuga = TextEditingController();

  // REPRADO NO
  final faltaComponentes = TextEditingController();
  final fechaCompraNuevoComponente = TextEditingController();
  final fechaReparacionNuevoComponente = TextEditingController();
  final concentracionMetano = TextEditingController();

  // IMAGENES
  final foto = TextEditingController();
  final fotoTermodinamica = TextEditingController();

  late File imgUploadF;
  XFile? imageF;
  late File imgUploadT;
  XFile? imageT;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final hayfugas = Provider.of<FugaProvider>(context);
    final fueReperado = Provider.of<ReparadoProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Inspección'),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Ingresa los datos de la Inspección',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 50,
              ),
              DatosInspeccion(
                controlador: equipoComponente,
                hinText: 'Equipo componente',
              ),
              const SizedBox(
                height: 15,
              ),
              CampoFecha(
                controlador: fechaInicioInspeccion,
                hinText: 'Fecha de Inicio de la Inspección',
              ),
              const SizedBox(
                height: 15,
              ),
              CampoTimePicker(
                controlador: horaInicioInspeccion,
                hinText: 'Hora de Inicio de la Inspección',
              ),
              const SizedBox(
                height: 15,
              ),
              CampoFecha(
                controlador: fechafinalizacionInspeccion,
                hinText: 'Fecha de finalización de la Inspección',
              ),
              //DatosInspeccion(controlador: fechafinalizacionInspeccion, hinText: 'Fecha de finalización de la Inspección',),
              const SizedBox(
                height: 15,
              ),
              CampoTimePicker(
                controlador: horafinalizacionInspeccion,
                hinText: 'Hora de finalización de la Inspección',
              ),
              const SizedBox(
                height: 15,
              ),
              DatosInspeccion(
                controlador: temperatura,
                hinText: 'Temperatura',
              ),
              const SizedBox(
                height: 15,
              ),
              DatosInspeccion(
                controlador: corrienteAireKMH,
                hinText: 'Corriente de Aire km/h',
              ),
              const SizedBox(
                height: 15,
              ),
              CampoCheckBoxAlert(
                fuga: fuga,
                hinText: '¿Hay Fuga?',
                concentracion: concentracion,
                reparado: reparado,
                fechaReparacion: fechaReparacion,
                horaReparacion: horaReparacion,
                concentracionFuga: concentracionFuga,
                foto: foto,
                fotoTermodinamica: fotoTermodinamica,
              ),
              const SizedBox(
                height: 15,
              ),
              hayfugas.getFuga == 'Si'
                  ? FugaSI(
                      concentracion: concentracion,
                      reparado: reparado,
                      fechaReparacion: fechaReparacion,
                      horaReparacion: horaReparacion,
                      concentracionFuga: concentracionFuga,
                      faltaComponentes: faltaComponentes,
                      fechaCompraNuevoComponente: fechaCompraNuevoComponente,
                      fechaReparacionNuevoComponente:
                          fechaReparacionNuevoComponente,
                      concentracionMetano: concentracionMetano,
                      foto: foto,
                      fotoTermodinamica: fotoTermodinamica,
                    )
                  : Container(),
              const SizedBox(
                height: 5,
              ),
              // TOMAR FOTO
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      imageF = await cargarFotoFirestore();
                      if (imageF == null) {
                        foto.text = 'null';
                      } else {
                        setState(() {
                          imgUploadF = File(imageF!.path);
                          foto.text = imgUploadF.path;
                        });
                      }
                    },
                    child: const Text('Tomar Fotografía')),
              ),
              foto.text != 'null' && foto.text != ''
                  ? SizedBox(
                      width: 200,
                      height: 100,
                      child: (foto.text != 'null' && foto.text != '')
                          ? Image.file(imgUploadF)
                          : const Text(''),
                    )
                  : const SizedBox(),

              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      imageT = await cargarFotoTermograficaFirestore();
                      if (imageT == null) {
                        fotoTermodinamica.text = 'null';
                      } else {
                        setState(() {
                          imgUploadT = File(imageT!.path);
                          fotoTermodinamica.text = imgUploadT.path;
                        });
                      }
                    },
                    child: const Text('Tomar Fotografía Termografica')),
              ),
              fotoTermodinamica.text != 'null' && fotoTermodinamica.text != ''
                  ? SizedBox(
                      width: 200,
                      height: 100,
                      child: (fotoTermodinamica.text != 'null' &&
                              fotoTermodinamica.text != '')
                          ? Image.file(imgUploadT)
                          : const Text(''),
                    )
                  : const SizedBox(),
              SizedBox(
                width: size.width * 0.85,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    if (foto.text != '' && fotoTermodinamica.text != '') {
                      foto.text = await subirFotoFireStorage(File(foto.text));
                      fotoTermodinamica.text =
                          await subirfotoTermograficaFireStorage(
                              File(fotoTermodinamica.text));
                    }
                    // InsertarInspeccion().agregarInspeccion(Inspeccion(
                    //   fuga.text,
                    //   concentracion.text != '' ? concentracion.text : 'null',
                    //   reparado.text != '' ? reparado.text : 'null',
                    //   fechaReparacion.text != ''
                    //       ? fechaReparacion.text
                    //       : 'null',
                    //   horaReparacion.text != '' ? horaReparacion.text : 'null',
                    //   concentracionFuga.text != ''
                    //       ? concentracionFuga.text
                    //       : 'null',
                    //   faltaComponentes.text != ''
                    //       ? faltaComponentes.text
                    //       : 'null',
                    //   fechaCompraNuevoComponente.text != ''
                    //       ? fechaCompraNuevoComponente.text
                    //       : 'null',
                    //   fechaReparacionNuevoComponente.text != ''
                    //       ? fechaReparacionNuevoComponente.text
                    //       : 'null',
                    //   concentracionMetano.text != ''
                    //       ? concentracionMetano.text
                    //       : 'null',
                    //   equipoComponente: equipoComponente.text != ''
                    //       ? equipoComponente.text
                    //       : 'null',
                    //   fechaInicioInspeccion: fechaInicioInspeccion.text != ''
                    //       ? fechaInicioInspeccion.text
                    //       : 'null',
                    //   horaInicioInspeccion: horaInicioInspeccion.text != ''
                    //       ? horaInicioInspeccion.text
                    //       : 'null',
                    //   fechafinalizacionInspeccion:
                    //       fechafinalizacionInspeccion.text != ''
                    //           ? fechafinalizacionInspeccion.text
                    //           : 'null',
                    //   horafinalizacionInspeccion:
                    //       horafinalizacionInspeccion.text != ''
                    //           ? horafinalizacionInspeccion.text
                    //           : 'null',
                    //   temperatura:
                    //       temperatura.text != '' ? temperatura.text : 'null',
                    //   corrienteAireKMH: corrienteAireKMH.text != ''
                    //       ? corrienteAireKMH.text
                    //       : 'null',
                    //   foto: foto.text,
                    //   fotoTermografica: fotoTermodinamica.text,
                    //   timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    // ));
                    agregarInspeccion(Inspeccion(
                      fuga.text,
                      concentracion.text != '' ? concentracion.text : 'null',
                      reparado.text != '' ? reparado.text : 'null',
                      fechaReparacion.text != ''
                          ? fechaReparacion.text
                          : 'null',
                      horaReparacion.text != '' ? horaReparacion.text : 'null',
                      concentracionFuga.text != ''
                          ? concentracionFuga.text
                          : 'null',
                      faltaComponentes.text != ''
                          ? faltaComponentes.text
                          : 'null',
                      fechaCompraNuevoComponente.text != ''
                          ? fechaCompraNuevoComponente.text
                          : 'null',
                      fechaReparacionNuevoComponente.text != ''
                          ? fechaReparacionNuevoComponente.text
                          : 'null',
                      concentracionMetano.text != ''
                          ? concentracionMetano.text
                          : 'null',
                      equipoComponente: equipoComponente.text != ''
                          ? equipoComponente.text
                          : 'null',
                      fechaInicioInspeccion: fechaInicioInspeccion.text != ''
                          ? fechaInicioInspeccion.text
                          : 'null',
                      horaInicioInspeccion: horaInicioInspeccion.text != ''
                          ? horaInicioInspeccion.text
                          : 'null',
                      fechafinalizacionInspeccion:
                          fechafinalizacionInspeccion.text != ''
                              ? fechafinalizacionInspeccion.text
                              : 'null',
                      horafinalizacionInspeccion:
                          horafinalizacionInspeccion.text != ''
                              ? horafinalizacionInspeccion.text
                              : 'null',
                      temperatura:
                          temperatura.text != '' ? temperatura.text : 'null',
                      corrienteAireKMH: corrienteAireKMH.text != ''
                          ? corrienteAireKMH.text
                          : 'null',
                      foto: foto.text,
                      fotoTermografica: fotoTermodinamica.text,
                      timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    ));
                    // guardarInspeccionTiempoReal(Inspeccion(
                    //   fuga.text,
                    //   concentracion.text != '' ? concentracion.text : 'null',
                    //   reparado.text != '' ? reparado.text : 'null',
                    //   fechaReparacion.text != ''
                    //       ? fechaReparacion.text
                    //       : 'null',
                    //   horaReparacion.text != '' ? horaReparacion.text : 'null',
                    //   concentracionFuga.text != ''
                    //       ? concentracionFuga.text
                    //       : 'null',
                    //   faltaComponentes.text != ''
                    //       ? faltaComponentes.text
                    //       : 'null',
                    //   fechaCompraNuevoComponente.text != ''
                    //       ? fechaCompraNuevoComponente.text
                    //       : 'null',
                    //   fechaReparacionNuevoComponente.text != ''
                    //       ? fechaReparacionNuevoComponente.text
                    //       : 'null',
                    //   concentracionMetano.text != ''
                    //       ? concentracionMetano.text
                    //       : 'null',
                    //   equipoComponente: equipoComponente.text != ''
                    //       ? equipoComponente.text
                    //       : 'null',
                    //   fechaInicioInspeccion: fechaInicioInspeccion.text != ''
                    //       ? fechaInicioInspeccion.text
                    //       : 'null',
                    //   horaInicioInspeccion: horaInicioInspeccion.text != ''
                    //       ? horaInicioInspeccion.text
                    //       : 'null',
                    //   fechafinalizacionInspeccion:
                    //       fechafinalizacionInspeccion.text != ''
                    //           ? fechafinalizacionInspeccion.text
                    //           : 'null',
                    //   horafinalizacionInspeccion:
                    //       horafinalizacionInspeccion.text != ''
                    //           ? horafinalizacionInspeccion.text
                    //           : 'null',
                    //   temperatura:
                    //       temperatura.text != '' ? temperatura.text : 'null',
                    //   corrienteAireKMH: corrienteAireKMH.text != ''
                    //       ? corrienteAireKMH.text
                    //       : 'null',
                    //   foto: foto.text,
                    //   fotoTermografica: fotoTermodinamica.text,
                    //   timestamp: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                    // ));
                    salidaDatos(
                      equipoComponente,
                      fechaInicioInspeccion,
                      horaInicioInspeccion,
                      fechafinalizacionInspeccion,
                      horafinalizacionInspeccion,
                      temperatura,
                      corrienteAireKMH,
                      fuga,
                      concentracion,
                      reparado,
                      fechaReparacion,
                      horaReparacion,
                      concentracionFuga,
                      faltaComponentes,
                      fechaCompraNuevoComponente,
                      fechaReparacionNuevoComponente,
                      concentracionMetano,
                      foto,
                      fotoTermodinamica,
                    );
                    equipoComponente.text = '';
                    fechaInicioInspeccion.text = '';
                    horaInicioInspeccion.text = '';
                    fechafinalizacionInspeccion.text = '';
                    horafinalizacionInspeccion.text = '';
                    temperatura.text = '';
                    corrienteAireKMH.text = '';
                    fuga.text = '';
                    concentracion.text = '';
                    reparado.text = '';
                    fechaReparacion.text = '';
                    horaReparacion.text = '';
                    concentracionFuga.text = '';
                    faltaComponentes.text = '';
                    fechaCompraNuevoComponente.text = '';
                    fechaReparacionNuevoComponente.text = '';
                    concentracionMetano.text = '';
                    foto.text = '';
                    fotoTermodinamica.text = '';
                    hayfugas.setFuga = '';
                    fueReperado.setReparado = '';
                    Navigator.pushNamed(context, 'home');
                  },
                  child: const Text('Guardar'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DatosInspeccion extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;
  const DatosInspeccion(
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

class CampoCheckBoxAlert extends StatelessWidget {
  const CampoCheckBoxAlert(
      {super.key,
      required this.fuga,
      required this.hinText,
      required this.concentracion,
      required this.reparado,
      required this.fechaReparacion,
      required this.horaReparacion,
      required this.concentracionFuga,
      required this.foto,
      required this.fotoTermodinamica});

  final TextEditingController fuga;
  final TextEditingController concentracion;
  final TextEditingController reparado;
  final String hinText;

  // REPARADO SI
  final TextEditingController fechaReparacion;
  final TextEditingController horaReparacion;
  final TextEditingController concentracionFuga;

  // REPARADO NO
  final TextEditingController foto;
  final TextEditingController fotoTermodinamica;

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
          controller: fuga,
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
    final hayfugas = Provider.of<FugaProvider>(context, listen: false);
    final fueReperado = Provider.of<ReparadoProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("¿Hay Fuga?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                fuga.text = 'No';
                hayfugas.setFuga = fuga.text;
                fueReperado.setReparado = '';
                concentracion.text = '';
                reparado.text = '';
                fechaReparacion.text = '';
                horaReparacion.text = '';
                concentracionFuga.text = '';
                foto.text = '';
                fotoTermodinamica.text = '';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                fuga.text = 'Si';
                hayfugas.setFuga = fuga.text;
                fueReperado.setReparado = '';
                concentracion.text = '';
                reparado.text = '';
                fechaReparacion.text = '';
                horaReparacion.text = '';
                concentracionFuga.text = '';
                foto.text = '';
                fotoTermodinamica.text = '';
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

salidaDatos(
    TextEditingController equipoComponente,
    TextEditingController fechaInicioInspeccion,
    TextEditingController horaInicioInspeccion,
    TextEditingController fechafinalizacionInspeccion,
    TextEditingController horafinalizacionInspeccion,
    TextEditingController temperatura,
    TextEditingController corrienteAireKMH,
    TextEditingController fuga,
    TextEditingController concentracion,
    TextEditingController reparado,
    TextEditingController fechaReparacion,
    TextEditingController horaReparacion,
    TextEditingController concentracionFuga,
    TextEditingController faltaComponentes,
    TextEditingController fechaCompraNuevoComponente,
    TextEditingController fechaReparacionNuevoComponente,
    TextEditingController concentracionMetano,
    TextEditingController foto,
    TextEditingController fotoTermodinamica) {
  print('SALIDA DE LOS DATOS DE INSPECCION');
  print('1 ${equipoComponente.text}');
  print('2 ${fechaInicioInspeccion.text}');
  print('3 ${horaInicioInspeccion.text}');
  print('4 ${fechafinalizacionInspeccion.text}');
  print('5 ${horafinalizacionInspeccion.text}');
  print('6 ${temperatura.text}');
  print('7 ${corrienteAireKMH.text}');
  print('8 ${fuga.text}');
  print('9 ${concentracion.text}');
  print('10 ${reparado.text}');
  print('11 ${fechaReparacion.text}');
  print('12 ${horaReparacion.text}');
  print('13 ${concentracionFuga.text}');
  print('14 ${faltaComponentes.text}');
  print('15 ${fechaCompraNuevoComponente.text}');
  print('16 ${fechaReparacionNuevoComponente.text}');
  print('17 ${concentracionMetano.text}');
  print('18 ${foto.text}');
  print('19 ${fotoTermodinamica.text}');
}
