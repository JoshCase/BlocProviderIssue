import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';


abstract class JsonProvider {
  Future<List<Level>> getStartingListOfLevels();
}

class LocalJsonProvider implements JsonProvider {
  @override
  Future<List<Level>> getStartingListOfLevels() async {
    List<Level> _levels = [];
    String _str = await rootBundle.loadString('assets/json/levels.json');
    List<dynamic> json = jsonDecode(_str);
    json.forEach((jsonLevel) {
      _levels.add(Level.fromJson(jsonLevel));
    });
    return _levels;
  }

}