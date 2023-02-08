import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/create_lesson.dart';
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

  testWidgets('Add question', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: CreateLesson(
        lesson: Lesson.createNew(),
      ),
    ));

    final promptField = find.ancestor(
      of: find.text('Prompt'),
      matching: find.byType(TextField),
    );
    await tester.enterText(promptField, '1st prompt');

    final answerField = find.ancestor(
      of: find.text('Prompt'),
      matching: find.byType(TextField),
    );
    await tester.enterText(answerField, '1st answer');

    await tester.tap(find.text('Add question'));

    expect(find.text('1st prompt'), findsNothing);
    expect(find.text('1st answer'), findsNothing);

    final promptField2 = find.ancestor(
      of: find.text('Prompt'),
      matching: find.byType(TextField),
    );
    await tester.enterText(promptField2, '2nd prompt');

    final answerField2 = find.ancestor(
      of: find.text('Prompt'),
      matching: find.byType(TextField),
    );
    await tester.enterText(answerField2, '2nd answer');
  });
}
