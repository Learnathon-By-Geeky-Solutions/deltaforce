import 'lesson_model.dart';

class Session {
  final String sessionName;
  final List<Lesson> lessons;

  Session({required this.sessionName, required this.lessons});

  factory Session.fromJson(Map<String, dynamic> json) {
    var lessonList = (json['lessons'] as List)
        .map((lessonJson) => Lesson.fromJson(lessonJson))
        .toList();
    return Session(
      sessionName: json['sessionName'],
      lessons: lessonList,
    );
  }
}

