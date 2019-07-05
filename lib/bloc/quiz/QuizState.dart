import 'package:flutter/foundation.dart';
import 'package:dailymedicaltrivia2/model/Question.dart';
import 'package:dailymedicaltrivia2/model/QuestionAttempt.dart';

class QuizState {
  final QuestionAttempt currentQuestionAttempt;
  final Question currentQuestion;
  final bool hasFinished;
  final bool isLoading;

  QuizState({
    @required this.currentQuestion,
    @required this.currentQuestionAttempt,
    this.hasFinished = false,
    @required this.isLoading,
  });
}
