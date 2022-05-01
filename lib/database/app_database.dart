import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/contact.dart';

Future<Database> createDataBase() {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute('CREATE TABLE contacts('
            'id INTEGER PRIMARY KEY,'
            'name TEXT,'
            'account_number INTEGER)');
      },
      version: 1,
    );
  });
}

Future<int> save(Contact contact) {
  return createDataBase().then((db) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return db.insert('contacts', contactMap);
  });
}

Future<List<Contact>> findAll() {
  return createDataBase().then((db) {
    return db.query('contacts').then((maps) {
      final List<Contact> contacts = [];
      for (Map<String, dynamic> map in maps) {
        final Contact contact =
            Contact(map['id'], map['name'], map['account_number']);
        contacts.add(contact);
      }
      return contacts;
    });
  });
}
