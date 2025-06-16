// To parse this JSON data, do
//
//     final allCategoriesModel = allCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllCategoriesModel> allCategoriesModelFromJson(String str) =>
    List<AllCategoriesModel>.from(
      json.decode(str).map((x) => AllCategoriesModel.fromJson(x)),
    );

String allCategoriesModelToJson(List<AllCategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCategoriesModel {
  final int idCategorie;
  final String nameCategorie;
  final String urlImage;
  final int idCategoryStatus;

  AllCategoriesModel({
    required this.idCategorie,
    required this.nameCategorie,
    required this.urlImage,
    required this.idCategoryStatus,
  });

  factory AllCategoriesModel.fromJson(Map<String, dynamic> json) =>
      AllCategoriesModel(
        idCategorie: json["idCategorie"],
        nameCategorie: json["nameCategorie"],
        urlImage: json["urlImage"],
        idCategoryStatus: json["idCategoryStatus"],
      );

  Map<String, dynamic> toJson() => {
    "idCategorie": idCategorie,
    "nameCategorie": nameCategorie,
    "urlImage": urlImage,
    "idCategoryStatus": idCategoryStatus,
  };
}
