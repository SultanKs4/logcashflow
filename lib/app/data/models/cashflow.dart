import 'dart:convert';

class Cashflow {
  int? id;
  int usersId;
  int type;
  DateTime date;
  double value;
  String description;
  DateTime createdAt;

  Cashflow({
    this.id,
    required this.usersId,
    required this.type,
    DateTime? date,
    required this.value,
    required this.description,
    DateTime? createdAt,
  })  : date = date ?? DateTime.now(),
        createdAt = createdAt ?? DateTime.now();

  factory Cashflow.fromJson(String str) => Cashflow.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cashflow.fromMap(Map<String, dynamic> json) => Cashflow(
        id: json["id"],
        usersId: json["users_id"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
        value: json["value"].toDouble(),
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "users_id": usersId,
        "type": type,
        "date": date.toIso8601String(),
        "value": value,
        "description": description,
        "created_at": createdAt.toIso8601String(),
      };
}
