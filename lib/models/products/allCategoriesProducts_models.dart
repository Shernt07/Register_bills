// To parse this JSON data, do
//
//     final allcategoriesProductsModels = allcategoriesProductsModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllcategoriesProductsModels> allcategoriesProductsModelsFromJson(
  String str,
) => List<AllcategoriesProductsModels>.from(
  json.decode(str).map((x) => AllcategoriesProductsModels.fromJson(x)),
);

String allcategoriesProductsModelsToJson(
  List<AllcategoriesProductsModels> data,
) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllcategoriesProductsModels {
  final int idCategorie;
  final String nameCategorie;

  AllcategoriesProductsModels({
    required this.idCategorie,
    required this.nameCategorie,
  });

  factory AllcategoriesProductsModels.fromJson(Map<String, dynamic> json) =>
      AllcategoriesProductsModels(
        idCategorie: json["idCategorie"],
        nameCategorie: json["nameCategorie"],
      );

  Map<String, dynamic> toJson() => {
    "idCategorie": idCategorie,
    "nameCategorie": nameCategorie,
  };
}
