import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:dailymedicaltrivia2/data/AppDatabaseProvider.dart';
import 'package:dailymedicaltrivia2/data/DMTAPIProvider.dart';
import 'package:dailymedicaltrivia2/data/LocalJsonProvider.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';

class UserRepository {
  final APIProvider apiProvider;
  final DatabaseProvider dbProvider;
  final JsonProvider jsonProvider;
  List<Level> levels = [];

  final _levelController = BehaviorSubject.seeded(<Level>[]);

  UserRepository({
    @required this.apiProvider,
    @required this.dbProvider,
    @required this.jsonProvider,
  })  : assert(apiProvider != null),
        assert(dbProvider != null),
        assert(jsonProvider != null) {
    initialiseLevels();
  }

  ///Used for testing purposes
  UserRepository.noInitialisations({
    @required this.apiProvider,
    @required this.dbProvider,
    @required this.jsonProvider,
  })  : assert(apiProvider != null),
        assert(dbProvider != null),
        assert(jsonProvider != null);


  Stream get levelStream => _levelController.stream;

  Future<void> initialiseLevels() async {
    levels = await dbProvider.getExistingLevels();
    if (levels.length == 0) {
      levels = await apiProvider.getStartingListOfLevels();
    }
    if (levels.length == 0) {
      levels = await jsonProvider.getStartingListOfLevels();
    }
    await dbProvider.insertOrUpdateListOfLevels(levels);
    _levelController.sink.add(levels);
  }

  void dispose() {
    _levelController.close();
  }
}

/*
[
        Level(iconPath: 'assets/levelicons/cardiology.png', isComplete: true),
        Level(iconPath: 'assets/levelicons/anaesthetics.png', isComplete: true),
        Level(iconPath: 'assets/levelicons/dermatology.png', isComplete: true, isMastered: true),
        Level(iconPath: 'assets/levelicons/endocrinology.png', isComplete: true),
        Level(iconPath: 'assets/levelicons/gastroenterology.png', isComplete: true),
        Level(iconPath: 'assets/levelicons/haematology.png', isComplete: true, isMastered: true),
        Level(iconPath: 'assets/levelicons/infectiousdisease.png', isComplete: true),
        Level(iconPath: 'assets/levelicons/nephrology.png', isComplete: true),
        Level(iconPath: 'assets/levelicons/neurology.png'),
        Level(iconPath: 'assets/levelicons/obstetrics.png'),
        Level(iconPath: 'assets/levelicons/ophthalmology.png'),
        Level(iconPath: 'assets/levelicons/orthopaedics.png'),
        Level(iconPath: 'assets/levelicons/paediatrics.png'),
        Level(iconPath: 'assets/levelicons/psychiatry.png'),
        Level(iconPath: 'assets/levelicons/reproductivemedicine.png'),
        Level(iconPath: 'assets/levelicons/respiratory.png'),
        Level(iconPath: 'assets/levelicons/cardiology.png'),
        Level(iconPath: 'assets/levelicons/anaesthetics.png'),
        Level(iconPath: 'assets/levelicons/dermatology.png'),
        Level(iconPath: 'assets/levelicons/endocrinology.png'),
        Level(iconPath: 'assets/levelicons/gastroenterology.png'),
        Level(iconPath: 'assets/levelicons/haematology.png'),
        Level(iconPath: 'assets/levelicons/infectiousdisease.png'),
        Level(iconPath: 'assets/levelicons/nephrology.png'),
        Level(iconPath: 'assets/levelicons/neurology.png'),
        Level(iconPath: 'assets/levelicons/obstetrics.png'),
        Level(iconPath: 'assets/levelicons/ophthalmology.png'),
        Level(iconPath: 'assets/levelicons/orthopaedics.png'),
        Level(iconPath: 'assets/levelicons/paediatrics.png'),
        Level(iconPath: 'assets/levelicons/psychiatry.png'),
        Level(iconPath: 'assets/levelicons/reproductivemedicine.png'),
        Level(iconPath: 'assets/levelicons/respiratory.png'),
        Level(iconPath: 'assets/levelicons/cardiology.png'),
        Level(iconPath: 'assets/levelicons/anaesthetics.png'),
        Level(iconPath: 'assets/levelicons/dermatology.png'),
        Level(iconPath: 'assets/levelicons/endocrinology.png'),
        Level(iconPath: 'assets/levelicons/gastroenterology.png'),
        Level(iconPath: 'assets/levelicons/haematology.png'),
        Level(iconPath: 'assets/levelicons/infectiousdisease.png'),
        Level(iconPath: 'assets/levelicons/nephrology.png'),
        Level(iconPath: 'assets/levelicons/neurology.png'),
        Level(iconPath: 'assets/levelicons/obstetrics.png'),
        Level(iconPath: 'assets/levelicons/ophthalmology.png'),
        Level(iconPath: 'assets/levelicons/orthopaedics.png'),
        Level(iconPath: 'assets/levelicons/paediatrics.png'),
        Level(iconPath: 'assets/levelicons/psychiatry.png'),
        Level(iconPath: 'assets/levelicons/reproductivemedicine.png'),
        Level(iconPath: 'assets/levelicons/respiratory.png'),
        Level(iconPath: 'assets/levelicons/cardiology.png'),
        Level(iconPath: 'assets/levelicons/anaesthetics.png'),
        Level(iconPath: 'assets/levelicons/dermatology.png'),
        Level(iconPath: 'assets/levelicons/endocrinology.png'),
        Level(iconPath: 'assets/levelicons/gastroenterology.png'),
        Level(iconPath: 'assets/levelicons/haematology.png'),
        Level(iconPath: 'assets/levelicons/infectiousdisease.png'),
        Level(iconPath: 'assets/levelicons/nephrology.png'),
        Level(iconPath: 'assets/levelicons/neurology.png'),
        Level(iconPath: 'assets/levelicons/obstetrics.png'),
        Level(iconPath: 'assets/levelicons/ophthalmology.png'),
        Level(iconPath: 'assets/levelicons/orthopaedics.png'),
        Level(iconPath: 'assets/levelicons/paediatrics.png'),
        Level(iconPath: 'assets/levelicons/psychiatry.png'),
        Level(iconPath: 'assets/levelicons/reproductivemedicine.png'),
        Level(iconPath: 'assets/levelicons/respiratory.png'),
      ]
 */
