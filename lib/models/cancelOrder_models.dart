// To parse this JSON data, do
//
//     final cancelOrderModel = cancelOrderModelFromJson(jsonString);

import 'dart:convert';

CancelOrderModel cancelOrderModelFromJson(String str) =>
    CancelOrderModel.fromJson(json.decode(str));

String cancelOrderModelToJson(CancelOrderModel data) =>
    json.encode(data.toJson());

class CancelOrderModel {
  CancelOrderModel();

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) =>
      CancelOrderModel();

  Map<String, dynamic> toJson() => {};
}
