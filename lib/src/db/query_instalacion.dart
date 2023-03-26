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
          instalacionID: maps[i]['instalacionID'],
          nombre: maps[i]['nombre'],
          inspector: maps[i]['inspector'],
          instrumento: maps[i]['instrumento'],
          lugar: maps[i]['lugar'],
          ubicacion: maps[i]['ubicacion'],
        );
      },
    );
    notifyListeners();
  }
}
