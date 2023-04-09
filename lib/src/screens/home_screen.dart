import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/db/obtener_datos.dart';
import 'package:install_inspect/src/screens/formulario_cliente_screen.dart';
import 'package:install_inspect/src/theme/app_tema.dart';
import '../services/firebase_services.dart';

final _scaffey = GlobalKey<ScaffoldState>();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        FirebaseDatabase.instance.goOnline();
      }
    });
  }

  hayDatosInspeccion() async {
    List<Map<String, dynamic>> datosIns = await getDataFromTable('anexocinco');
    if (datosIns.isNotEmpty) {
      return true;
    } else {
      return false;
    }
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
              if (await hayDatosInspeccion()) {
                print('si hay datos');
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // Impedir cerrar el AlertDialog al hacer clic fuera de él
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sincronizando...'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text('Por favor, espera...'),
                        ],
                      ),
                    );
                  },
                );
                setState(() {
                  _isLoading = true; // Mostrar indicador de carga
                });

                // Simular espera de 2 segundos
                await Future.delayed(const Duration(seconds: 10));

                // Llamar a los métodos de sincronización
                await DatabaseProvider.sincronizarDatosCliente();
                await DatabaseProvider.sincronizarDatosAnexo();

                setState(() {
                  _isLoading = false; // Ocultar indicador de carga
                });

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                _showSnackBar();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getDataCliente(),
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

  void _showSnackBar() {
    SnackBar snackBar =
        const SnackBar(content: Text('Datos subidos a la Nube Exitosamente'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
