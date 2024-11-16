// To parse this JSON data, do
//
//     final domain = domainFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'historical.g.dart';

List<Historical> domainFromJson(String str) => List<Historical>.from(json.decode(str).map((x) => Historical.fromJson(x)));

String domainToJson(List<Historical> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 6)
class Historical {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  String text;

  @HiveField(3)
  int user;

  Historical({
    required this.id,
    required this.createdAt,
    required this.text,
    required this.user,
  });

  factory Historical.fromJson(Map<String, dynamic> json) => Historical(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    text: json["text"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "text": text,
    "user": user,
  };
}
