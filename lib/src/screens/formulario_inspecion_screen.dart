import 'package:flutter/material.dart';
import 'package:install_inspect/src/providers/providers.dart';
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
              CampoDateTime(
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
              CampoDateTime(
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
                hinText: '¿Pudo ser reparado?',
              ),
              // CampoCheckBox(
              //   fuga: fuga,
              //   hinText: "¿Pudo ser Reparado?",
              // ),
              const SizedBox(
                height: 15,
              ),

              hayfugas.getFuga == 'Si'
                  ? DatosInspeccion(
                      controlador: equipoComponente,
                      hinText: 'prueba de formulario',
                    )
                  : Text('No se desplegara nada'),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () =>
                    {} //salidaEstandar(nombre, inspector, instrumento, lugar),
                ,
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

class CampoDateTime extends StatefulWidget {
  final TextEditingController controlador;
  final String hinText;
  const CampoDateTime(
      {super.key, required this.controlador, required this.hinText});

  @override
  State<CampoDateTime> createState() => _CampoDateTimeState();
}

class _CampoDateTimeState extends State<CampoDateTime> {
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
          controller: widget.controlador,
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
            hintText: widget.hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            selectDate(context),
          },
        ),
      ),
    );
  }

  selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    String fecha;
    if (picked != null) {
      setState(() {
        fecha = picked.toString();
        widget.controlador.text = fecha.substring(0, 10);
      });
    }
  }
}

class CampoTimePicker extends StatefulWidget {
  final TextEditingController controlador;
  final String hinText;

  const CampoTimePicker(
      {super.key, required this.controlador, required this.hinText});
  @override
  State<CampoTimePicker> createState() => _CampoTimePickerState();
}

class _CampoTimePickerState extends State<CampoTimePicker> {
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
          controller: widget.controlador,
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
            hintText: widget.hinText,
            hintStyle: const TextStyle(color: Colors.black38),
          ),
          onTap: () => {
            FocusScope.of(context).requestFocus(FocusNode()),
            selectTime(context),
          },
        ),
      ),
    );
  }

  selectTime(BuildContext context) {
    String hora;
    return showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => setState(() {
              hora = value.toString();
              widget.controlador.text = hora.substring(10, 15);
            }));
  }
}

class CampoCheckBoxAlert extends StatelessWidget {
  const CampoCheckBoxAlert(
      {super.key, required this.fuga, required this.hinText});

  final TextEditingController fuga;
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
          title: const Text("¿Pudo ser reparado?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                fuga.text = 'No';
                hayfugas.setFuga = fuga.text;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sí"),
              onPressed: () {
                fuga.text = 'Si';
                hayfugas.setFuga = fuga.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CampoCheckBox extends StatefulWidget {
  const CampoCheckBox({super.key, required this.fuga, required this.hinText});

  final TextEditingController fuga;
  final String hinText;

  @override
  State<CampoCheckBox> createState() => _CkeState();
}

class _CkeState extends State<CampoCheckBox> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
        title: const Text('Habilitar Slider'),
        value: true,
        onChanged: (value) {
          //_sliderEnabled = value;
          setState(() {});
        });

    CheckboxListTile(
      title: Text(widget.hinText),
      value: true,
      onChanged: (newValue) {
        setState(() {
          widget.fuga.text = newValue.toString();
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }
}
