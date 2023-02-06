import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:toml/toml.dart';

class Course {
  const Course(
      {required this.uniqueID, required this.name, required this.lessons});

  final String uniqueID;
  final String name;
  final List<Lesson> lessons;

  static final createNew =
      Course(uniqueID: 'course', name: 'New course', lessons: []);

  addLesson(Lesson lesson) => lessons.add(lesson);
  Map toMap() {
    final lessonsMap = lessons.map((e) => e.toMap());
    return {'name': name, 'lessons': lessonsMap};
  }

  Future writeToFile() async {
    final courseAsMap = toMap();
    final courseAsToml = TomlDocument.fromMap(courseAsMap).toString();
    File(await _filePath).writeAsString(courseAsToml);
  }

  Future<String> get _filePath async {
    final Directory directory = await _directory;
    final String directoryPath = directory.path;
    return "$directoryPath/$uniqueID.toml";
  }

  Future<Directory> get _directory async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        return directory;
      }
    }

    return getApplicationDocumentsDirectory();
  }
}

class Lesson {
  Lesson({required this.description, required this.questions});

  final String description;
  final List<Question> questions;

  static createNew() =>
      Lesson(description: 'A lesson', questions: [Question.createNew]);

  addQuestion(Question question) => questions.add(question);
  Map toMap() {
    final questionsMap = questions.map((e) => e.toMap());
    return {'description': description, 'questions': questionsMap};
  }
}

class Question {
  const Question({required this.prompt, required this.answer});

  final String prompt;
  final String answer;

  static const createNew = Question(prompt: '', answer: '');
  Map toMap() => {'prompt': prompt, 'answer': answer};
}
