import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dailymedicaltrivia2/model/Answer.dart';
import 'package:dailymedicaltrivia2/model/QuestionAttempt.dart';
import 'package:dailymedicaltrivia2/model/Question.dart';
import 'package:dailymedicaltrivia2/model/Topic.dart';

///TODO: Write Question tests
void main() {
  test('QuestionType knows what is valid', () {
    expect(QuestionType.isSupported("String entry"), true);
    expect(QuestionType.isSupported("Multiple choice"), true);
    expect(QuestionType.isSupported("True-False"), true);
    expect(QuestionType.isSupported("Spaghetti question"), false);
  });

  test('Question builds from JSON correctly', () {
    String jsonString =
        '{ "id": "301", "suitable-for-facebook": "NO", "string": "Almost all cases of mitral stenosis can be attributed to a complication of which inflammatory disease?", "type": "String entry", "topic-id": "4P2Osk7vWHFeC8vW5mZ7rCYJgANgEwhE", "date-edited": "2018-07-28 12:03:32", "date-created": "2018-01-02 21:19:05", "answers": [ { "id": "518", "question-id": "301", "string": "rheumatic valvulitis", "correct": "YES", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:05" }, { "id": "519", "question-id": "301", "string": "rheumatic heart disease", "correct": "YES", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:05" }, { "id": "520", "question-id": "301", "string": "rheumatic fever", "correct": "YES", "date-edited": "0000-00-00 00:00:00", "date-created": "2018-01-02 21:19:05" } ], "attempts": { "list": { "518": 0, "519": 0, "520": 0 }, "total": 0 }, "topic": { "id": "4P2Osk7vWHFeC8vW5mZ7rCYJgANgEwhE", "name": "Cardiology", "date-created": "2018-07-28 10:32:29" } }';
    dynamic json = jsonDecode(jsonString);
    Question question = Question.fromJson(json);
    expect("301", question.id);
    expect(
        "Almost all cases of mitral stenosis can be attributed to a complication of which inflammatory disease?",
        question.string);

    ///TODO: Implement this test below
    //expect("Cardiology", question.topic.name);
    expect(QuestionType.stringEntry, question.type);
    expect('518', question.answers[0].id);
    expect('rheumatic heart disease', question.answers[1].string);
    expect(true, question.answers[2].correct);
  });

  test('Question can evaluate answers correctly', () {
    Question question = Question(
      string: 'What is the answer?',
      id: 'exampleID',
      topic: Topic(name: 'Cardiology'),
      type: QuestionType.multipleChoice,
      answers: [
        Answer(correct: true, id: 'id1', questionID: 'qID1', string: 'head'),
        Answer(correct: false, id: 'id2', questionID: 'qID1', string: 'shoulders'),
        Answer(correct: false, id: 'id3', questionID: 'qID1', string: 'knees'),
        Answer(correct: true, id: 'id4', questionID: 'qID1', string: 'toes'),
      ],
    );
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: 'id1', answerString:'', question: question)), true);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: 'id2', answerString:'', question: question)), false);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: 'id3', answerString:'', question: question)), false);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: 'id4', answerString:'', question: question)), true);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: '', answerString:'head', question: question)), true);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: '', answerString:'shoulders', question: question)), false);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: '', answerString:'knees', question: question)), false);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: '', answerString:'toes', question: question)), true);
    //Case sensitivity for answerString but NOT id
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: '', answerString:'TOES', question: question)), true);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: 'ID1', answerString:'', question: question)), false);
    //Trim answerString but NOT id
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: '', answerString:' toes ', question: question)), true);
    expect(question.isAnsweredCorrectlyBy(QuestionAttempt(answerID: ' id1 ', answerString:'', question: question)), false);
  });
}
