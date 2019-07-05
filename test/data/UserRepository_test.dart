import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dailymedicaltrivia2/data/UserRepository.dart';
import 'package:dailymedicaltrivia2/data/AppDatabaseProvider.dart';
import 'package:dailymedicaltrivia2/data/DMTAPIProvider.dart';
import 'package:dailymedicaltrivia2/data/LocalJsonProvider.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';

class MockAPI extends Mock implements APIProvider {}

class MockDB extends Mock implements DatabaseProvider {}

class MockJson extends Mock implements JsonProvider {}

void main() {
  group('UserRepository initially:', () {
    test('asks database for existing levels and emits the non-zero result', () {
      APIProvider apiProvider = MockAPI();
      DatabaseProvider dbProvider = MockDB();
      JsonProvider jsonProvider = MockJson();
      List<Level> _levelsFromDB = [Level(), Level(), Level()];
      when(dbProvider.getExistingLevels())
          .thenAnswer((_) async => _levelsFromDB);
      expect(
          UserRepository(
            apiProvider: apiProvider,
            dbProvider: dbProvider,
            jsonProvider: jsonProvider,
          ).levelStream,
          emitsInOrder([
            [],
            _levelsFromDB,
          ]));
    });
  });

  test('asks api for for new level track when database has 0 existing levels',
      () {
    APIProvider apiProvider = MockAPI();
    DatabaseProvider dbProvider = MockDB();
    JsonProvider jsonProvider = MockJson();
    List<Level> _levelsFromDB = [];
    when(dbProvider.getExistingLevels()).thenAnswer((_) async => _levelsFromDB);
    List<Level> _levelsFromAPI = [Level(), Level(), Level()];
    when(apiProvider.getStartingListOfLevels())
        .thenAnswer((_) async => _levelsFromAPI);
    expect(
        UserRepository(
          apiProvider: apiProvider,
          dbProvider: dbProvider,
          jsonProvider: jsonProvider,
        ).levelStream,
        emitsInOrder([
          [],
          _levelsFromAPI,
        ]));
  });

  test(
      'asks localjson for for new level track when database AND api have 0 levels',
      () {
    APIProvider apiProvider = MockAPI();
    DatabaseProvider dbProvider = MockDB();
    JsonProvider jsonProvider = MockJson();
    List<Level> _levelsFromDB = [];
    when(dbProvider.getExistingLevels()).thenAnswer((_) async => _levelsFromDB);
    List<Level> _levelsFromAPI = [];
    when(apiProvider.getStartingListOfLevels())
        .thenAnswer((_) async => _levelsFromAPI);
    List<Level> _levelsFromJson = [Level(), Level(), Level()];
    when(jsonProvider.getStartingListOfLevels())
        .thenAnswer((_) async => _levelsFromJson);
    expect(
        UserRepository(
          apiProvider: apiProvider,
          dbProvider: dbProvider,
          jsonProvider: jsonProvider,
        ).levelStream,
        emitsInOrder([
          [],
          _levelsFromJson,
        ]));
  });

  test(
      'sends levels to database when creating level track from local json file',
      () async {
    APIProvider apiProvider = MockAPI();
    DatabaseProvider dbProvider = MockDB();
    JsonProvider jsonProvider = MockJson();
    List<Level> _levelsFromDB = [];
    when(dbProvider.getExistingLevels()).thenAnswer((_) async => _levelsFromDB);
    List<Level> _levelsFromAPI = [];
    when(apiProvider.getStartingListOfLevels())
        .thenAnswer((_) async => _levelsFromAPI);
    List<Level> _levelsFromJson = [Level(), Level(), Level()];
    when(jsonProvider.getStartingListOfLevels())
        .thenAnswer((_) async => _levelsFromJson);

    UserRepository repo = UserRepository.noInitialisations(
      apiProvider: apiProvider,
      dbProvider: dbProvider,
      jsonProvider: jsonProvider,
    );
    await repo.initialiseLevels();
    verifyInOrder([
      dbProvider.getExistingLevels(),
      dbProvider.insertOrUpdateListOfLevels(_levelsFromJson),
    ]);
  });
}
