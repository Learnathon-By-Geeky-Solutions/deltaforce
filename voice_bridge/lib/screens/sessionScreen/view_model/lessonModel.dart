class Lesson {
  final String lessonName;
  final String imageAsset;
  final String animationAsset;
  final String audioAsset;

  Lesson({
    required this.lessonName,
    required this.imageAsset,
    required this.animationAsset,
    required this.audioAsset,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      lessonName: json['lessonName'],
      imageAsset: json['imageAsset'],
      animationAsset: json['animationAsset'],
      audioAsset: json['audioAsset'],
    );
  }
}
