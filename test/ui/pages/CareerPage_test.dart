import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dailymedicaltrivia2/main.dart';
import 'package:dailymedicaltrivia2/ui/pages/CareerPage.dart';
import 'package:dailymedicaltrivia2/ui/CareerPath.dart';
import 'package:dailymedicaltrivia2/ui/CareerGUI.dart';

void main() {
  testWidgets('has 1 CareerGUI', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CareerPage()));
    expect(find.byType(CareerGUI), findsOneWidget);
  }, skip: true);

  testWidgets('has 1 CareerPath', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CareerPage()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expectLater(find.byType(CareerPath), findsOneWidget);
  }, skip: true);
}
