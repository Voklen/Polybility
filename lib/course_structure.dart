import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:toml/toml.dart';

class Course {
  Course(
      {required String uniqueID,
      required String name,
      required List<Lesson> lessons})
      : _lessons = lessons,
        _name = name,
        _uniqueID = uniqueID;

  final String _uniqueID;
  final String _name;
  final List<Lesson> _lessons;

  static Course createNew() =>
      Course(uniqueID: 'course', name: 'New course', lessons: []);

  addLesson(Lesson lesson) {
    _lessons.add(lesson);
    _writeToFile();
  }

  Map toMap() {
    final lessonsMap = _lessons.map((e) => e.toMap());
    return {'name': _name, 'lessons': lessonsMap};
  }

  static Course _fromMap(Map map) {
    String name = map['name'];
    List<Map> lessonsMap = map['lessons'];
    List<Lesson> lessons = lessonsMap.map(Lesson.fromMap).toList();
    return Course(uniqueID: 'course', name: name, lessons: lessons);
  }

  static Future<Course> fromFile(String filename) async {
    final Directory directory = await _directory;
    final String directoryPath = directory.path;
    final String path = "$directoryPath/course.toml";
    final TomlDocument toml = await TomlDocument.load(path);
    final Map map = toml.toMap();
    return Course._fromMap(map);
  }

  Future _writeToFile() async {
    final courseAsMap = toMap();
    final courseAsToml = TomlDocument.fromMap(courseAsMap).toString();
    File(await _filePath).writeAsString(courseAsToml);
  }

  Future<String> get _filePath async {
    final Directory directory = await _directory;
    final String directoryPath = directory.path;
    return "$directoryPath/$_uniqueID.toml";
  }

  static Future<Directory> get _directory async {
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
  Lesson({required String description, required List<Question> questions})
      : _questions = questions,
        _description = description;

  final String _description;
  final List<Question> _questions;

  getQuestion(int index) => _questions[index];
  nOfQuestions() => _questions.length;
  addQuestion(Question question) => _questions.add(question);
  setQuestion(int index, Question question) => _questions[index] = question;
  static Lesson createNew() =>
      Lesson(description: 'A lesson', questions: [Question.createNew]);
  Map toMap() {
    final questionsMap = _questions.map((e) => e.toMap());
    return {'description': _description, 'questions': questionsMap};
  }

  static Lesson fromMap(Map map) {
    String description = map['description'];
    List<Map> questionsMap = map['questions'];
    List<Question> questions = questionsMap.map(Question.fromMap).toList();
    return Lesson(description: description, questions: questions);
  }
}

class Question {
  const Question({required this.prompt, required this.answer});

  final String prompt;
  final String answer;

  static const createNew = Question(prompt: '', answer: '');
  Map toMap() => {'prompt': prompt, 'answer': answer};
  static Question fromMap(Map map) {
    String prompt = map['prompt'];
    String answer = map['answer'];
    return Question(prompt: prompt, answer: answer);
  }
}
