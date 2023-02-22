import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';

class LessonSelection extends StatelessWidget {
  const LessonSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create course'),
      ),
      body: Column(
        children: _createLessonWidgets(),
      ),
    );
  }

  List<Widget> _createLessonWidgets() {
    return [];
  }

  Future<Course> _readCourse() async {
    return Course.fromFile('course');
  }
}
