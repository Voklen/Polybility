import 'package:flutter/material.dart';

class Congrats extends StatelessWidget {
  const Congrats({
    super.key,
    required this.totalAnswers,
    required this.rightAnswers,
    required this.xp,
  });

  final int totalAnswers;
  final int rightAnswers;
  final int xp;

  @override
  Widget build(BuildContext context) {
    final percentage = 100 * rightAnswers / totalAnswers;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Wooo well done!'),
            Text('You got $percentage% right'),
            Text('And earned $xp XP'),
          ],
        ),
      ),
      bottomNavigationBar: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: () => Navigator.pop(context),
            minWidth: double.infinity,
            color: Colors.green,
            child: const Text('Continue'),
          ),
        ),
      ),
    );
  }
}
