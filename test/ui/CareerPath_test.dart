import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dailymedicaltrivia2/ui/CareerPath.dart';
import 'package:dailymedicaltrivia2/ui/dialogs/StartLevelDialog.dart';
import 'package:dailymedicaltrivia2/model/Level.dart';

void main() {
  testWidgets('LevelHubLocation can convert co-ords to correct align',
      (WidgetTester tester) async {
    expect(Alignment(-1, -1), LevelHubLocation(0, 100).toAlignment());
    expect(Alignment(-1, 1), LevelHubLocation(0, 0).toAlignment());
    expect(Alignment(1, -1), LevelHubLocation(100, 100).toAlignment());
    expect(Alignment(1, 1), LevelHubLocation(100, 0).toAlignment());
  });

  testWidgets('Tapping LevelHub opens StartLevelDialog',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CareerPath(levels: [Level()])));
    await tester.tap(find.byType(LevelHub).first);
    await tester.pumpAndSettle();
    expect(find.byType(StartLevelDialog), findsOneWidget);
  });
}
