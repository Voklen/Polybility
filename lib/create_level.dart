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
  final List<bool> _selections = [];

  @override
  void initState() {
    super.initState();
    addQuestionButton();
    _switchToQuestion(0);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final widthOfBar = screenWidth * 0.95;
    final nOfButtons = _selections.length;
    final widthOfOneButton = widthOfBar / nOfButtons;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create course'),
      ),
      body: Column(
        children: [
          ToggleButtons(
            constraints: BoxConstraints.expand(
              height: 50,
              width: widthOfOneButton,
            ),
            // Visuals
            borderRadius: BorderRadius.circular(8),
            borderWidth: 0,
            borderColor: const Color.fromARGB(255, 151, 151, 151),
            fillColor: Colors.green,
            selectedBorderColor: Colors.green,
            // Logic
            isSelected: _selections,
            onPressed: _switchToQuestion,
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
    widget.lesson.addQuestion(Question.createNew);
    addQuestionButton();
    final newQuestionIndex = _selections.length - 1;
    _switchToQuestion(newQuestionIndex);
  }

  void addQuestionButton() {
    _selections.add(false);
    _selectionButtons.add(
      const SizedBox.shrink(),
    );
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

  _switchToQuestion(int index) {
    _saveQuestion();
    _currentQuestion = index;

    final question = widget.lesson.questions[index];
    _promptController.text = question.prompt;
    _answerController.text = question.answer;

    for (int i = 0; i < _selections.length; i++) {
      _selections[i] = false;
    }
    setState(() {
      _selections[index] = true;
    });
  }
}
