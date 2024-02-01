// To parse this JSON data, do
//
//     final dropdownKecamatan = dropdownKecamatanFromJson(jsonString);

import 'dart:convert';

List<DropdownKecamatan> dropdownKecamatanFromJson(String str) =>
    List<DropdownKecamatan>.from(
        json.decode(str).map((x) => DropdownKecamatan.fromJson(x)));

String dropdownKecamatanToJson(List<DropdownKecamatan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropdownKecamatan {
  int userId;
  int id;
  String title;

  DropdownKecamatan({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory DropdownKecamatan.fromJson(Map<String, dynamic> json) =>
      DropdownKecamatan(
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
