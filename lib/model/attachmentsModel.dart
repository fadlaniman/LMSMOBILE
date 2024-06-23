import 'dart:convert';

Attachments attachmentsFromJson(String str) =>
    Attachments.fromJson(json.decode(str));

String attachmentsToJson(Attachments data) => json.encode(data.toJson());

class Attachments {
  int? id;
  String? title;
  String? description;
  String? type;
  DateTime? deadline;
  String? file;
  String? userId;
  String? classId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Users? users;
  Classes? classes;

  Attachments({
    this.id,
    this.title,
    this.description,
    this.type,
    this.deadline,
    this.file,
    this.userId,
    this.classId,
    this.createdAt,
    this.updatedAt,
    this.users,
    this.classes,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      type: json["type"],
      deadline:
          json["deadline"] == null ? null : DateTime.tryParse(json["deadline"]),
      file: json["file"],
      userId: json["user_id"],
      classId: json["class_id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.tryParse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.tryParse(json["updated_at"]),
      users: json["users"] == null ? null : Users.fromJson(json["users"]),
      classes:
          json["classes"] == null ? null : Classes.fromJson(json["classes"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "type": type,
      "deadline": deadline?.toIso8601String(),
      "file": file,
      "user_id": userId,
      "class_id": classId,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "users": users?.toJson(),
      "classes": classes?.toJson(),
    };
  }
}

class Classes {
  String? id;
  String? name;
  String? description;
  int? duration;
  DateTime? createdAt;
  DateTime? updatedAt;

  Classes({
    this.id,
    this.name,
    this.description,
    this.duration,
    this.createdAt,
    this.updatedAt,
  });

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      duration: json["duration"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.tryParse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.tryParse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "duration": duration,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}

class Users {
  int? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? level;
  dynamic createdAt;
  DateTime? updatedAt;

  Users({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.level,
    this.createdAt,
    this.updatedAt,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json["uid"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      level: json["level"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.tryParse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "level": level,
      "created_at": createdAt,
      "updated_at": updatedAt?.toIso8601String(),
    };
  }
}
