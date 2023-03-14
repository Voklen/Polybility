import 'package:flutter/material.dart';
import 'package:polybility/screens/course_selection.dart';

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
      home: const Scaffold(
        body: Center(
            child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: CourseSelection(),
        )),
      ),
    );
  }
}
