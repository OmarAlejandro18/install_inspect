import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/insertar_instalacion.dart';
import 'package:install_inspect/src/models/instalacion_model.dart';
import 'package:install_inspect/src/services/firebase_services.dart';

// ignore: must_be_immutable
class FormularioInstalacionScreen extends StatelessWidget {
  FormularioInstalacionScreen({super.key});
  int id = 0;
  final _formKey = GlobalKey<FormState>();
  final nombre = TextEditingController();
  final inspector = TextEditingController();
  final instrumento = TextEditingController();
  final lugar = TextEditingController();
  final ubicacion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Instalacion'))),
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
              InputDato(controlador: nombre, hinText: 'Nombre componente'),
              const SizedBox(
                height: 15,
              ),
              InputDato(
                controlador: inspector,
                hinText: 'Inspector',
              ),
              const SizedBox(
                height: 15,
              ),
              InputDato(
                controlador: instrumento,
                hinText: 'Instrumento',
              ),
              const SizedBox(
                height: 15,
              ),
              InputDato(
                controlador: lugar,
                hinText: 'Lugar',
              ),
              const SizedBox(
                height: 15,
              ),
              InputDato(
                controlador: ubicacion,
                hinText: 'Ubicación',
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () => {
                  if (_formKey.currentState!.validate())
                    {
                      salidaEstandar(nombre, inspector, instrumento, lugar),
                      InsertarInstalacion().agregarInstalacion(Instalacion(
                          nombre: nombre.text,
                          inspector: inspector.text,
                          instrumento: instrumento.text,
                          lugar: lugar.text,
                          ubicacion: ubicacion.text,
                          timestamp:
                              DateTime.now().millisecondsSinceEpoch ~/ 1000)),
                      agregarInstalacion(Instalacion(
                          nombre: nombre.text,
                          inspector: inspector.text,
                          instrumento: instrumento.text,
                          lugar: lugar.text,
                          ubicacion: ubicacion.text,
                          timestamp:
                              DateTime.now().millisecondsSinceEpoch ~/ 1000)),
                      nombre.text = '',
                      inspector.text = '',
                      instrumento.text = '',
                      lugar.text = '',
                      ubicacion.text = '',
                      Navigator.pushNamed(context, 'formInspeccion')
                    }
                },
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputDato extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;

  const InputDato(
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
          validator: (value) {
            if (value!.isEmpty) {
              return 'Por favor ingrese $hinText';
            }
            return null;
          },
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

salidaEstandar(TextEditingController nombre, TextEditingController inspector,
    TextEditingController instrumento, TextEditingController lugar) {
  print("nombre es ${nombre.text}");
  print("inspector es ${inspector.text}");
  print("instrumento es ${instrumento.text}");
  print("lugar es ${lugar.text}");
}
