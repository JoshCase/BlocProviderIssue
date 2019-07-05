import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:dailymedicaltrivia2/bloc/Quiz/QuizBloc.dart';
import 'package:dailymedicaltrivia2/ui/quiz/QuestionBox.dart';

class StringEntryQuestion extends StatelessWidget {

  final QuizState state;

  StringEntryQuestion(this.state);

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
        Expanded(child: StringInput(), flex: 5),
      ],
    );
  }
}

class StringInput extends StatefulWidget {
  @override
  _StringInputState createState() => _StringInputState();
}

class _StringInputState extends State<StringInput> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      autofocus: true,
      controller: textController,
      textAlign: TextAlign.center,
      onSubmitted: (string) {
        BlocProvider.of<QuizBloc>(context)
            .eventSink
            .add(QuizEvent.questionAnswered(
          answerID: null,
          answerString: textController.text,
        ));
        textController.clear();
      },
    );
  }
}