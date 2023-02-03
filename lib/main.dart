import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';

import 'package:polybility/screens/edit_course.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polybility',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        course: Course.createNew,
      ),
    );
  }
}
