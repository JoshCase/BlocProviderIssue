import 'package:flutter/material.dart';

class TopicSection extends StatelessWidget {

  final String topicName;

  TopicSection(this.topicName);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        topicName,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class QuestionBox extends StatelessWidget {

  final String string;

  QuestionBox(this.string);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Text(
          string,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}