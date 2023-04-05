import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:install_inspect/src/models/cliente_model.dart';
import 'package:install_inspect/src/models/inspeccion_model.dart';
import 'package:install_inspect/src/models/instalacion_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Stream<QuerySnapshot> getDataInstalacionFirestore() {
  return db.collection('Clientes').orderBy('timestamp').snapshots();
}

Future<DocumentSnapshot> getFirestoreData() async {
  DocumentSnapshot snapshot =
      await db.collection('tu_coleccion').doc('tu_documento').get();
  return snapshot;
}

Stream<QuerySnapshot> getDataInspeccionFirestore() {
  return db.collection('inspeccion').orderBy('timestamp').snapshots();
}

Future<void> agregarClienteFirestore(Cliente cliente) async {
  await db.collection('clientes').add(cliente.toMap());
}

Future<void> agregarInstalacion(Instalacion instalacion) async {
  await db.collection('instalacion').add(instalacion.toMap());
}

Future<void> agregarInspeccion(Inspeccion inspeccion) async {
  await db.collection('inspeccion').add(inspeccion.toMap());
}
