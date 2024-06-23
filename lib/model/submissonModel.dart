import 'dart:convert';

List<Submission> submissionFromJson(String str) =>
    List<Submission>.from(json.decode(str).map((x) => Submission.fromJson(x)));

String submissionToJson(List<Submission> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Submission {
  int id;
  String description;
  String file;
  String userId;
  String classId;
  int attachmentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Users users;

  Submission({
    required this.id,
    required this.description,
    required this.file,
    required this.userId,
    required this.classId,
    required this.attachmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        id: json["id"],
        description: json["description"],
        file: json["file"],
        userId: json["user_id"],
        classId: json["class_id"],
        attachmentId: json["attachment_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "file": file,
        "user_id": userId,
        "class_id": classId,
        "attachment_id": attachmentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "users": users.toJson(),
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
