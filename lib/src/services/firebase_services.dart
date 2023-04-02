import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:install_inspect/src/models/inspeccion_model.dart';
import 'package:install_inspect/src/models/instalacion_model.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getInstalacion() async {
  List instalacion = [];
  CollectionReference collectionReferenceInstalacion =
      db.collection('instalacion');
  QuerySnapshot queryInstalacion = await collectionReferenceInstalacion.get();
  for (var documento in queryInstalacion.docs) {
    instalacion.add(documento.data());
  }
  await Future.delayed(const Duration(seconds: 2));
  return instalacion;
}

Future<void> agregarInstalacion(Instalacion instalacion) async {
  await db.collection('instalacion').add(instalacion.toMap());
}

Future<void> agregarInspeccion(Inspeccion inspeccion) async {
  await db.collection('inspeccion').add(inspeccion.toMap());
}
