import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/edit_course.dart';

class CourseSelection extends StatefulWidget {
  const CourseSelection({super.key});

  @override
  State<CourseSelection> createState() => _CourseSelectionState();
}

class _CourseSelectionState extends State<CourseSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CreateEditToggle(),
        ElevatedButton(
          onPressed: () => _toCourseCreation(context),
          child: const Text('Create course'),
        ),
        CoursesList(),
      ],
    );
  }

  _toCourseCreation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditCourse(
              course: Course(name: 'New course', uniqueID: 'course'));
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

class CoursesList extends StatefulWidget {
  const CoursesList({super.key});

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
      final courseButton = CourseButton(courseName: courseName);
      setState(() {
        items.add(courseButton);
      });
    });
  }
}

class CourseButton extends StatelessWidget {
  const CourseButton({super.key, required this.courseName});

  final String courseName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(courseName),
      tileColor: const Color.fromARGB(255, 91, 219, 119),
    );
  }
}
