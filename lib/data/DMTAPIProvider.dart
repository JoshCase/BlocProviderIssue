import 'dart:async';

import 'package:dailymedicaltrivia2/model/Level.dart';

abstract class APIProvider {
  Future<List<Level>> getStartingListOfLevels();
}

class DMTAPIProvider implements APIProvider {
  @override
  Future<List<Level>> getStartingListOfLevels() async {
    // TODO: implement getStartingListOfLevels
    return [];
  }

}