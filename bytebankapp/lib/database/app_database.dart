import 'package:bytebankapp/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return openDatabase(
      join(await getDatabasesPath(), 'bytebank.db'),
      onCreate: (db, version) async {
    await db.execute(ContactDao.tableSql);
  }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
}

