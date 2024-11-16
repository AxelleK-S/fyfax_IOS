// To parse this JSON data, do
//
//     final domain = domainFromJson(jsonString);

import 'dart:convert';

List<Historical> domainFromJson(String str) => List<Historical>.from(json.decode(str).map((x) => Historical.fromJson(x)));

String domainToJson(List<Historical> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Historical {
  int id;
  DateTime createdAt;
  String text;
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
