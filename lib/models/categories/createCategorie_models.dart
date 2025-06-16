// To parse this JSON data, do
//
//     final createCategorieModel = createCategorieModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateCategorieModel createCategorieModelFromJson(String str) =>
    CreateCategorieModel.fromJson(json.decode(str));

String createCategorieModelToJson(CreateCategorieModel data) =>
    json.encode(data.toJson());

class CreateCategorieModel {
  final int idCategorie;
  final String name;
  final String urlImg;
  final int status;

  CreateCategorieModel({
    required this.idCategorie,
    required this.name,
    required this.urlImg,
    required this.status,
  });

  factory CreateCategorieModel.fromJson(Map<String, dynamic> json) =>
      CreateCategorieModel(
        idCategorie: json["idCategorie"],
        name: json["name"],
        urlImg: json["urlImg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "idCategorie": idCategorie,
    "name": name,
    "urlImg": urlImg,
    "status": status,
  };
}
