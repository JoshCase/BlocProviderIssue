
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dailymedicaltrivia2/main.dart';
import 'package:dailymedicaltrivia2/ui/pages/PrePlayPage.dart';
import 'package:dailymedicaltrivia2/ui/pages/CareerPage.dart';

void main() {

  testWidgets('has text that says play', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PrePlayPage()));
    final titleFinder = find.text('Play');
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('will move to CareerPage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: PrePlayPage()));
    final buttonFinder = find.byType(FlatButton);
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();
    expect(find.byType(CareerPage), findsOneWidget);
  }, skip: true);

}


