import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/bloc/Quiz/QuizBloc.dart';
import 'package:dailymedicaltrivia2/ui/quiz/QuestionBox.dart';
import 'package:dailymedicaltrivia2/model/QuestionAttempt.dart';

class TrueFalseQuestion extends StatelessWidget {

  final QuizState state;

  TrueFalseQuestion(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TopicSection(state.currentQuestion.topic.name),
        Expanded(
            child: QuestionBox(state.currentQuestion.string), flex: 4),
        Expanded(
            child: _answerSection(state.currentQuestionAttempt),
            flex: 5),
      ],
    );
  }

  Widget _answerSection(QuestionAttempt attempt) {
    bool _shouldReveal = false;
    bool _trueWasCorrect = false;
    bool _trueWasChosen = false;
    bool _falseWasCorrect = false;
    bool _falseWasChosen = false;

    if (attempt != null) {
      _shouldReveal = true;
      if (attempt.answerString == '1') {
        _trueWasChosen = true;
      } else {
        _falseWasChosen = true;
      }
      if (attempt.question.firstCorrectAnswer().string == '1') {
        _trueWasCorrect = true;
      } else {
        _falseWasCorrect = true;
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TrueFalseAnswer(label: 'True', value:'1', shouldReveal: _shouldReveal, wasChosen: _trueWasChosen, wasCorrect: _trueWasCorrect,),
        TrueFalseAnswer(label: 'False', value: '0', shouldReveal: _shouldReveal, wasChosen: _falseWasChosen, wasCorrect: _falseWasCorrect,),
      ],
    );
  }
}

class TrueFalseAnswer extends StatelessWidget {
  final String label;
  final bool shouldReveal;
  final String value;
  final bool wasChosen;
  final bool wasCorrect;

  TrueFalseAnswer({this.label, this.value, this.shouldReveal, this.wasChosen = false, this.wasCorrect});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    if (shouldReveal) {
      if (wasChosen) {
        backgroundColor = Color.fromRGBO(244, 67, 54, 1);
      }
      if (wasCorrect) {
        backgroundColor = Color.fromRGBO(76, 175, 80, 1);
      }
    }
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 4.0, left: 6.0, right: 6.0),
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<QuizBloc>(context)
                .eventSink
                .add(QuizEvent.questionAnswered(
              answerID: null,
              answerString: value,
            ));
          },
          child: Container(
            color: backgroundColor,
            height: 50,
            width: double.infinity,
            child: Center(child: Text(label)),
          ),
        ),
      ),
    );
  }
}