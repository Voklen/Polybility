import 'package:flutter/material.dart';

class CreateLevel extends StatelessWidget {
  CreateLevel({super.key});

  final questionController = TextEditingController();
  final answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create course'),
      ),
      body: Column(
        children: [
          const Text('Question'),
          TextField(
            controller: questionController,
          ),
          const Text('Answer'),
          TextField(
            controller: answerController,
          ),
        ],
      ),
    );
  }
}
