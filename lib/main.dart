import 'dart:async';

import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';
import 'package:polybility/create_level.dart';
import 'package:toml/toml.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Polybility'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() async {
    final defaultLesson = Lesson(description: '', questions: []);
    final Lesson lessonCreator = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreateLevel(
            lesson: defaultLesson,
          );
        },
      ),
    );
    if (!mounted) return;
    print(lessonCreator.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Level(color: Color.fromARGB(255, 137, 216, 34)),
            Level(color: Color.fromARGB(255, 43, 128, 161)),
            Level(color: Color.fromARGB(255, 175, 150, 37)),
            Level(color: Color.fromARGB(255, 34, 52, 216)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  FutureOr _updateLevels(_) {
    TomlDocument.fromMap(const {
      'hello': true,
    }).toString();
  }
}

class Level extends StatefulWidget {
  const Level({super.key, required this.color});

  final Color color;

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.circle,
      color: widget.color,
    );
  }
}
