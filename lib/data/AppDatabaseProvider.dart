import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:dailymedicaltrivia2/data/database/AppDatabase.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';

abstract class DatabaseProvider {
  Future<List<Level>> getExistingLevels();
  Future<void> insertOrUpdateLevel(Level level);
  Future<void> insertOrUpdateListOfLevels(List<Level> levels);
}

class AppDatabaseProvider implements DatabaseProvider {

  final AppDatabase database;

  AppDatabaseProvider({@required this.database,}):assert(database!=null);

  @override
  Future<List<Level>> getExistingLevels() async {
    if (!database.isInitialised) {
      await database.initialise();
    }
    return [];
  }

  Future<void> insertOrUpdateLevel(Level level) async {
    return database.insertOrUpdate('levels', level.toMap());
  }

  @override
  Future<void> insertOrUpdateListOfLevels(List<Level> levels) async {
    return levels.forEach((level) async {
      await insertOrUpdateLevel(level);
    });
  }
}