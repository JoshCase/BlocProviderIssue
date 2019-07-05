import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';
import 'package:dailymedicaltrivia2/model/Question.dart';
import 'package:dailymedicaltrivia2/model/QuestionAttempt.dart';
import 'package:dailymedicaltrivia2/bloc/user/UserBloc.dart';
import 'package:dailymedicaltrivia2/bloc/Quiz/QuizEvent.dart';
import 'package:dailymedicaltrivia2/bloc/Quiz/QuizState.dart';
export 'package:dailymedicaltrivia2/bloc/Quiz/QuizEvent.dart';
export 'package:dailymedicaltrivia2/bloc/Quiz/QuizState.dart';

class QuizBloc extends Bloc {
  Question currentQuestion;
  QuestionAttempt currentQuestionAttempt;
  List<Question> questions = [];
  bool hasFinished = false;
  bool isLoading = true;

  final UserBloc userBloc;
  final Level level;
  final _eventController = StreamController<QuizEvent>();
  final _stateController = BehaviorSubject.seeded(
    QuizState(
      currentQuestion: null,
      currentQuestionAttempt: null,
      hasFinished: false,
      isLoading: true,
    ),
  );

  QuizBloc.ofLevel({@required this.level, @required this.userBloc})
      : assert(level != null),
        assert(userBloc != null) {
    _listenToEventStream();
    level.questions.forEach((q) => this.questions.add(q));
    questions.shuffle();
    currentQuestion = questions[0];
    currentQuestion.answers.shuffle();
    isLoading = false;
    _pushQuizState();
  }

  Sink get eventSink => _eventController.sink;

  Stream get stateStream => _stateController.stream;

  void _listenToEventStream() {
    _eventController.stream.listen((event) {
      switch (event.type) {
        case QuizEventType.QuestionAnswered:
          _onQuestionAnswered(event);
          break;
        case QuizEventType.FeedbackClosed:
          _onFeedbackClosed(event);
          break;
        default:
          throw Exception(
              "No implementation for QuizBloc event: ${event.type}");
      }
    }, onDone: () {}, onError: (error) {});
  }

  void _onFeedbackClosed(QuizEvent event) {
    currentQuestionAttempt = null;
    questions.removeAt(0);
    if (questions.length == 0) {
      _onQuizFinished();
    } else {
      this.currentQuestion = questions[0];
      this.currentQuestion.answers.shuffle();
      _pushQuizState();
    }
  }

  void _onQuestionAnswered(QuizEvent event) {
    currentQuestionAttempt = QuestionAttempt(
      answerID: event.answerID,
      answerString: event.answerString,
      question: currentQuestion,
    );
    _pushQuizState();
  }

  void _onQuizFinished() {
    userBloc.eventSink.add(UserEventLevelComplete(
      levelID: this.level.id,
      wasMastered: false,
    ));
    _pushQuizState();
  }

  void _pushQuizState() {
    _stateController.sink.add(QuizState(
      currentQuestion: this.currentQuestion,
      currentQuestionAttempt: this.currentQuestionAttempt,
      hasFinished: this.hasFinished,
      isLoading: this.isLoading,
    ));
  }

  void dispose() async {
    _eventController.close();
    _stateController.close();
  }
}
