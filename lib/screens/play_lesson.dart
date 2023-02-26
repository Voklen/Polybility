import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';

class PlayLesson extends StatefulWidget {
  const PlayLesson({super.key, required this.lesson});

  final Lesson lesson;

  @override
  State<PlayLesson> createState() => _PlayLessonState();
}

class _PlayLessonState extends State<PlayLesson> {
  int _currentQuestionIndex = 0;
  Question get _currentQuestion =>
      widget.lesson.getQuestion(_currentQuestionIndex);

  String _prompt = "";
  final _answerController = TextEditingController();
  double _lessonProgress = 0;

  bool _showingIncorrect = false;
  bool _showingCorrect = false;

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
        ],
      ),
      bottomNavigationBar: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: _showingCorrect,
              child: const Text(
                'Correct!',
                style: TextStyle(color: Colors.green),
              ),
            ),
            Visibility(
              visible: _showingIncorrect,
              child: const Text(
                'Incorrect!',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: _check,
                minWidth: double.infinity,
                color: Colors.green,
                child: const Text('Check'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _check() {
    if (_showingCorrect || _showingIncorrect) {
      _showingCorrect = false;
      _showingIncorrect = false;
      _nextQuestion();
      setState(() {});
      return;
    }
    if (_answerController.text == _currentQuestion.answer) {
      _showingCorrect = true;
    } else {
      _showingIncorrect = true;
    }
    setState(() {});
  }

  void _nextQuestion() {
    _currentQuestionIndex += 1;
    if (_currentQuestionIndex == widget.lesson.nOfQuestions()) {
      //TODO save XP to file and go to congratulations screen
      Navigator.pop(context, widget.lesson);
      return;
    }
    _prompt = _currentQuestion.prompt;
    setState(() {
      _lessonProgress = _currentQuestionIndex / widget.lesson.nOfQuestions();
    });
  }
}
