// To parse this JSON data, do
//
//     final allcommentsCustomerModels = allcommentsCustomerModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllcommentsCustomerModels> allcommentsCustomerModelsFromJson(String str) =>
    List<AllcommentsCustomerModels>.from(
      json.decode(str).map((x) => AllcommentsCustomerModels.fromJson(x)),
    );

String allcommentsCustomerModelsToJson(List<AllcommentsCustomerModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllcommentsCustomerModels {
  final int idComments;
  final int idUser;
  final String comment;
  final String dateCreate;
  final bool isRead;

  AllcommentsCustomerModels({
    required this.idComments,
    required this.idUser,
    required this.comment,
    required this.dateCreate,
    required this.isRead,
  });

  factory AllcommentsCustomerModels.fromJson(Map<String, dynamic> json) =>
      AllcommentsCustomerModels(
        idComments: json["idComments"],
        idUser: json["idUser"],
        comment: json["comment"],
        dateCreate: json["dateCreate"],
        isRead: json["isRead"],
      );

  Map<String, dynamic> toJson() => {
    "idComments": idComments,
    "idUser": idUser,
    "comment": comment,
    "dateCreate": dateCreate,
    "isRead": isRead,
  };
}
