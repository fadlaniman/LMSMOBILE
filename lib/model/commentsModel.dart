import 'dart:convert';

List<Comments> commentsFromJson(String str) {
  if (str.isEmpty) return [];
  final jsonData = json.decode(str);
  return List<Comments>.from(jsonData.map((x) => Comments.fromJson(x)));
}

String commentsToJson(List<Comments> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comments {
  int id;
  String text;
  String userId;
  String classId;
  int attachmentId;
  dynamic createdAt;
  dynamic updatedAt;
  Users users;

  Comments({
    required this.id,
    required this.text,
    required this.userId,
    required this.classId,
    required this.attachmentId,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        id: json["id"],
        text: json["text"] ?? "", // Handle potential null value
        userId: json["user_id"] ?? "", // Handle potential null value
        classId: json["class_id"] ?? "", // Handle potential null value
        attachmentId: json["attachment_id"] ?? 0, // Handle potential null value
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        users:
            Users.fromJson(json["users"] ?? {}), // Handle potential null value
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "user_id": userId,
        "class_id": classId,
        "attachment_id": attachmentId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "users": users.toJson(),
      };
}

class Users {
  int uid;
  String firstName;
  String lastName;
  String email;
  dynamic phone;
  String level;
  DateTime createdAt;
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
        uid: json["uid"] ?? 0,
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        email: json["email"] ?? "",
        phone: json["phone"],
        level: json["level"] ?? "",
        createdAt:
            DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "level": level,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
