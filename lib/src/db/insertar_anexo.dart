import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/models/anexocinco_model.dart';

class InsertarAnexoCinco {
  Future<void> insertarAnexoCinco(AnexoCinco anexoCinco) async {
    final db = await DatabaseProvider.db.database;
    await db!.insert(DatabaseProvider.anexoTABLENAME, anexoCinco.toMap());
  }
}
