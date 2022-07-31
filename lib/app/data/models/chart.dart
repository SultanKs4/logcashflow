import 'dart:convert';

class Chart {
  Chart({
    DateTime? date,
    this.value = 0.0,
  }) : date = date ?? DateTime.now();

  DateTime date;
  num value;

  factory Chart.fromJson(String str) => Chart.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Chart.fromMap(Map<String, dynamic> json) => Chart(
        date: DateTime.parse(json["date"]),
        value: json["value"] as num,
      );

  Map<String, dynamic> toMap() => {
        "date": date.toIso8601String(),
        "value": value,
      };
}
