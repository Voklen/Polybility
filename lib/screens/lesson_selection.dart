import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';
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
          drawer: Drawer(
            child: Column(
              children: [
                const CreateEditToggle(),
                ElevatedButton(
                  onPressed: () => _toCourseCreation(context),
                  child: const Text('Create course'),
                ),
              ],
            ),
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

  _toCourseCreation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditCourse(course: Course.createNew());
        },
      ),
    );
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

class CreateEditToggle extends StatefulWidget {
  const CreateEditToggle({super.key});

  @override
  State<CreateEditToggle> createState() => _CreateEditToggleState();
}

class _CreateEditToggleState extends State<CreateEditToggle> {
  final List<bool> _isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: _isSelected,
      selectedColor: Colors.white,
      fillColor: Colors.blue,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Create'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Edit'),
        ),
      ],
      onPressed: (int index) {
        if (_isSelected[index]) {
          return;
        }
        setState(() {
          _isSelected[0] = !_isSelected[0];
          _isSelected[1] = !_isSelected[1];
        });
      },
    );
  }
}
