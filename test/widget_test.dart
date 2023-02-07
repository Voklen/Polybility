import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/edit_course.dart';

void main() {
  testWidgets('Navigation to new lesson', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EditCourse(
        course: Course.createNew(),
      ),
    ));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Check we're on the lesson creation screen
    expect(find.text('Create lesson'), findsOneWidget);
  });
}
