import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dailymedicaltrivia2/model/Answer.dart';

void main() {
  test('Answer builds correctly from JSON', () {
    String jsonString =
        '{"id": "518","question-id": "301","string": "rheumatic valvulitis","correct": "YES","date-edited": "0000-00-00 00:00:00","date-created": "2018-01-02 21:19:05"}';
    dynamic json = jsonDecode(jsonString);
    Answer answer = Answer.fromJson(json);
    expect(answer.id, "518");
    expect(answer.correct, true);
    expect(answer.questionID, "301");
    expect(answer.string, "rheumatic valvulitis");
  });
}
