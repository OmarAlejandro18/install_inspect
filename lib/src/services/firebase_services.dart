import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getInstalacion() async {
  List instalacion = [];
  CollectionReference collectionReferenceInstalacion =
      db.collection('instalacion');
  QuerySnapshot queryInstalacion = await collectionReferenceInstalacion.get();
  queryInstalacion.docs.forEach((documento) {
    instalacion.add(documento.data());
  });
  return instalacion;
}
