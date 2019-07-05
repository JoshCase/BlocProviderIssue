import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/bloc/Quiz/QuizBloc.dart';
import 'package:dailymedicaltrivia2/ui/quiz/MultipleChoiceQuestion.dart';
import 'package:dailymedicaltrivia2/ui/quiz/StringEntryQuestion.dart';
import 'package:dailymedicaltrivia2/ui/quiz/TrueFalseQuestion.dart';
import 'package:dailymedicaltrivia2/model/Question.dart';
import 'package:dailymedicaltrivia2/model/QuestionAttempt.dart';

class QuizPage extends StatefulWidget {
  @override
  QuizPageState createState() {
    return new QuizPageState();
  }
}

class QuizPageState extends State<QuizPage> {
  QuizBloc quizBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(94, 148, 184, 1),
        title: Text("Quiz Page"),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromRGBO(171, 202, 223, 1.0),
        child: StreamBuilder<QuizState>(
          stream: quizBloc.stateStream,
          builder: (BuildContext context, AsyncSnapshot<QuizState> snapshot) {
            if (snapshot.hasError) {
              return _onSnapshotError();
            } else if (snapshot.hasData) {
              if (snapshot.data.isLoading) {
                return _progressIndicator();
              } else {
                if (snapshot.data.hasFinished) {
                  return _quizFinishedDialog();
                }
                return Stack(children: [
                  _questionSection(snapshot.data),
                  _feedbackOverlay(snapshot.data.currentQuestionAttempt),
                ]);
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _feedbackOverlay(QuestionAttempt _attempt) {
    if (_attempt == null) {
      return Container();
    }
    String _mainText;
    Color _mainTextColor;
    Color _overlayColor = Colors.black.withOpacity(0.6);
    if (_attempt.wasCorrect()) {
      _mainText = 'Correct';
      _mainTextColor = Colors.green;
    } else {
      _mainText = 'Incorrect';
      _mainTextColor = Colors.red;
    }
    return GestureDetector(
      onTap: () {
        BlocProvider.of<QuizBloc>(context)
            .eventSink
            .add(QuizEvent.closeFeedback());
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: _overlayColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(_mainText,
                style: TextStyle(color: _mainTextColor, fontSize: 48, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _onSnapshotError() {
    print('Snapshot has error!');
    return Center(child: Text('Snapshot error'));
  }

  Widget _progressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _questionSection(QuizState state) {
    switch (state.currentQuestion.type) {
      case QuestionType.multipleChoice:
        return MultipleChoiceQuestion(state);
        break;
      case QuestionType.stringEntry:
        return StringEntryQuestion(state);
        break;
      case QuestionType.trueFalse:
        return TrueFalseQuestion(state);
        break;
      default:
        throw Exception(
            'No implementation for question type: ${state.currentQuestion.type}');
    }
  }

  Widget _quizFinishedDialog() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
        child: Center(
          child: Container(height: 400, width: 400, color: Colors.green),
        ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    quizBloc = BlocProvider.of<QuizBloc>(context);
  }
}

