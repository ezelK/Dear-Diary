import 'dart:convert';

class CreateDiary {
  final String title;
  final String content;

  CreateDiary({
    required this.title,
    required this.content,
  });
  Map<String, dynamic> toMap() {
    return {'title': title, 'content': content};
  }
  String toJSON() {
    return json.encode(toMap());
  }
}
