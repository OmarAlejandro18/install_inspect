import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/services/sincronizacion_datos.dart';
import '../services/firebase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        FirebaseDatabase.instance.goOnline();
      }
    });
    obtenerDatosCliente();
    obtenerDatosAnexo();
  }


obtenerDatosCliente() async {
  final clientesData = await DatabaseProvider.getDataFromTable(DatabaseProvider.clientTABLENAME);
    print('los datos de clientes son: ${clientesData}');
}
  

obtenerDatosAnexo() async {
  final anexosData = await DatabaseProvider.getDataFromTable(DatabaseProvider.anexoTABLENAME);
  print('los datos son: ${anexosData}');
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Datos Instalación-Inspección'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
            // Aquí puedes colocar el código que se ejecutará cuando se presione el botón
            print('Botón de subir a la nube');
            await DatabaseProvider.sincronizarDatosCliente();
            await DatabaseProvider.sincronizarDatosAnexo();
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
                          'Instalación N° $i',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Nombre de instalación:   ${snapshot.data!.docs[i]['nombreInstalacion']}'),
                        const SizedBox(height: 5),
                        Text(
                            'Ubicación:   ${snapshot.data!.docs[i]['ubicacion']}'),
                        const SizedBox(height: 5),
                        Text(
                            'Tipo de equipo componente:   ${snapshot.data!.docs[i]['tipoComponente']}'),
                        const SizedBox(height: 5),
                        Text(
                            'Equipo Critico:   ${snapshot.data!.docs[i]['equipoCritico']}'),
                        const SizedBox(height: 5),
                        Text(
                            'Inspección tecnica del riesgo:   ${snapshot.data!.docs[i]['inspeccionTecnica']}')
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
        onPressed: () => Navigator.pushNamed(context, 'clienteScreen'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
