import 'package:flutter/material.dart';
import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/models/inspeccion_model.dart';
import 'package:sqflite/sqflite.dart';

class QueryInstalaciones with ChangeNotifier {
  List<Inspeccion>? _inspeciones;
  List<Inspeccion> get inspeciones => [...?_inspeciones];

  Future<void> updateNotas() async {
    final Database? db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db!.query("inspeccion");
    _inspeciones = List.generate(
      maps.length,
      (i) {
        return Inspeccion(
            maps[i]['inspeccionID'],
            maps[i]['fuga'],
            maps[i]['concentracion'],
            maps[i]['reparado'],
            maps[i]['fechaReparacion'],
            maps[i]['horaReparacion'],
            maps[i]['concentracionFuga'],
            maps[i]['faltaComponentes'],
            maps[i]['fechaCompraNuevoComponente'],
            maps[i]['fechaReparacionNuevoComponente'],
            maps[i]['concentracionMetano'],
            equipoComponente: maps[i]['equipoComponente'],
            fechaInicioInspeccion: maps[i]['fechaInicioInspeccion'],
            horaInicioInspeccion: maps[i]['horaInicioInspeccion'],
            fechafinalizacionInspeccion: maps[i]['fechafinalizacionInspeccion'],
            horafinalizacionInspeccion: maps[i]['horafinalizacionInspeccion'],
            temperatura: maps[i]['temperatura'],
            corrienteAireKMH: maps[i]['corrienteAireKMH'],
            foto: maps[i]['foto'],
            fotoTermografica: maps[i]['fotoTermografica']);
      },
    );
    notifyListeners();
  }
}
