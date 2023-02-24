import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';

class PlayLesson extends StatefulWidget {
  const PlayLesson({super.key, required this.lesson});

  final Lesson lesson;

  @override
  State<PlayLesson> createState() => _PlayLessonState();
}

class _PlayLessonState extends State<PlayLesson> {
  int _currentQuestion = 0;

  String _prompt = "";
  final _answerController = TextEditingController();
  double _lessonProgress = 0;

  @override
  void initState() {
    super.initState();
    Question question = widget.lesson.getQuestion(0);
    _prompt = question.prompt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: LinearProgressIndicator(
          value: _lessonProgress,
        ),
      ),
      body: Column(
        children: [
          Text(_prompt),
          TextField(
            controller: _answerController,
            decoration: const InputDecoration(hintText: 'Answer'),
          ),
          ElevatedButton(
            onPressed: _nextQuestion,
            child: const Text('Check'),
          ),
        ],
      ),
    );
  }

  void _nextQuestion() {
    _currentQuestion += 1;
    if (_currentQuestion == widget.lesson.nOfQuestions()) {
      //TODO save XP to file and go to congratulations screen
      Navigator.pop(context, widget.lesson);
      return;
    }
    Question question = widget.lesson.getQuestion(_currentQuestion);
    _prompt = question.prompt;
    setState(() {
      _lessonProgress = _currentQuestion / widget.lesson.nOfQuestions();
    });
  }
}
