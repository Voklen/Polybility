import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/create_lesson.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({super.key, required this.course});

  final Future<Course> course;

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  late final lessonIcons = getLessonIcons();

  Future<List<Widget>> getLessonIcons() async {
    final course = await widget.course;
    return course.getLessons().map(_lessonToIcon).toList();
  }

  static Widget _lessonToIcon(Lesson lesson) =>
      LessonIcon(color: Color.fromARGB(255, 158, 31, 31), lesson: lesson);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: widget.course,
          builder: (context, snapshot) {
            String title = 'Loading…';
            if (snapshot.hasData) {
              String courseName = snapshot.data!.getName();
              title = 'Editing: $courseName';
            }
            return Text(title);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: lessonIcons,
          builder: (context, snapshot) {
            List<Widget> icons = snapshot.data ?? [];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: icons,
            );
          },
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
    final createdLesson = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreateLesson(
            lesson: Lesson(),
          );
        },
      ),
    );
    if (createdLesson == null) return;
    Course course = await widget.course;
    course.addLesson(createdLesson);
    final icons = await lessonIcons;
    setState(() {
      icons.add(LessonIcon(
        color: Color.fromARGB(255, 158, 31, 31),
        lesson: createdLesson,
      ));
    });
  }
}

class LessonIcon extends StatefulWidget {
  const LessonIcon({super.key, required this.color, required this.lesson});

  final Color color;
  final Lesson lesson;

  @override
  State<LessonIcon> createState() => _LessonIconState();
}

class _LessonIconState extends State<LessonIcon> {
  Lesson lesson = Lesson();

  @override
  void initState() {
    lesson = widget.lesson;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _editLesson,
      icon: Icon(
        Icons.circle,
        color: widget.color,
      ),
    );
  }

  void _editLesson() async {
    final editedLesson = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreateLesson(
            lesson: lesson,
          );
        },
      ),
    );
    if (editedLesson == null) return;

    lesson = editedLesson;
  }
}
