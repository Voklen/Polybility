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

  final _promptController = TextEditingController();
  final _answerController = TextEditingController();
  List<Widget> _selectionButtons = [];
  List<bool> _selections = [];
  double _lessonProgress = 0;

  @override
  void initState() {
    super.initState();

    final nOfQuestions = widget.lesson.nOfQuestions();
    _selectionButtons = List.filled(
      nOfQuestions,
      const SizedBox.shrink(),
      growable: true,
    );
    _selections = List.filled(
      nOfQuestions,
      false,
      growable: true,
    );
    _selections[0] = true;

    Question question = widget.lesson.getQuestion(0);
    _promptController.text = question.prompt;
    _answerController.text = question.answer;
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
          const Text('Question'),
          TextField(
            controller: _promptController,
            decoration: const InputDecoration(hintText: 'Prompt'),
          ),
          const Text('Answer'),
          TextField(
            controller: _answerController,
            decoration: const InputDecoration(hintText: 'Answer'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _nextQuestion(context),
                child: const Text('Next question'),
              ),
              ElevatedButton(
                onPressed: () => _submit(context),
                child: const Text('Submit'),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _nextQuestion(BuildContext context) {
    _currentQuestion += 1;
    Question question = widget.lesson.getQuestion(_currentQuestion);
    _promptController.text = question.prompt;
    setState(() {
      _lessonProgress = _currentQuestion / widget.lesson.nOfQuestions();
    });
  }

  void _submit(BuildContext context) {
    _saveQuestion();
    Navigator.pop(context, widget.lesson);
  }

  void _saveQuestion() {
    final prompt = _promptController.text;
    final answer = _answerController.text;
    final question = Question(prompt: prompt, answer: answer);
    widget.lesson.setQuestion(_currentQuestion, question);
  }
}
