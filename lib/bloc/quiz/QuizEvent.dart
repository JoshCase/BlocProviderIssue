import 'package:flutter/foundation.dart';

class QuizEvent {
  final String answerID;
  final String answerString;
  final QuizEventType type;

  QuizEvent.questionAnswered({@required this.answerID, @required this.answerString}) : type = QuizEventType.QuestionAnswered;
  QuizEvent.closeFeedback() : type = QuizEventType.FeedbackClosed, answerID = null, answerString = null;
}

enum QuizEventType {
  FeedbackClosed,
  QuestionAnswered,
}
