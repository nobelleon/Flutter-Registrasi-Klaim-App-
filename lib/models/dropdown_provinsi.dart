// To parse this JSON data, do
//
//     final dropdownProvinsi = dropdownProvinsiFromJson(jsonString);

import 'dart:convert';

List<DropdownProvinsi> dropdownProvinsiFromJson(String str) =>
    List<DropdownProvinsi>.from(
        json.decode(str).map((x) => DropdownProvinsi.fromJson(x)));

String dropdownProvinsiToJson(List<DropdownProvinsi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropdownProvinsi {
  String userId;
  String id;
  String title;

  DropdownProvinsi({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory DropdownProvinsi.fromJson(Map<String, dynamic> json) =>
      DropdownProvinsi(
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
