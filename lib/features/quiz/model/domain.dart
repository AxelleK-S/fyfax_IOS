// To parse this JSON data, do
//
//     final domain = domainFromJson(jsonString);

import 'dart:convert';

List<Domain> domainFromJson(String str) => List<Domain>.from(json.decode(str).map((x) => Domain.fromJson(x)));

String domainToJson(List<Domain> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Domain {
  int id;
  DateTime createdAt;
  String name;

  Domain({
    required this.id,
    required this.createdAt,
    required this.name,
  });

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "name": name,
  };
}
