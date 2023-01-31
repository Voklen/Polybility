class Course {
  const Course({required this.name, required this.lessons});

  toMap() {
    final lessonsMap = lessons.map((e) => e.toMap());
    return {'name': name, 'questions': lessonsMap};
  }

  final String name;
  final List<Lesson> lessons;
}

class Lesson {
  Lesson({required this.description, required this.questions});

  addQuestion(Question question) => questions.add(question);
  toMap() {
    final questionsMap = questions.map((e) => e.toMap());
    return {'description': description, 'questions': questionsMap};
  }

  final String description;
  List<Question> questions;
}

class Question {
  const Question({required this.prompt, required this.answer});

  toMap() => {'prompt': prompt, 'answer': answer};

  final String prompt;
  final String answer;
}
