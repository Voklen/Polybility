import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';

class CreateLevel extends StatelessWidget {
  CreateLevel({super.key, required this.lesson});

  final Lesson lesson;

  final promptController = TextEditingController();
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create course'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: () {}, child: const Text('')),
              ),
              Expanded(
                child: ElevatedButton(onPressed: () {}, child: const Text('')),
              ),
              Expanded(
                child: ElevatedButton(onPressed: () {}, child: const Text('')),
              ),
            ],
          ),
          const Text('Question'),
          TextField(controller: promptController),
          const Text('Answer'),
          TextField(controller: answerController),
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

  void _nextLevel(BuildContext context) {}

  void _submit(BuildContext context) {
    final prompt = promptController.text;
    final answer = answerController.text;
    final question = Question(prompt: prompt, answer: answer);
    lesson.addQuestion(question);
    Navigator.pop(context, lesson);
  }
}
