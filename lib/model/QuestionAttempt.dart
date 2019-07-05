import 'package:flutter/foundation.dart';
import 'package:dailymedicaltrivia2/model/Question.dart';

class QuestionAttempt {
  final String answerID;
  final String answerString;
  final Question question;

  QuestionAttempt({
    @required this.answerID,
    @required this.answerString,
    @required this.question,
  });

  bool wasCorrect() {
    return this.question.isAnsweredCorrectlyBy(this);
  }
}
