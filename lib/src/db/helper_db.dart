import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseProvider {
  static const String installTABLENAME = 'instalacion';
  static const String inspectTABLENAME = 'inspeccion';

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
        "CREATE TABLE $installTABLENAME (instalacionID INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT, inspector TEXT, instrumento TEXT, lugar TEXT, ubicacion TEXT)");

    await db.execute(
        "CREATE TABLE $inspectTABLENAME (inspeccionID INTEGER PRIMARY KEY AUTOINCREMENT, equipoComponente TEXT, fechaInicioInspeccion TEXT, horaInicioInspeccion TEXT, fechafinalizacionInspeccion TEXT, horafinalizacionInspeccion TEXT, temperatura TEXT, corrienteAireKMH TEXT, fuga TEXT, concentracion TEXT, reparado TEXT, fechaReparacion TEXT, horaReparacion TEXT, concentracionFuga TEXT, faltaComponentes TEXT, fechaCompraNuevoComponente TEXT, fechaReparacionNuevoComponente TEXT, concentracionMetano TEXT, foto TEXT, fotoTermografica TEXT)");
  }
}
