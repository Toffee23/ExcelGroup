class CoursesModel {
  CoursesModel({
    required this.id,
    required this.title,
    required this.creator,
    required this.description,
    required this.thumbnail,
    required this.lessons,
    required this.subscribers,
  });
  final String id;
  final String title;
  final String creator;
  final String description;
  final String thumbnail;
  final List<Map<String, dynamic>> lessons;
  final List subscribers;

  factory CoursesModel.fromJson(Map<String, dynamic> json) {
    return CoursesModel(
      id: json['_id'],
      title: json['title'],
      creator: json['creator'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      lessons: (json['lessons'] as List).cast<Map<String, dynamic>>(),
      subscribers: json['subscribers'],
    );
  }
}
