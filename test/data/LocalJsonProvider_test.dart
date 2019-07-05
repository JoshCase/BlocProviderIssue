import 'package:flutter_test/flutter_test.dart';
import 'package:dailymedicaltrivia2/data/LocalJsonProvider.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';

void main() {
  test('levels.json can be loaded', () async {
    LocalJsonProvider jsonProvider = LocalJsonProvider();
    List<Level> _levels = await jsonProvider.getStartingListOfLevels();
    expect(_levels.length, greaterThan(5));
    _levels.sublist(0, 5).forEach((_level) => expect(_level is Level, true));
    _levels.sublist(-5).forEach((_level) => expect(_level is Level, true));
  }, skip: true);
}