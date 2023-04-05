
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../db/helper_db.dart';

Future<void> subirRegistrosAFirebaseStorage() async {
  // Verificar si hay conexión a internet
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    // Obtener la ruta de la base de datos SQLite
    //Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //String path = join(documentsDirectory.path, 'InstallInspect.db');

    final db = await DatabaseProvider.db.database;
    List<Map<String, dynamic>> registros = await db!.query('anexocinco');
    // Abrir la base de datos


    // Obtener los registros de la tabla 'mi_tabla'
    //List<Map<String, dynamic>> registros = await database.query('');

    // Subir los registros a Firebase Storage
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    for (var registro in registros) {

       print('imagene en ${File(registro['imagen'])}'); 
      // Obtener la imagen del registro
      File imagen = File(registro['imagen']);

      // Subir la imagen a Firebase Storage
      String nombreArchivo = basename(imagen.path);
      Reference referencia =
          firebaseStorage.ref().child('imagenes/$nombreArchivo');
      await referencia.putFile(imagen);

      // Guardar la URL de la imagen en el registro de la base de datos
      String urlImagen = await referencia.getDownloadURL();
      await db.update('anexocinco', {'imagen': urlImagen},
          where: 'anexoID = ?', whereArgs: [registro['anexoID']]);
    }
  }
}
