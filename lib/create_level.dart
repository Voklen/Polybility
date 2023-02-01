import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';

class CreateLevel extends StatefulWidget {
  const CreateLevel({super.key, required this.lesson});

  final Lesson lesson;

  @override
  State<CreateLevel> createState() => _CreateLevelState();
}

class _CreateLevelState extends State<CreateLevel> {
  int _currentQuestion = 0;

  final _promptController = TextEditingController();
  final _answerController = TextEditingController();
  final List<Widget> _selectionButtons = [];

  @override
  void initState() {
    super.initState();
    addQuestionButton();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create course'),
      ),
      body: Column(
        children: [
          Row(
            children: _selectionButtons,
          ),
          const Text('Question'),
          TextField(controller: _promptController),
          const Text('Answer'),
          TextField(controller: _answerController),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _nextLevel(context),
                child: const Text('Next level'),
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

  void _nextLevel(BuildContext context) {
    _saveQuestion();
    const question = Question(prompt: '', answer: '');
    widget.lesson.addQuestion(question);
    _currentQuestion = widget.lesson.questions.length - 1;
    addQuestionButton();
  }

  void _submit(BuildContext context) {
    _saveQuestion();
    Navigator.pop(context, widget.lesson);
  }

  void _saveQuestion() {
    final prompt = _promptController.text;
    final answer = _answerController.text;
    final question = Question(prompt: prompt, answer: answer);
    widget.lesson.questions[_currentQuestion] = question;
  }

  void addQuestionButton() {
    _selectionButtons.add(
      Expanded(
        child: FilledButton(
          onPressed: () {},
          child: const SizedBox.shrink(),
        ),
      ),
    );
    setState(() {});
  }
}
