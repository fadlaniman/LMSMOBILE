import 'dart:convert';

List<Enroll> enrollFromJson(String str) =>
    List<Enroll>.from(json.decode(str).map((x) => Enroll.fromJson(x)));

String enrollToJson(List<Enroll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Enroll {
  int id;
  String userId;
  String classId;
  DateTime createdAt;
  DateTime updatedAt;
  Classes classes;

  Enroll({
    required this.id,
    required this.userId,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
    required this.classes,
  });

  factory Enroll.fromJson(Map<String, dynamic> json) => Enroll(
        id: json["id"],
        userId: json["user_id"],
        classId: json["class_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        classes: Classes.fromJson(json["classes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "class_id": classId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "classes": classes.toJson(),
      };
}

class Classes {
  String id;
  String name;
  String description;
  int duration;
  DateTime createdAt;
  DateTime updatedAt;

  Classes({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Classes.fromJson(Map<String, dynamic> json) => Classes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        duration: json["duration"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "duration": duration,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
