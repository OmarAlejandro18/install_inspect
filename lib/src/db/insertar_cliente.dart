import 'package:install_inspect/src/db/helper_db.dart';
import 'package:install_inspect/src/models/cliente_model.dart';
class InsertarCliente {
  Future<int?> agregarCliente(Cliente cliente) async {
    final db = await DatabaseProvider.db.database;
    int id = await db!.insert(DatabaseProvider.clientTABLENAME, cliente.toMap());
    return id;
  }
}
