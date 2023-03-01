import 'package:flutter/material.dart';

class Congrats extends StatelessWidget {
  const Congrats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Wooo well done!'),
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
