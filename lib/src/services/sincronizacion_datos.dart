import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SyncService {
  final FirebaseFirestore firestore;
  final Database database;
  final String collectionName;
  final String tableName;

  SyncService({
    required this.firestore,
    required this.database,
    required this.collectionName,
    required this.tableName,
  });

  Future<void> syncData() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return;
    }

    final remoteData = await firestore.collection(collectionName).get();

    final localData = await database.query(tableName);

    final remoteIds = remoteData.docs.map((doc) => doc.id).toSet();
    final localIds = localData.map((data) => data['id']).toSet();

    final idsToAdd = remoteIds.difference(localIds);
    final idsToRemove = localIds.difference(remoteIds);
    final idsToUpdate = remoteIds.intersection(localIds);

    await _addData(idsToAdd, remoteData);
    await _removeData(idsToRemove.map((id) => id.toString()).toSet());
    await _updateData(idsToUpdate, remoteData);
  }

  Future<void> _addData(Set<String> idsToAdd,
      QuerySnapshot<Map<String, dynamic>> remoteData) async {
    final batch = database.batch();

    for (final doc in remoteData.docs) {
      if (idsToAdd.contains(doc.id)) {
        batch.insert(tableName, doc.data());
      }
    }

    await batch.commit();
  }

  Future<void> _removeData(Set<String> idsToRemove) async {
    final batch = database.batch();

    for (final id in idsToRemove) {
      batch.delete(tableName, where: 'id = ?', whereArgs: [id]);
    }

    await batch.commit();
  }

  Future<void> _updateData(Set<String> idsToUpdate,
      QuerySnapshot<Map<String, dynamic>> remoteData) async {
    final batch = database.batch();

    for (final doc in remoteData.docs) {
      if (idsToUpdate.contains(doc.id)) {
        batch.update(tableName, doc.data(),
            where: 'id = ?', whereArgs: [doc.id]);
      }
    }

    await batch.commit();
  }
}
