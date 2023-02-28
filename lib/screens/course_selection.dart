import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/edit_course.dart';
import 'package:polybility/screens/play_course.dart';

class CourseSelection extends StatefulWidget {
  const CourseSelection({super.key});

  @override
  State<CourseSelection> createState() => _CourseSelectionState();
}

class _CourseSelectionState extends State<CourseSelection> {
  bool playCourse = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreateEditToggle(
          onToggle: _switchMode,
        ),
        ElevatedButton(
          onPressed: () => _newCourse(),
          child: const Text('Create course'),
        ),
        CoursesList(
          onCourseButtonPress: _courseButtonPressed,
        ),
      ],
    );
  }

  void _switchMode() {
    playCourse = !playCourse;
  }

  void _courseButtonPressed(String courseName) {
    if (playCourse) {
      _playCourse(courseName);
    } else {
      _editCourse(courseName);
    }
  }

  void _playCourse(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlayCourse(
            courseName: name,
          );
        },
      ),
    );
  }

  void _editCourse(String name) async {
    final course = await Course.fromFile(name);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditCourse(course: course);
        },
      ),
    );
  }

  _newCourse() {}
}

class CreateEditToggle extends StatefulWidget {
  const CreateEditToggle({super.key, required this.onToggle});

  final void Function() onToggle;

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
          child: Text('Play'),
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
          widget.onToggle();
          _isSelected[0] = !_isSelected[0];
          _isSelected[1] = !_isSelected[1];
        });
      },
    );
  }
}

class CoursesList extends StatefulWidget {
  const CoursesList({super.key, required this.onCourseButtonPress});

  final void Function(String) onCourseButtonPress;

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items,
    );
  }

  void getCourses() {
    Course.getCourses().forEach((courseName) {
      final courseButton = CourseButton(
        courseName: courseName,
        onPressed: () => widget.onCourseButtonPress(courseName),
      );
      setState(() {
        items.add(courseButton);
      });
    });
  }
}

class CourseButton extends StatelessWidget {
  const CourseButton(
      {super.key, required this.courseName, required this.onPressed});

  final String courseName;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color.fromARGB(255, 91, 219, 119),
      child: Text(courseName),
    );
  }
}
