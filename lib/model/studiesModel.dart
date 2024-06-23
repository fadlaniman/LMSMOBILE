import 'dart:convert';

List<Studies> studiesFromJson(String str) =>
    List<Studies>.from(json.decode(str).map((x) => Studies.fromJson(x)));

String studiesToJson(List<Studies> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Studies {
  String? id;
  String? name;
  String? description;
  int? duration;
  DateTime? createdAt;
  DateTime? updatedAt;

  Studies({
    this.id,
    this.name,
    this.description,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  factory Studies.fromJson(Map<String, dynamic> json) => Studies(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        duration: json["duration"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "duration": duration,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
