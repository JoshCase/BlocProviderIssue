import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/bloc/Quiz/QuizBloc.dart';
import 'package:dailymedicaltrivia2/ui/quiz/QuestionBox.dart';
import 'package:dailymedicaltrivia2/model/Answer.dart';
import 'package:dailymedicaltrivia2/model/QuestionAttempt.dart';


class MultipleChoiceQuestion extends StatelessWidget {

  final QuizState state;

  MultipleChoiceQuestion(this.state);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TopicSection(state.currentQuestion.topic.name),
        Expanded(
          child: QuestionBox(state.currentQuestion.string),
          flex: 4,
        ),
        Expanded(
          child: _answerSection(
              state.currentQuestion.answers, state.currentQuestionAttempt),
          flex: 5,
        ),
      ],
    );
  }

  Widget _answerSection(List<Answer> answers, QuestionAttempt attempt) {
    bool _shouldReveal = false;
    bool _wasChosen;
    if (attempt != null) {
      _shouldReveal = true;
    }
    List<MultipleChoiceAnswer> _children = answers.map((_answer) {
      if (attempt != null && attempt.answerID == _answer.id) {
        _wasChosen = true;
      } else {
        _wasChosen = false;
      }
      return MultipleChoiceAnswer(
        answer: _answer,
        shouldReveal: _shouldReveal,
        wasChosen: _wasChosen,
      );
    }).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _children,
    );
  }
}

class MultipleChoiceAnswer extends StatelessWidget {
  final Answer answer;
  final bool shouldReveal;
  final bool wasChosen;

  MultipleChoiceAnswer({
    this.answer,
    this.shouldReveal = false,
    this.wasChosen = false,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    if (shouldReveal) {
      if (wasChosen) {
        backgroundColor = Color.fromRGBO(244, 67, 54, 1);
      }
      if (answer.correct) {
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
              answerID: answer.id,
              answerString: answer.string,
            ));
          },
          child: Container(
            color: backgroundColor,
            height: 50,
            width: double.infinity,
            child: Center(child: Text(answer.string)),
          ),
        ),
      ),
    );
  }
}