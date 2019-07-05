import 'package:flutter/foundation.dart';
import 'dart:convert';

class Answer {
  final bool correct;
  final String id;
  final String questionID;
  final String string;

  Answer({
    @required this.correct,
    @required this.id,
    @required this.questionID,
    @required this.string,
  });

  Answer.fromJson(dynamic json)
      : correct = _setCorrectByString(json['correct']),
        id = json['id'],
        questionID = json['question-id'],
        string = json['string'];

  static bool _setCorrectByString(String str) {
    if (str == "YES") {
      return true;
    } else if (str == "NO") {
      return false;
    }
    throw Exception("Correct property must be YES or NO");
  }
}
