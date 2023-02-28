import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/course_selection.dart';
import 'package:polybility/screens/edit_course.dart';
import 'package:polybility/screens/play_lesson.dart';

class LessonSelection extends StatelessWidget {
  const LessonSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final courseFuture = _readCourse();
    return FutureBuilder(
      future: courseFuture,
      builder: (context, snapshot) {
        Course course = snapshot.data ?? Course.createNew();
        List<Widget> lessonWidgets = _createLessonWidgets(course);
        return Scaffold(
          appBar: AppBar(
            title: Text(course.getName()),
          ),
          drawer: const Drawer(
            child: CourseSelection(),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: lessonWidgets,
            ),
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
    return LessonIcon(lesson: lesson);
  }

  Future<Course> _readCourse() async {
    return Course.fromFile('course');
  }
}

class LessonIcon extends StatelessWidget {
  const LessonIcon({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _playLesson(context),
      icon: Icon(
        Icons.circle,
        color: Color.fromARGB(255, 158, 31, 31),
      ),
    );
  }

  void _playLesson(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlayLesson(
            lesson: lesson,
          );
        },
      ),
    );
  }
}
