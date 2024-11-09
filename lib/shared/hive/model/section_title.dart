// To parse this JSON data, do
//
//     final sectionTitle = sectionTitleFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'section_title.g.dart';

List<SectionTitle> sectionTitleFromJson(String str) => List<SectionTitle>.from(json.decode(str).map((x) => SectionTitle.fromJson(x)));

String sectionTitleToJson(List<SectionTitle> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 4)
class SectionTitle {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
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
