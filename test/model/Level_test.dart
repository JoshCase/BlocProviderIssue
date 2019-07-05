import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';
import 'package:dailymedicaltrivia2/model/Question.dart';

void main() {

  test('Level builds correctly from Json', () {
    String str = """{ "icon-alias": "Dermatology", "id": "zDYPkn3XsRDuN3J3izSiJXKFM1ofT44d", "name": "ImportedLevelName", "order-in-sequence": 0, "pass-mark": 1, "question-time-limit": 0, "total-time-limit": 60, "questions": [ { "id": "835", "suitable-for-facebook": "NO", "string": "Serum albumin is synthesised exclusively by which cells?", "type": "String entry", "topic-id": "s8PpTrtprCzqbSYsIV2X8YzS1LXItv0q", "date-edited": "2018-07-28 12:04:17", "date-created": "2018-01-02 21:19:08", "answers": [ { "id": "1651", "question-id": "835", "string": "hepatocytes", "correct": "YES", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:08" } ], "attempts": { "list": { "1651": 0 }, "total": 0 }, "topic": { "id": "s8PpTrtprCzqbSYsIV2X8YzS1LXItv0q", "name": "Gastroenterology", "date-created": "2018-07-28 10:32:32" } }, { "id": "793", "suitable-for-facebook": "NO", "string": "The superior and inferior mesenteric veins drain into the inferior vena cava.", "type": "True-False", "topic-id": "s8PpTrtprCzqbSYsIV2X8YzS1LXItv0q", "date-edited": "2018-07-28 12:04:17", "date-created": "2018-01-02 21:19:08", "answers": [ { "id": "1558", "question-id": "793", "string": "0", "correct": "YES", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:08" } ], "attempts": { "list": { "1558": 0 }, "total": 0 }, "topic": { "id": "s8PpTrtprCzqbSYsIV2X8YzS1LXItv0q", "name": "Gastroenterology", "date-created": "2018-07-28 10:32:32" } }, { "id": "2969", "suitable-for-facebook": "NO", "string": "Which of the following is the hypothalamic hormone that stimulates ACTH secretion from the anterior pituitary?", "type": "Multiple choice", "topic-id": "EHzSq41rhjW1kC9CbJ1FTRna6IzzRwqP", "date-edited": "2018-07-28 12:04:17", "date-created": "2018-01-02 21:19:16", "answers": [ { "id": "5721", "question-id": "2969", "string": "CRH", "correct": "YES", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:16" }, { "id": "5722", "question-id": "2969", "string": "TRH", "correct": "NO", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:16" }, { "id": "5723", "question-id": "2969", "string": "GnRH", "correct": "NO", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:16" }, { "id": "5724", "question-id": "2969", "string": "Dopamine", "correct": "NO", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:16" } ], "attempts": { "list": { "5721": 0, "5722": 0, "5723": 0, "5724": 0 }, "total": 0 }, "topic": { "id": "EHzSq41rhjW1kC9CbJ1FTRna6IzzRwqP", "name": "Endocrinology", "date-created": "2018-07-28 10:32:31" } } ] }""";
    dynamic json = jsonDecode(str);
    Level level = Level.fromJson(json);
    expect(level.totalTimeLimit, 60);
    expect(level.passMark, 1);
    expect(level.name, "ImportedLevelName");
    expect(level.questions.length, 3);
    level.questions.forEach((q) {
      expect(q is Question, true);
    });
  });

  test('Correctly generates map for database', (){
    Level level = Level(
      iconAlias: 'iconAlias',
      isComplete: false,
      id: 'testID',
      isMastered: false,
      name: 'testLevelName',
      orderInSequence: 2,
      passMark: 1,
      questions: [],
      questionTimeLimit: 20,
      totalTimeLimit: 10,
    );
    Map <String, dynamic> _actualMap = level.toMap();
    Map<String, dynamic> _expectMap = {
      "icon_alias": 'iconAlias',
      "is_complete": 0,
      "id" : 'testID',
      "is_mastered": 0,
      "name": 'testLevelName',
      "order_in_sequence": 2,
      "pass_mark": 1,
      "question_time_limit": 20,
      "total_time_limit" : 10,
    };
    expect(_actualMap, _expectMap);
  });

  test('Correctly makes iconPath from iconAlias', (){
    Level level = Level(iconAlias: 'Cardiology');
    expect(level.iconPath, 'assets/levelicons/cardiology.png');
    level = Level(iconAlias: 'spaghetti');
    expect(level.iconPath, 'assets/levelicons/default.png');
  });

}