import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {

  ///No support for testing of plugins as of 4/7/19


  ///Clear test database
  /*
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'test.db');
  if (await databaseExists(path)) {
    await deleteDatabase(path);
  }
  */
  test('Table can create from scratch and upgrade completely', () {

  }, skip: true);
}