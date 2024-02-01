// To parse this JSON data, do
//
//     final dropdownKelurahan = dropdownKelurahanFromJson(jsonString);

import 'dart:convert';

List<DropdownKelurahan> dropdownKelurahanFromJson(String str) =>
    List<DropdownKelurahan>.from(
        json.decode(str).map((x) => DropdownKelurahan.fromJson(x)));

String dropdownKelurahanToJson(List<DropdownKelurahan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropdownKelurahan {
  int userId;
  int id;
  String title;

  DropdownKelurahan({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory DropdownKelurahan.fromJson(Map<String, dynamic> json) =>
      DropdownKelurahan(
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
