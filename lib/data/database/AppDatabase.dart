import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'TableConfig.dart';

abstract class DatabaseInterface {
  Future<void> insertOrUpdate(String tableName, Map<String, dynamic> map);
}

class AppDatabase implements DatabaseInterface {
  Database _db;
  final String _filename;
  String _path;

  bool isInitialised = false;

  ///this.filename is normally "data.db" however have not listed this as a
  ///default to prevent accidents in the testing environment.
  AppDatabase(filename) :_filename = filename;

  void delete() async {
    await deleteDatabase(_path);
  }

  Future<void> initialise() async {
    if (isInitialised) {
      return;
    } else {
      var databasesPath = await getDatabasesPath();
      _path = join(databasesPath, this._filename);
      print('AppDataBase: DELETING DATABASE FOR DEVELOPMENT REASONS');
      deleteDatabase(_path);
    }
    this._db =
    await openDatabase(_path, version: 1, onUpgrade: _onUpgrade);
    isInitialised = true;
  }

  Future<void> insertOrUpdate(String tableName,
      Map<String, dynamic> map) async {
    await initialise();
    return _db.insert(tableName, map, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion == 0) {
      newVersion = 1;
      ///Called the first time the app launches. You need a VERY GOOD REASON to
      ///change the code here, as changes to database structure should be made
      ///further down in [_onUpgrade] to ensure backwards compatibility.
      List<TableConfig> _tables = [
        TableConfig('levels', [
          ColumnConfig('id', 'TEXT PRIMARY KEY'),
          ColumnConfig('icon_alias', 'TEXT'),
          ColumnConfig('is_complete', 'REAL'),
          ColumnConfig('is_mastered', 'REAL'),
          ColumnConfig('name', 'TEXT'),
          ColumnConfig('order_in_sequence', 'REAL'),
          ColumnConfig('pass_mark', 'REAL'),
          ColumnConfig('question_time_limit', 'INTEGER'),
          ColumnConfig('total_time_limit', 'INTEGER'),
        ]),
      ];
      _tables.forEach((table) async {
        String _query = _newTableQueryFromTable(table);
        await db.execute(_query);
      });
    }
  }

  String _newTableQueryFromTable(TableConfig table) {
    String _query = 'CREATE TABLE ';
    _query = _query + table.name;
    _query = _query + ' (';
    table.cols.forEach((col) {
      _query = _query + col.name + ' ';
      _query = _query + col.type + ', ';
    });
    _query = _query.substring(0, _query.length - 2);
    _query = _query + ')';
    //print('Set up query is: "$_query"');
    return _query;
  }

}
