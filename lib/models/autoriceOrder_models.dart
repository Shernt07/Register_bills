// To parse this JSON data, do
//
//     final AutoriceOrderModel = AutoriceOrderModelFromJson(jsonString);

import 'dart:convert';

AutoriceOrderModel AutoriceOrderModelFromJson(String str) =>
    AutoriceOrderModel.fromJson(json.decode(str));

String AutoriceOrderModelToJson(AutoriceOrderModel data) =>
    json.encode(data.toJson());

class AutoriceOrderModel {
  AutoriceOrderModel();

  factory AutoriceOrderModel.fromJson(Map<String, dynamic> json) =>
      AutoriceOrderModel();

  Map<String, dynamic> toJson() => {};
}
