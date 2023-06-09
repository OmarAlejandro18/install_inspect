import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseProvider {
  static const String clientTABLENAME = 'cliente';
  static const String anexoTABLENAME = 'anexocinco';

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  static Future<Database> initDB() async {
    final db = await openDatabase(
      join(await getDatabasesPath(), "InstallInspect.db"),
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  static _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $clientTABLENAME (clienteID INTEGER PRIMARY KEY, cliente TEXT, ciudad TEXT, trimestre TEXT)");

    await db.execute(
        "CREATE TABLE $anexoTABLENAME (anexoID INTEGER PRIMARY KEY, nombreInstalacion TEXT, idComponente TEXT, ubicacionInstalacion TEXT, equipoCritico TEXT, inspeccionTecnicaRiesgo TEXT, nombrePersonal TEXT, fechaInicioInspeccion TEXT, horaInicioInspeccion TEXT, fechafinalizacionInspeccion TEXT, horafinalizacionInspeccion TEXT, velocidadViento TEXT, temperatura TEXT, instrumentoUtilizado TEXT, fechaCalibracion TEXT, desviacionProcedimiento TEXT, justificacionDesviacion TEXT, interferenciaDeteccion TEXT, concentracionPrevia TEXT, reparado TEXT, fechaReparacion TEXT, horaReparacion TEXT, fechaComprobacionReparacion TEXT, horaComprobacionReparacion TEXT, concentracionPosteriorReparacion TEXT, noReparadofaltaComponentes TEXT, fechaRemisionComponente TEXT, fechaReperacionComponente TEXT, fechaRemplazoEquipo TEXT, volumenMetano TEXT, fuga TEXT, observacionPersonal TEXT, observacion TEXT, imagen TEXT, imagenInfrarroja TEXT, anexoURL TEXT, informeURL TEXT, trimestre TEXT, clienteID INTEGER NOT NULL, FOREIGN KEY(clienteID) REFERENCES $clientTABLENAME(clienteID))");
  }

  static Future<void> sincronizarDatosCliente() async {
    final db = await DatabaseProvider.db.database;
    final data = await db!.query(clientTABLENAME);

    for (final row in data) {
      final id = row['clienteID'].toString();
      final docRef = FirebaseFirestore.instance.collection('Clientes').doc(id);
      await docRef.set(row, SetOptions(merge: true));
    }
  }

  static Future<void> sincronizarDatosAnexo() async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> data = await db!.query(anexoTABLENAME);

    if (data.isNotEmpty) {
      for (final row in data) {
        final id = row['anexoID'].toString();
        // Verificar si ya existen las URLs de las imágenes en el registro
        final tieneImagen1 = row['imagen']
            .toString()
            .contains('https://firebasestorage.googleapis.com');
        final tieneImagen2 = row['imagenInfrarroja']
            .toString()
            .contains('https://firebasestorage.googleapis.com');

        if (tieneImagen1 && tieneImagen2) {
          // Las URLs de las imágenes ya existen, continuar con la creación del documento en Firestore
          final anexoDocRef =
              FirebaseFirestore.instance.collection('SeccionII').doc(id);
          await anexoDocRef.set(row);
        } else {
          final List<String> imagePaths = [
            row['imagen'],
            row['imagenInfrarroja']
          ];
          final List<String> downloadUrls = [];

          // Subir las imágenes a Firebase Storage
          for (final imagePath in imagePaths) {
            if (imagePath != null && !imagePath.isEmpty) {
              final file = File(imagePath);
              final bytes = await file.readAsBytes();

              final storageRef = FirebaseStorage.instance
                  .ref()
                  .child('seccionII/${file.path.split('/').last}');
              final uploadTask = storageRef.putData(bytes);
              final snapshot = await uploadTask.whenComplete(() => null);
              final downloadUrl = await snapshot.ref.getDownloadURL();
              downloadUrls.add(downloadUrl);
            }
          }

          final updatedRow = {...row};
          if (!tieneImagen1 && downloadUrls.length > 0) {
            updatedRow['imagen'] = downloadUrls[0];
          }
          if (!tieneImagen2 && downloadUrls.length > 1) {
            updatedRow['imagenInfrarroja'] = downloadUrls[1];
          }

          await db.update(anexoTABLENAME, updatedRow,
              where: 'anexoID = ?', whereArgs: [row['anexoID']]);

          // Crear un nuevo documento en la colección de Firestore
          final anexoDocRef =
              FirebaseFirestore.instance.collection('SeccionII').doc(id);
          await anexoDocRef.set(updatedRow);
        }
      }
    }
    await db.delete('anexocinco');
  }

//   static Future<void> sincronizarDatosAnexo() async {
//     final db = await DatabaseProvider.db.database;
//     final List<Map<String, dynamic>> data = await db!.query(anexoTABLENAME);

//     for (final row in data) {
//       final id = row['anexoID'].toString();
//       // Verificar si ya existe la URL de la imagen en el registro
//       if (row['imagen']
//           .toString()
//           .contains('https://firebasestorage.googleapis.com')) {
//         // La URL de la imagen ya existe, continuar con la creación del documento en Firestore
//         final anexoDocRef =
//             FirebaseFirestore.instance.collection('SeccionII').doc(id);
//         await anexoDocRef.set(row);
//       } else {
//         // La URL de la imagen no existe, subir la imagen a Firebase Storage
//         final imagePath = row['imagen'] as String;
//         final file = File(imagePath);
//         final bytes = await file.readAsBytes();

//         final storageRef = FirebaseStorage.instance
//             .ref()
//             .child('seccionII/imagenes/${file.path.split('/').last}');
//         final uploadTask = storageRef.putData(bytes);
//         final snapshot = await uploadTask.whenComplete(() => null);
//         final downloadUrl = await snapshot.ref.getDownloadURL();
//         final updatedRow = {...row, 'imagen': downloadUrl};
//         await db.update(anexoTABLENAME, updatedRow,
//             where: 'anexoID = ?', whereArgs: [row['anexoID']]);

//         // Crear un nuevo documento en la colección de Firestore
//         final anexoDocRef =
//             FirebaseFirestore.instance.collection('SeccionII').doc(id);
//         await anexoDocRef.set(updatedRow);
//       }
//     }
//     // final db = await DatabaseProvider.db.database;
//     // final List<Map<String, dynamic>> data = await db!.query(anexoTABLENAME);

// // for (final row in data) {
// //   final id = row['anexoID'].toString();
// //   final docRef = FirebaseFirestore.instance.collection('AnexoV').doc(id);

// //   final imagePath = row['imagen'] as String;

// //   // Leer el archivo de imagen
// //   final file = File(imagePath);
// //   final bytes = await file.readAsBytes();

// //   // Subir la imagen a Firebase Storage
// //   final storageRef = FirebaseStorage.instance.ref().child('anexo_images/${file.path.split('/').last}');
// //   final uploadTask = storageRef.putData(bytes);
// //   final snapshot = await uploadTask.whenComplete(() => null);

// //   // Actualizar la URL de la imagen en la tabla de anexo en la BD de SQLite
// //   final downloadUrl = await snapshot.ref.getDownloadURL();
// //   final updatedRow = {...row, 'imagen': downloadUrl};
// //   await db.update(anexoTABLENAME, updatedRow,
// //       where: 'anexoID = ?', whereArgs: [row['anexoID']]);

// //   // Crear un nuevo documento en la colección de Firestore
// //   final anexoDocRef = FirebaseFirestore.instance.collection('anexoV').doc();
// //   await anexoDocRef.set(updatedRow);
// // }
// // for (final row in data) {
// //       final id = row['anexoID'].toString();
// //       final docRef = FirebaseFirestore.instance.collection('SeccionII').doc(id);
// //       print('los datos del row son: $row');
// //       await docRef.set(row, SetOptions(merge: true));
// //     }
//   }
}
