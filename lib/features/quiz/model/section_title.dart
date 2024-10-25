// To parse this JSON data, do
//
//     final sectionTitle = sectionTitleFromJson(jsonString);

import 'dart:convert';

List<SectionTitle> sectionTitleFromJson(String str) => List<SectionTitle>.from(json.decode(str).map((x) => SectionTitle.fromJson(x)));

String sectionTitleToJson(List<SectionTitle> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SectionTitle {
  int id;
  DateTime createdAt;
  String title;

  SectionTitle({
    required this.id,
    required this.createdAt,
    required this.title,
  });

  factory SectionTitle.fromJson(Map<String, dynamic> json) => SectionTitle(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "title": title,
  };
}
