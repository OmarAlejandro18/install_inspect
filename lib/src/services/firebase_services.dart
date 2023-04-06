import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Stream<QuerySnapshot> getDataCliente() {
  return db.collection('Clientes').orderBy('clienteID').snapshots();
}
