import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:dailymedicaltrivia2/model/Answer.dart';
import 'package:dailymedicaltrivia2/model/QuestionAttempt.dart';
import 'package:dailymedicaltrivia2/model/Topic.dart';

class Question {
  //TODO: Construct with ID
  final List<Answer> answers;

  final String id;
  final String string;
  final Topic topic; //TODO: replace topicName with final Topic topic;
  final String type;

  Question({
    @required this.answers,
    this.id = 'testQuestionID',
    @required this.string,
    @required this.topic,
    @required this.type,
  });

  Question.fromJson(json)
      : this.answers = _getAnswersFromJson(json['answers']),
        this.id = json['id'],
        this.string = json['string'],
        this.topic = _getTopicFromJson(json['topic']),
        this.type = _getQuestionTypeFromString(json['type']);

  bool isAnsweredCorrectlyBy(QuestionAttempt _attempt) {
    bool isCorrect = false;
    answers.forEach((a) {
      if (a.correct == true) {
        if (a.id==_attempt.answerID) {
          isCorrect = true;
          return;
        }
        if (a.string.toLowerCase().trim() == _attempt.answerString.toLowerCase().trim()) {
          isCorrect = true;
          return;
        }
      }
    });
    return isCorrect;
  }

  Answer firstCorrectAnswer() {
    Answer _answer;
    answers.forEach((a) {
      if (a.correct) {
        _answer = a;
      }
    });
    return _answer;
  }

  static List<Answer> _getAnswersFromJson(jsonAnswers) {
    List<Answer> _answers = [];
    jsonAnswers.forEach((a) {
      _answers.add(Answer.fromJson(a));
    });
    return _answers;
  }

  static String _getQuestionTypeFromString(String str) {
    if (QuestionType.isSupported(str)) {
      return str;
    } else {
      throw Exception("Cannot support question type: $str");
    }
  }

  static Topic _getTopicFromJson(json) {
    return Topic.fromJson(json);
  }
}

class QuestionType {
  static const String multipleChoice = "Multiple choice";
  static const String trueFalse = "True-False";
  static const String stringEntry = "String entry";

  static bool isSupported(String type) {
    if (type == QuestionType.multipleChoice) {
      return true;
    }
    if (type == QuestionType.trueFalse) {
      return true;
    }
    if (type == QuestionType.stringEntry) {
      return true;
    }
    return false;
  }
}
