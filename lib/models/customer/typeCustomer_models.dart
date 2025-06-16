// To parse this JSON data, do
//
//     final typeCustomerModels = typeCustomerModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<TypeCustomerModels> typeCustomerModelsFromJson(String str) =>
    List<TypeCustomerModels>.from(
      json.decode(str).map((x) => TypeCustomerModels.fromJson(x)),
    );

String typeCustomerModelsToJson(List<TypeCustomerModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeCustomerModels {
  final int idTypeUser;
  final String nameType;

  TypeCustomerModels({required this.idTypeUser, required this.nameType});

  factory TypeCustomerModels.fromJson(Map<String, dynamic> json) =>
      TypeCustomerModels(
        idTypeUser: json["idTypeUser"],
        nameType: json["nameType"],
      );

  Map<String, dynamic> toJson() => {
    "idTypeUser": idTypeUser,
    "nameType": nameType,
  };
}
