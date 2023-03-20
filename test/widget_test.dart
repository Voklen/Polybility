import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/edit_lesson.dart';
import 'package:polybility/screens/edit_course.dart';

void main() {
  testWidgets('Navigation to new lesson', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EditCourse(
        course: Future.value(Course(name: 'New course', uniqueID: 'course')),
      ),
    ));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Check we're on the lesson creation screen
    expect(find.text('Create lesson'), findsOneWidget);
  });

  testWidgets('Add and switch questions', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: EditLesson(
        lesson: Lesson(),
      ),
    ));

    final promptField = find.ancestor(
      of: find.text('Prompt'),
      matching: find.byType(TextField),
    );
    await tester.enterText(promptField, '1st prompt');

    final answerField = find.ancestor(
      of: find.text('Answer'),
      matching: find.byType(TextField),
    );
    await tester.enterText(answerField, '1st answer');

    // Verify that we are on the first question
    expect(find.text('1st prompt'), findsOneWidget);
    expect(find.text('1st answer'), findsOneWidget);
    expect(find.text('2nd prompt'), findsNothing);
    expect(find.text('2nd answer'), findsNothing);

    await tester.tap(find.text('Add question'));

    // Verify that we are on an empty question
    expect(find.text('1st prompt'), findsNothing);
    expect(find.text('1st answer'), findsNothing);
    expect(find.text('2nd prompt'), findsNothing);
    expect(find.text('2nd answer'), findsNothing);

    final promptField2 = find.ancestor(
      of: find.text('Prompt'),
      matching: find.byType(TextField),
    );
    await tester.enterText(promptField2, '2nd prompt');

    final answerField2 = find.ancestor(
      of: find.text('Answer'),
      matching: find.byType(TextField),
    );
    await tester.enterText(answerField2, '2nd answer');

    // Verify that we are on the second question
    expect(find.text('1st prompt'), findsNothing);
    expect(find.text('1st answer'), findsNothing);
    expect(find.text('2nd prompt'), findsOneWidget);
    expect(find.text('2nd answer'), findsOneWidget);

    final levelButtons = find.descendant(
        of: find.byType(ToggleButtons), matching: find.byType(SizedBox));
    await tester.tap(levelButtons.first);

    // Verify that we are on the first question
    expect(find.text('1st prompt'), findsOneWidget);
    expect(find.text('1st answer'), findsOneWidget);
    expect(find.text('2nd prompt'), findsNothing);
    expect(find.text('2nd answer'), findsNothing);

    await tester.tap(levelButtons.last);

    // Verify that we are on the second question
    expect(find.text('1st prompt'), findsNothing);
    expect(find.text('1st answer'), findsNothing);
    expect(find.text('2nd prompt'), findsOneWidget);
    expect(find.text('2nd answer'), findsOneWidget);

    await tester.tap(levelButtons.first);

    // Verify that we are on the first question
    expect(find.text('1st prompt'), findsOneWidget);
    expect(find.text('1st answer'), findsOneWidget);
    expect(find.text('2nd prompt'), findsNothing);
    expect(find.text('2nd answer'), findsNothing);
  });
}
