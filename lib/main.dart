import 'package:flutter/material.dart';

import 'package:polybility/screens/play_course.dart';

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
      home: const PlayCourse(
        courseName: 'course',
      ),
    );
  }
}
