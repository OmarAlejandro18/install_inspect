import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/screens/formulario_cliente_screen.dart';
import 'package:install_inspect/src/services/sincronizacion_datos.dart';
import 'package:install_inspect/src/theme/app_tema.dart';
import '../services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _scaffey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        FirebaseDatabase.instance.goOnline();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffey,
      appBar: AppBar(
        title: const Center(
          child: Text('Datos Instalación-Inspección'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cloud),
            onPressed: () async {
              // Aquí puedes colocar el código que se ejecutará cuando se presione el botón
              await DatabaseProvider.sincronizarDatosCliente();
              await DatabaseProvider.sincronizarDatosAnexo();
              //await subirRegistrosAFirebaseStorage();
              _showSnackBar();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getDataInstalacionFirestore(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              return Card(
                elevation: 1,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          'Cliente N° ${i + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Nombre del cliente: ${snapshot.data!.docs[i]['cliente']}'),
                        const SizedBox(height: 5),
                        Text('Ciudad:   ${snapshot.data!.docs[i]['ciudad']}'),
                        const SizedBox(height: 5),
                        Text(
                            'Trimestre:   ${snapshot.data!.docs[i]['trimestre']}'),
                        const SizedBox(height: 5),
                        Text(
                            'Timestamp:   ${snapshot.data!.docs[i]['timestamp']}'),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primary,
        onPressed: () => {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ClienteScreen()),
          )
        },
        //Navigator.pushNamed(context, 'clienteScreen'),
        child: const Icon(Icons.add),
      ),
    );
  }


void _showSnackBar(){
  SnackBar snackBar = const SnackBar(
    content: Text('Datos subidos a la Nube Exitosamente')
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
