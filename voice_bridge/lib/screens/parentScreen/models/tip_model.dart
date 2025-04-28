class TipModel {
  final String title;
  final String description;

  TipModel({required this.title, required this.description});

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      title: json['title'],
      description: json['description'],
    );
  }
}
