import 'dart:convert';

List<Class> classFromJson(String str) =>
    List<Class>.from(json.decode(str).map((x) => Class.fromJson(x)));

String classToJson(List<Class> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Class {
  int id;
  String userId;
  String classId;
  DateTime createdAt;
  DateTime updatedAt;
  Users users;
  Classes classes;

  Class({
    required this.id,
    required this.userId,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
    required this.classes,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        userId: json["user_id"],
        classId: json["class_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        users: Users.fromJson(json["users"]),
        classes: Classes.fromJson(json["classes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "class_id": classId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "users": users.toJson(),
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

class Users {
  int uid;
  String firstName;
  String lastName;
  String email;
  String? phone;
  String level;
  DateTime? createdAt;
  DateTime updatedAt;

  Users({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json["uid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        level: json["level"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "level": level,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
