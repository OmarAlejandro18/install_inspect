import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/db/insertar_cliente.dart';
import 'package:install_inspect/src/models/cliente_model.dart';
import 'package:install_inspect/src/providers/providers.dart';
import 'package:install_inspect/src/screens/screens.dart';
import 'package:install_inspect/src/theme/app_tema.dart';
import 'package:provider/provider.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final _formKey = GlobalKey<FormState>();

  final clienteID = TextEditingController();

  final cliente = TextEditingController();

  final ciudad = TextEditingController();

  final trimestre = TextEditingController();

  final idDespues = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  //late final clienteID;

  final List<DropdownMenuItem<Cliente>> _clientDropdownItems = [
    const DropdownMenuItem<Cliente>(
      value: null,
      child: Text("Crear nuevo cliente"),
    ),
  ];
  Cliente? _selectedCliente;
  final FocusNode _dropdownFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getClients();
  }

  void getClients() async {
    final clientsData = await DatabaseProvider.getDataFromTable('cliente');

    if (clientsData.isEmpty) {
      print('no tengo datos');
    } else {
      final List<Cliente> clients =
          clientsData.map((data) => Cliente.fromMap(data)).toList();
      _clientDropdownItems.addAll(clients.map((client) {
        return DropdownMenuItem<Cliente>(
          value: client,
          child: Text(client.cliente),
        );
      }).toList());
      if (_selectedCliente == null && clients.isNotEmpty) {
        setState(() {
          _selectedCliente = clients[0];
        });
      }
    }
    final db = await DatabaseProvider.db.database;
    final lastId = await db!.rawQuery('SELECT last_insert_rowid() as id');

    if (lastId.isNotEmpty) {
      final Object? clientId = lastId.first['id'];
      print('Último ID insertado en la tabla de clientes: $clientId');
    }
  }

  // obtenerDatosAnexo() async {
  //   final anexosData = await DatabaseProvider.getDataFromTable(
  //       DatabaseProvider.anexoTABLENAME);
  // }

  @override
  Widget build(BuildContext context) {
    final hayCliente = Provider.of<ClienteProvider>(context);

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
              height: 20,
            ),
            const Padding(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 25),
                child: Text(
                    "Selecciona una opción, en caso de no estar la opción que requiere seleccione 'Crear nuevo cliente'")),
            Padding(
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
                child: DropdownButtonFormField<Cliente>(
                  focusNode: _dropdownFocusNode,
                  value: _selectedCliente,
                  items: _clientDropdownItems,
                  onChanged: (value) {
                    if (value == null) {
                      hayCliente.setCliente = value.toString();
                      idDespues.text =
                          (DateTime.now().millisecondsSinceEpoch ~/ 1000)
                              .toString();
                      cliente.text = '';
                      ciudad.text = '';
                      trimestre.text = '';
                    } else {
                      setState(() {
                        _selectedCliente = value;
                        clienteID.text = value.clienteID.toString();
                        idDespues.text = '';
                        cliente.text = value.cliente;
                        ciudad.text = value.ciudad;
                        trimestre.text = value.trimestre;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Selecciona el Cliente',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            hayCliente.getCliente == 'null' && hayCliente.getCliente != ''
                ? NuevoClienteForm(
                    clienteID: clienteID,
                    cliente: cliente,
                    ciudad: ciudad,
                    trimestre: trimestre,
                    formKey: _formKey,
                    idDespues: idDespues,
                  )
                : NuevoClienteForm(
                    clienteID: clienteID,
                    cliente: cliente,
                    ciudad: ciudad,
                    trimestre: trimestre,
                    formKey: _formKey,
                    idDespues: idDespues,
                  ),
          ],
        ),
      )),
    );
  }
}

class NuevoClienteForm extends StatelessWidget {
  const NuevoClienteForm(
      {super.key,
      required this.clienteID,
      required this.cliente,
      required this.ciudad,
      required this.trimestre,
      required this.formKey,
      required this.idDespues});

  final GlobalKey<FormState> formKey;

  final TextEditingController clienteID;

  final TextEditingController cliente;

  final TextEditingController ciudad;

  final TextEditingController trimestre;

  final TextEditingController idDespues;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          'Datos del Cliente',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 25,
        ),
        EntradaDato(
          controlador: cliente,
          hinText: 'Nombre del cliente',
        ),
        const SizedBox(
          height: 15,
        ),
        EntradaDato(
          controlador: ciudad,
          hinText: 'Ciudad',
        ),
        const SizedBox(
          height: 15,
        ),
        DropdownTrimestre(
          trimestre: trimestre,
        ),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: 200,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                if (clienteID.text != '' && idDespues.text == '') {
                  final String trimestreN = trimestre.text;
                  print('ya se tiene un registro');
                  print('id del cliente que ya esta ${clienteID.text}');
                  print('id del cleinte nuevo es ${idDespues.text}');
                  print(
                      'el trimestre cuando ya se tiene registro es ${trimestreN}');

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormularioAnexoScreen(
                              clienteID: int.parse(clienteID.text),
                              trimestre: trimestreN,
                            )),
                  );

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => FormularioAnexoScreen(
                  //       clienteID: int.parse(clienteID.text),
                  //       trimestre: trimestreN,
                  //     ),
                  //   ),
                  // );
                  // cliente.text = '';
                  // ciudad.text = '';
                  // trimestre.text = '';
                }

                if (idDespues.text != '' &&
                    (idDespues.text != clienteID.text)) {
                  final String trimestreN = trimestre.text;
                  print('id del cliente que ya esta ${clienteID.text}');
                  print('id del cleinte nuevo es ${idDespues.text}');
                  print(
                      'el trimestre cuando el registro es nuevo ${trimestreN}');
                  print('registrar nuevo cliente');
                  InsertarCliente().agregarCliente(Cliente(
                    clienteID: (int.parse(idDespues.text)),
                    cliente: cliente.text,
                    ciudad: ciudad.text,
                    trimestre: trimestre.text,
                  ));

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FormularioAnexoScreen(
                              clienteID: int.parse(idDespues.text),
                              trimestre: trimestreN,
                            )),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => FormularioAnexoScreen(
                  //       clienteID: int.parse(idDespues.text),
                  //       trimestre: trimestreN,
                  //     ),
                  //   ),
                  // );

                  // cliente.text = '';
                  // ciudad.text = '';
                  // trimestre.text = '';
                }

                // print('id del cliente ${clienteID.text}');
                // print('nombre cliente ${cliente.text}');
                // print('ciudad del cliente ${ciudad.text}');
                // print('trimestre del cliente ${trimestre.text}');

                // if (clienteID.text != null && clienteID != '') {

                // } else {
                //   InsertarCliente().agregarCliente(Cliente(
                //     clienteID: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                //     cliente: cliente.text,
                //     ciudad: ciudad.text,
                //     trimestre: trimestre.text,
                //   ));
                // }

                //clienteID.text = '';

                // ignore: use_build_context_synchronously
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => FormularioAnexoScreen(
                //             clienteID: clienteID.value as int,
                //           )),
                // );
              }
            },
            child: const Text('Guardar Cliente'),
          ),
        )
      ],
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
              return 'Por favor Ingrese $hinText';
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
          value: widget.trimestre.text != ''
              ? widget.trimestre.text
              : _dropdownValue,
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
