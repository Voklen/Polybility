import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';

class LessonSelection extends StatelessWidget {
  const LessonSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final courseFuture = _readCourse();
    return FutureBuilder(
      future: courseFuture,
      builder: (context, snapshot) {
        Course? course = snapshot.data ?? Course.createNew();
        List<Widget> lessonWidgets = _createLessonWidgets(course);
        return Scaffold(
          appBar: AppBar(
            title: Text(course.getName()),
          ),
          body: Column(
            children: lessonWidgets,
          ),
        );
      },
    );
  }

  List<Widget> _createLessonWidgets(Course course) {
    List<Lesson> lessons = course.getLessons();
    List<Widget> lessonWidgets = lessons.map(_lessonToWidget).toList();
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
