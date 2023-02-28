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
      ],
    );
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
