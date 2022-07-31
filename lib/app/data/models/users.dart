import 'dart:convert';

class Users {
  Users({
    this.id = 0,
    required this.username,
    required this.password,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  int id;
  String username;
  String password;
  DateTime createdAt;

  factory Users.fromJson(String str) => Users.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
        password: json["password"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
        "created_at": createdAt.toIso8601String(),
      };
}
