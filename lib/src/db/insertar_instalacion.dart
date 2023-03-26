import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/models/instalacion_model.dart';

class InsertarInstalacion {
  Future<void> agregarInstalacion(Instalacion install) async {
    final db = await DatabaseProvider.db.database;
    await db!.insert(DatabaseProvider.installTABLENAME, install.toMap());
  }
}
