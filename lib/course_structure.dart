class Course {
  const Course({required this.name, required this.lessons});

  final String name;
  final List<Lesson> lessons;
}

class Lesson {
  Lesson({required this.description, required this.questions});

  addQuestion(Question question) => questions.add(question);
  toMap() => {'description': description, 'questions': questions};

  final String description;
  List<Question> questions;
}

class Question {
  const Question({required this.prompt, required this.answer});

  final String prompt;
  final String answer;
}
