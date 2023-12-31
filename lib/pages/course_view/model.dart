class CourseModel {
  CourseModel({
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
  final List<Lessons> lessons;
  final List subscribers;

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['_id'],
      title: json['title'],
      creator: json['creator'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      lessons:
          json['lessons'].map<Lessons>((e) => Lessons.fromJson(e)).toList(),
      subscribers: json['subscribers'],
    );
  }
}

class Lessons {
  Lessons({
    required this.id,
    required this.name,
    required this.modules,
    required this.subscriptionRequired,
  });
  final String id;
  final String name;
  final List<Module> modules;
  final bool subscriptionRequired;

  factory Lessons.fromJson(Map<String, dynamic> json) {
    return Lessons(
      id: json['_id'],
      name: json['lesson_name'],
      modules: json['modules'].map<Module>((e) => Module.fromJson(e)).toList(),
      subscriptionRequired: json['subscriptionRequired'],
    );
  }
}

class Module {
  Module({
    required this.id,
    required this.name,
    required this.url,
    required this.subscriptionRequired,
  });
  final String id;
  final String name;
  final String url;
  final bool subscriptionRequired;

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      id: json['_id'],
      name: json['module_name'],
      url: json['firebase_id'],
      subscriptionRequired: json['subscriptionRequired'],
    );
  }
}
