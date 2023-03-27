import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/models/inspeccion_model.dart';
import 'package:sqflite/sqflite.dart';

class InsertarInspeccion {
  Future<void> agregarInspeccion(Inspeccion inspec) async {
    final Database? db = await DatabaseProvider.db.database;
    await db!.insert(DatabaseProvider.inspectTABLENAME, inspec.toMap());
  }
}
