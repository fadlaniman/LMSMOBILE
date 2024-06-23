import 'dart:convert';

List<UserAttendance> userAttendanceFromJson(String str) =>
    List<UserAttendance>.from(
        json.decode(str).map((x) => UserAttendance.fromJson(x)));

String userAttendanceToJson(List<UserAttendance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserAttendance {
  int id;
  int attendanceId;
  String userId;
  String classId;
  DateTime createdAt;
  DateTime updatedAt;
  Users users;
  Attendances attendances;

  UserAttendance({
    required this.id,
    required this.attendanceId,
    required this.userId,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
    required this.attendances,
  });

  factory UserAttendance.fromJson(Map<String, dynamic> json) => UserAttendance(
        id: json["id"],
        attendanceId: json["attendance_id"],
        userId: json["user_id"],
        classId: json["class_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        users: Users.fromJson(json["users"]),
        attendances: Attendances.fromJson(json["attendances"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "attendance_id": attendanceId,
        "user_id": userId,
        "class_id": classId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "users": users.toJson(),
        "attendances": attendances.toJson(),
      };
}

class Attendances {
  int id;
  DateTime datetime;
  String classId;
  DateTime createdAt;
  DateTime updatedAt;

  Attendances({
    required this.id,
    required this.datetime,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendances.fromJson(Map<String, dynamic> json) => Attendances(
        id: json["id"],
        datetime: DateTime.parse(json["datetime"]),
        classId: json["class_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "datetime":
            "${datetime.year.toString().padLeft(4, '0')}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString().padLeft(2, '0')}",
        "class_id": classId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
        uid: json["uid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        level: json["level"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
