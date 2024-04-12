import 'dart:convert';

Classroom classroomFromJson(String str) => Classroom.fromJson(json.decode(str));

String classroomToJson(Classroom data) => json.encode(data.toJson());

class Classroom {
  final int id;
  final String username;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Class> classes;

  Classroom({
    required this.id,
    required this.username,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.classes,
  });

  factory Classroom.fromJson(Map<String, dynamic> json) => Classroom(
        id: json["id"],
        username: json["username"],
        role: json["role"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        classes:
            List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "role": role,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
      };
}

class Class {
  final int id;
  final String name;
  final String section;
  final String subject;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Pivot pivot;

  Class({
    required this.id,
    required this.name,
    required this.section,
    required this.subject,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        name: json["name"],
        section: json["section"],
        subject: json["subject"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "section": section,
        "subject": subject,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  final int userId;
  final int classesId;
  final int id;

  Pivot({
    required this.userId,
    required this.classesId,
    required this.id,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        classesId: json["classes_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "classes_id": classesId,
        "id": id,
      };
}
