import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';

class LessonSelection extends StatelessWidget {
  const LessonSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final lessonWidgetsFuture = _createLessonWidgets();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Course'),
      ),
      body: FutureBuilder(
        future: lessonWidgetsFuture,
        builder: (context, snapshot) {
          final lessonWidgets = snapshot.data ?? [];
          return Column(
            children: lessonWidgets,
          );
        },
      ),
    );
  }

  Future<List<Widget>> _createLessonWidgets() async {
    Course course = await _readCourse();
    List<Widget> lessonWidgets =
        course.getLessons().map(_lessonToWidget).toList();
    return lessonWidgets;
  }

  Widget _lessonToWidget(Lesson lesson) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.circle,
        color: Color.fromARGB(255, 158, 31, 31),
      ),
    );
  }

  Future<Course> _readCourse() async {
    return Course.fromFile('course');
  }
}
