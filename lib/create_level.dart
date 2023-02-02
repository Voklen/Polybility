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
  List<Widget> _selectionButtons = [];
  List<bool> _selections = [];

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
          ToggleButtons(
            constraints: BoxConstraints.expand(
              height: 50,
              width: MediaQuery.of(context).size.width / _selections.length - 2,
            ),
            fillColor: Colors.grey,
            isSelected: _selections,
            onPressed: _switchQuestion,
            renderBorder: false,
            borderRadius: BorderRadius.circular(8),
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

  _switchQuestion(int index) {
    setState(() {
      _selections[index] = true;
    });
    final question = widget.lesson.questions[index];
    _promptController.text = question.prompt;
    _answerController.text = question.answer;
  }

  void addQuestionButton() {
    final questionIndex = widget.lesson.questions.length - 1;
    _selections.add(true);
    _selectionButtons.add(
      const Expanded(
        child: SizedBox.shrink(),
      ),
    );
    setState(() {});
  }
}
