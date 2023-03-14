import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/screens/edit_course.dart';

/// A screen to create a new course
class CreateCourse extends StatefulWidget {
  const CreateCourse({super.key});

  @override
  State<CreateCourse> createState() => _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {
  final nameController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create course'),
      ),
      body: Column(
        children: [
          const Text('Course Name:'),
          TextField(
            decoration: const InputDecoration(hintText: 'Name'),
            controller: nameController,
          ),
          const Text('Unique ID:'),
          TextField(
            decoration: const InputDecoration(hintText: 'ID'),
            controller: idController,
          ),
          ElevatedButton(
            onPressed: _createCourse,
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _createCourse() {
    String name = nameController.text;
    String id = idController.text;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditCourse(
              course: Future.value(Course(uniqueID: id, name: name)));
        },
      ),
    );
  }
}
