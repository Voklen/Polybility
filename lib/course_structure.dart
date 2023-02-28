import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:toml/toml.dart';

class Course {
  Course(
      {required String uniqueID, required String name, List<Lesson>? lessons})
      : _uniqueID = uniqueID,
        _name = name,
        _lessons = lessons ?? [];

  final String _uniqueID;
  final String _name;
  final List<Lesson> _lessons;

  void addLesson(Lesson lesson) {
    _lessons.add(lesson);
    _writeToFile();
  }

  String getName() => _name;
  List<Lesson> getLessons() => _lessons;

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
    final String directory = await _saveDirectory;
    final String path = "$directory/$filename.toml";
    final TomlDocument toml = await TomlDocument.load(path);
    final Map map = toml.toMap();
    return Course._fromMap(map);
  }

  Future _writeToFile() async {
    final courseAsMap = toMap();
    final courseAsToml = TomlDocument.fromMap(courseAsMap).toString();
    File(await _filePath).writeAsString(courseAsToml);
  }

  static Stream<String> getCourses() async* {
    final path = await _saveDirectory;
    final directory = Directory(path);
    final files = directory.list();
    String getFilename(file) => file.uri.pathSegments.last;
    yield* files.map(getFilename);
  }

  Future<String> get _filePath async {
    final String directoryPath = await _saveDirectory;
    return '$directoryPath/$_uniqueID.toml';
  }

  static Future<String> get _saveDirectory async {
    final rootDirectory = await _rootDirectory;
    final rootDirectoryPath = rootDirectory.path;
    final saveDirectoryPath = '$rootDirectoryPath/polybility';
    Directory(saveDirectoryPath).createSync();
    return saveDirectoryPath;
  }

  static Future<Directory> get _rootDirectory async {
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
  Lesson({String? description, List<Question>? questions})
      : _description = description ?? 'A lesson',
        _questions = questions ?? [const Question()];

  final String _description;
  final List<Question> _questions;

  Question getQuestion(int index) => _questions[index];
  int nOfQuestions() => _questions.length;
  void addQuestion(Question question) => _questions.add(question);
  void setQuestion(int index, Question question) =>
      _questions[index] = question;
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
  const Question({String? prompt, String? answer})
      : prompt = prompt ?? '',
        answer = answer ?? '';

  final String prompt;
  final String answer;

  Map toMap() => {'prompt': prompt, 'answer': answer};
  static Question fromMap(Map map) {
    String prompt = map['prompt'];
    String answer = map['answer'];
    return Question(prompt: prompt, answer: answer);
  }
}
