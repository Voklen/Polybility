import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';

import 'package:polybility/screens/create_lesson.dart';

class EditCoursePage extends StatefulWidget {
  const EditCoursePage({super.key, required this.course});

  final Course course;

  @override
  State<EditCoursePage> createState() => _EditCoursePageState();
}

class _EditCoursePageState extends State<EditCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polybility'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            LessonIcon(color: Color.fromARGB(255, 137, 216, 34)),
            LessonIcon(color: Color.fromARGB(255, 43, 128, 161)),
            LessonIcon(color: Color.fromARGB(255, 175, 150, 37)),
            LessonIcon(color: Color.fromARGB(255, 34, 52, 216)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLesson,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addLesson() async {
    final Lesson createdLesson = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreateLesson(
            lesson: Lesson.createNew,
          );
        },
      ),
    );
    if (!mounted) return;
    widget.course.addLesson(createdLesson);
    widget.course.writeToFile();
    //TODO Add icon and setState
    print(createdLesson.toMap());
  }
}

class LessonIcon extends StatefulWidget {
  const LessonIcon({super.key, required this.color});

  final Color color;

  @override
  State<LessonIcon> createState() => _LessonIconState();
}

class _LessonIconState extends State<LessonIcon> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      color: widget.color,
    );
  }
}
