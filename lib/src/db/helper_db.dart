import 'package:cloud_firestore/cloud_firestore.dart';
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
        "CREATE TABLE $clientTABLENAME (clienteID INTEGER PRIMARY KEY AUTOINCREMENT, cliente TEXT, ciudad TEXT, trimestre TEXT, timestamp INTEGER)");

    await db.execute(
        "CREATE TABLE $anexoTABLENAME (anexoID INTEGER PRIMARY KEY AUTOINCREMENT, nombreInstalacion TEXT, ubicacionInstalacion TEXT, equipoCritico TEXT, inspeccionTecnicaRiesgo TEXT, nombrePersonal TEXT, fechaInicioInspeccion TEXT, horaInicioInspeccion TEXT, fechafinalizacionInspeccion TEXT, horafinalizacionInspeccion TEXT, velocidadViento TEXT, temperatura TEXT, instrumentoUtilizado TEXT, fechaCalibracion TEXT, desviacionProcedimiento TEXT, justificacionDesviacion TEXT, interferenciaDeteccion TEXT, concentracionPrevia TEXT, reparado TEXT, fechaReparacion TEXT, horaReparacion TEXT, fechaComprobacionReparacion TEXT, horaComprobacionReparacion TEXT, concentracionPosteriorReparacion TEXT, noReparadofaltaComponentes TEXT, fechaRemisionComponente TEXT, fechaReperacionComponente TEXT, fechaRemplazoEquipo TEXT, volumenMetano TEXT, fuga TEXT, observacionPersonal TEXT, observacion TEXT, imagen TEXT, imagenInfrarroja TEXT, timestamp INTEGER, clienteID INTEGER NOT NULL, FOREIGN KEY(clienteID) REFERENCES $clientTABLENAME(clienteID))");
  }

  static Future<List<Map<String, dynamic>>> getDataFromTable(String tableName) async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> data = await db!.query(tableName);
    return data;
  }

  static Future<void> sincronizarDatosCliente() async {
    final db =  await DatabaseProvider.db.database;
    final data = await db!.query(clientTABLENAME);

    for (final row in data) {
      final id = row['clienteID'].toString();
      final docRef = FirebaseFirestore.instance.collection('Clientes').doc(id);
      await docRef.set(row, SetOptions(merge: true));
    }
  }

  static Future<void> sincronizarDatosAnexo() async {
    final db =  await DatabaseProvider.db.database;
    final data = await db!.query(clientTABLENAME);

    for (final row in data) {
      final id = row['anexoID'].toString();
      final docRef = FirebaseFirestore.instance.collection('AnexoV').doc(id);
      await docRef.set(row, SetOptions(merge: true));
    }
  }
}
