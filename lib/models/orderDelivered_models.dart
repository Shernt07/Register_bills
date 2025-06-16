// To parse this JSON data, do
//
//     final orderDeliveredModel = orderDeliveredModelFromJson(jsonString);

import 'dart:convert';

OrderDeliveredModel orderDeliveredModelFromJson(String str) =>
    OrderDeliveredModel.fromJson(json.decode(str));

String orderDeliveredModelToJson(OrderDeliveredModel data) =>
    json.encode(data.toJson());

class OrderDeliveredModel {
  final int idOrder;
  final int idClient;
  final DateTime dateOrder;
  final int idAddress;
  final int idOrderStatus;
  final int total;
  final int idTypePayment;
  final int idStatusPayment;
  final dynamic dateDelivery;
  final String commentOrder;
  final String commentOrderAdmin;
  final String commentOrderDelivery;

  OrderDeliveredModel({
    required this.idOrder,
    required this.idClient,
    required this.dateOrder,
    required this.idAddress,
    required this.idOrderStatus,
    required this.total,
    required this.idTypePayment,
    required this.idStatusPayment,
    required this.dateDelivery,
    required this.commentOrder,
    required this.commentOrderAdmin,
    required this.commentOrderDelivery,
  });

  factory OrderDeliveredModel.fromJson(Map<String, dynamic> json) =>
      OrderDeliveredModel(
        idOrder: json["idOrder"],
        idClient: json["idClient"],
        dateOrder: DateTime.parse(json["dateOrder"]),
        idAddress: json["idAddress"],
        idOrderStatus: json["idOrderStatus"],
        total: json["total"],
        idTypePayment: json["idTypePayment"],
        idStatusPayment: json["idStatusPayment"],
        dateDelivery: json["dateDelivery"],
        commentOrder: json["commentOrder"],
        commentOrderAdmin: json["commentOrderAdmin"],
        commentOrderDelivery: json["commentOrderDelivery"],
      );

  Map<String, dynamic> toJson() => {
    "idOrder": idOrder,
    "idClient": idClient,
    "dateOrder": dateOrder.toIso8601String(),
    "idAddress": idAddress,
    "idOrderStatus": idOrderStatus,
    "total": total,
    "idTypePayment": idTypePayment,
    "idStatusPayment": idStatusPayment,
    "dateDelivery": dateDelivery,
    "commentOrder": commentOrder,
    "commentOrderAdmin": commentOrderAdmin,
    "commentOrderDelivery": commentOrderDelivery,
  };
}
