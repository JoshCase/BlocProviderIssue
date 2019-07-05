import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dailymedicaltrivia2/model/Topic.dart';

void main() {
  test('Topic builds correctly from JSON', () {
    String jsonString = '{ "id": "c7No1CarFILghDpPp6rCbkIBb2zeusRu", "name": "Infectious Disease", "date-created": "2018-07-28 10:32:29" }';
    dynamic json = jsonDecode(jsonString);
    Topic topic = Topic.fromJson(json);
    expect("Infectious Disease", topic.name);
    expect("c7No1CarFILghDpPp6rCbkIBb2zeusRu", topic.id);
  });
}