import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/contact.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY,'
        'name TEXT,'
        'account_number INTEGER)',
      );
    },
    version: 1,
  );
}
