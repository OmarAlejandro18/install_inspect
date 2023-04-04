import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/insertar_cliente.dart';
import 'package:install_inspect/src/models/cliente_model.dart';
import 'package:install_inspect/src/services/firebase_services.dart';

class ClienteScreen extends StatelessWidget {
  ClienteScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final cliente = TextEditingController();
  final ciudad = TextEditingController();
  final trimestre = TextEditingController();
  late final clienteID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Clientes')),
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
              'Ingresa los datos del Cliente',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 50,
            ),
            EntradaDato(controlador: cliente, hinText: 'Nombre del cliente'),
            const SizedBox(
              height: 15,
            ),
            EntradaDato(controlador: ciudad, hinText: 'Ciudad'),
            const SizedBox(
              height: 15,
            ),
            DropdownTrimestre(
              trimestre: trimestre,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate())
                  {
                    clienteID = await InsertarCliente().agregarCliente(Cliente(
                        cliente: cliente.text,
                        ciudad: ciudad.text,
                        trimestre: trimestre.text,
                        timestamp:
                            DateTime.now().millisecondsSinceEpoch ~/ 1000)
                            );
                    
                    // agregarClienteFirestore(Cliente(
                    //     cliente: cliente.text,
                    //     ciudad: ciudad.text,
                    //     trimestre: trimestre.text,
                    //     timestamp:
                    //         DateTime.now().millisecondsSinceEpoch ~/ 1000)),
                    cliente.text = '';
                    ciudad.text = '';
                    trimestre.text = '';

                    Navigator.pushNamed(context, 'formAnexoCinco', arguments: clienteID);
                  }
              },
              child: const Text('Guardar Cliente'),
            )
          ],
        ),
      )),
    );
  }
}

class EntradaDato extends StatelessWidget {
  final TextEditingController controlador;
  final String hinText;

  const EntradaDato(
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

class DropdownTrimestre extends StatefulWidget {
  const DropdownTrimestre({super.key, required this.trimestre});
  final TextEditingController trimestre;
  @override
  State<DropdownTrimestre> createState() => _DropdownTrimestreState();
}

class _DropdownTrimestreState extends State<DropdownTrimestre> {
  String? _dropdownValue;

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
        child: DropdownButtonFormField(
          style: const TextStyle(
            color: Colors.black,
          ),
          value: _dropdownValue,
          onChanged: (value) {
            setState(() {
              _dropdownValue = value!;
              widget.trimestre.text = _dropdownValue!;
            });
          },
          items: const [
            DropdownMenuItem(
              value: '1',
              child: Text('Trimestre 1'),
            ),
            DropdownMenuItem(
              value: '2',
              child: Text('Trimestre 2'),
            ),
            DropdownMenuItem(
              value: '3',
              child: Text('Trimestre 3'),
            ),
            DropdownMenuItem(
              value: '4',
              child: Text('Trimestre 4'),
            ),
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            labelText: 'Seleccione el Trimestre',
            labelStyle: TextStyle(
              color: Colors.black38, // Aquí se cambia el color del labelText
            ),
          ),
        ),
      ),
    );
  }
}
