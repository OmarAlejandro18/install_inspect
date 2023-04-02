// import 'package:firebase_database/firebase_database.dart';
// import 'package:install_inspect/src/models/inspeccion_model.dart';
// import 'package:install_inspect/src/models/instalacion_model.dart';

// // ignore: unused_element
// final _databaseReference = FirebaseDatabase.instance.ref().child('instalacion');
// // ignore: unused_element
// final _bdreference = FirebaseDatabase.instance.ref().child('inspeccion');

// // Escribir datos en la base de datos
// void guardarInstalacionTiempoReal(Instalacion instalacion) {
//   _databaseReference.push().set(instalacion.toMap());
// }

// void guardarInspeccionTiempoReal(Inspeccion inspeccion) {
//   _bdreference.push().set(inspeccion.toMap());
// }

// // Leer datos de la base de datos
// //void obtDatosInstalacionTiempoReal() => _databaseReference;