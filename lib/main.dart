import 'package:flutter/material.dart';
import 'package:polybility/course_structure.dart';
import 'package:polybility/create_level.dart';

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
      home: MyHomePage(
        title: 'Polybility',
        course: Course.createNew,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.course});

  final String title;
  final Course course;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() async {
    final Lesson createdLesson = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreateLevel(
            lesson: Lesson.createNew,
          );
        },
      ),
    );
    if (!mounted) return;
    widget.course.addLesson(createdLesson);
    widget.course.writeToFile();
    //TODO Add icon and setState
    print(createdLesson.toMap());
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
