import 'dart:convert';

class Diary {
  final int id;
  String title;
  String content;
  final DateTime date;
  Diary({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  String get hour =>
      "${date.hour < 10 ? "0" : ""}${date.hour} : ${date.minute < 10 ? "0" : ""}${date.minute}";
  factory Diary.fromJSON(String strData) {
    final data = json.decode(strData);
    return Diary.fromMap(data);
  }

  String get diaryDate =>
      "${date.day < 10 ? "0" : ""}${date.day} / ${date.month < 10 ? "0" : ""}${date.month}/${date.year}";

  factory Diary.fromMap(Map<String, dynamic> map) {
    return Diary(
      id: map['id'] ?? -1,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      date: DateTime.tryParse(map['created_at']) ?? DateTime.now(),
    );
  }

  Diary copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? date,
  }) {
    return Diary(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Diary(id: $id, title: $title, content: $content, date: $date)';
  }
}
