import 'package:flutter/material.dart';

import 'package:polybility/course_structure.dart';
import 'package:polybility/write_to_file.dart';
import 'package:polybility/screens/congrats.dart';

/// This is the screen for the user to play the lesson, probably where they'll
/// be spending most of their time
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
  double _lessonProgress = 0;
  List<bool> results = [];

  String _prompt = "";
  final _answerController = TextEditingController();

  bool _showingIncorrect = false;
  bool _showingCorrect = false;
  String _bottomButtonText = "Check";

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
                child: Text(_bottomButtonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _check() {
    bool isContinueButton = _showingCorrect || _showingIncorrect;
    if (isContinueButton) {
      _nextQuestion();
      return;
    }

    if (_answerController.text == _currentQuestion.answer) {
      _showingCorrect = true;
      results.add(true);
    } else {
      _showingIncorrect = true;
      results.add(false);
    }
    setState(() {
      _bottomButtonText = 'Continue';
    });
  }

  void _nextQuestion() {
    _showingCorrect = false;
    _showingIncorrect = false;
    _currentQuestionIndex += 1;
    if (_currentQuestionIndex == widget.lesson.nOfQuestions()) {
      endLesson();
      return;
    }
    _prompt = _currentQuestion.prompt;
    _answerController.clear();
    setState(() {
      _lessonProgress = _currentQuestionIndex / widget.lesson.nOfQuestions();
    });
  }

  void endLesson() {
    int totalAnswers = results.length;
    int rightAnswers = results.fold(0, _countRight);
    int xp = 20 * rightAnswers ~/ totalAnswers;
    writeToFile(xp);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Congrats(
            totalAnswers: totalAnswers,
            rightAnswers: rightAnswers,
            xp: xp,
          );
        },
      ),
    );
  }

  static int _countRight(int previousValue, bool wasRight) {
    if (wasRight) {
      return previousValue + 1;
    } else {
      return previousValue;
    }
  }
}
