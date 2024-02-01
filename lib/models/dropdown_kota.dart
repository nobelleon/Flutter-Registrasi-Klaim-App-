// To parse this JSON data, do
//
//     final dropdownKota = dropdownKotaFromJson(jsonString);

import 'dart:convert';

List<DropdownKota> dropdownKotaFromJson(String str) => List<DropdownKota>.from(
    json.decode(str).map((x) => DropdownKota.fromJson(x)));

String dropdownKotaToJson(List<DropdownKota> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropdownKota {
  int userId;
  int id;
  String title;

  DropdownKota({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory DropdownKota.fromJson(Map<String, dynamic> json) => DropdownKota(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
