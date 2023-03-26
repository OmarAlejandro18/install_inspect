import 'package:flutter/material.dart';
import 'package:install_inspect/src/providers/providers.dart';
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

  // Reparado NO

  final faltaComponentes = TextEditingController();
  final fechaCompraNuevoComponente = TextEditingController();
  final fechaReparacionNuevoComponente = TextEditingController();
  final concentracionMetano = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hayfugas = Provider.of<FugaProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Ingresa los datos de la instalación',
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
              ),
              const SizedBox(
                height: 15,
              ),

              hayfugas.getFuga == 'Si'
                  ? FugaSI(
                      concentracion: concentracion,
                      reparado: reparado,
                      //fechaReparacion: fechaReparacion,
                      fechaReparacion: fechaReparacion,
                      horaReparacion: horaReparacion,
                      concentracionFuga: concentracionFuga,
                      faltaComponentes: faltaComponentes,
                      fechaCompraNuevoComponente: fechaCompraNuevoComponente,
                      fechaReparacionNuevoComponente:
                          fechaReparacionNuevoComponente,
                      concentracionMetano: concentracionMetano,
                    )
                  : const Text('No desplegara nada'),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => {
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
                      concentracionMetano)
                },
                child: const Text('Guardar'),
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
      required this.reparado});

  final TextEditingController fuga;
  final TextEditingController concentracion;
  final TextEditingController reparado;
  final String hinText;

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
                concentracion.text = '';
                reparado.text = '';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                fuga.text = 'Si';
                hayfugas.setFuga = fuga.text;
                concentracion.text = '';
                reparado.text = '';
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
    TextEditingController concentracionMetano) {
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
}
