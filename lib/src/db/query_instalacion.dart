import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/models/instalacion_model.dart';
import 'package:sqflite/sqflite.dart';

class QueryInstalaciones with ChangeNotifier {
  List<Instalacion>? _instalaciones;
  List<Instalacion> get instalaciones => [...?_instalaciones];

  Future<void> updateNotas() async {
    final Database? db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db!.query("instalacion");
    _instalaciones = List.generate(
      maps.length,
      (i) {
        return Instalacion(
            //instalacionID: maps[i]['instalacionID'],
            nombreInstalacion: maps[i]['nombreInstalacion'],
            ubicacion: maps[i]['ubicacion'],
            tipoComponente: maps[i]['tipoComponente'],
            equipoCritico: maps[i]['equipoCritico'],
            inspeccionTecnica: maps[i]['inspeccionTecnica'],
            completed: maps[i]['completed'],
            timestamp: maps[i]['timestamp']);
      },
    );
    notifyListeners();
  }
}
