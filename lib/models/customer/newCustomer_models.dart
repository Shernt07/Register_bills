// To parse this JSON data, do
//
//     final newCustomerModels = newCustomerModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewCustomerModels newCustomerModelsFromJson(String str) =>
    NewCustomerModels.fromJson(json.decode(str));

String newCustomerModelsToJson(NewCustomerModels data) =>
    json.encode(data.toJson());

class NewCustomerModels {
  final int idUser;
  final int idClient;
  final String nameClient;
  final String firtsLastNameClient;
  final String secondLastNameClient;
  final String telephoneClient;
  final DateTime dateBirth;
  final int idSex;

  NewCustomerModels({
    required this.idUser,
    required this.idClient,
    required this.nameClient,
    required this.firtsLastNameClient,
    required this.secondLastNameClient,
    required this.telephoneClient,
    required this.dateBirth,
    required this.idSex,
  });

  factory NewCustomerModels.fromJson(Map<String, dynamic> json) =>
      NewCustomerModels(
        idUser: json["idUser"],
        idClient: json["idClient"],
        nameClient: json["nameClient"],
        firtsLastNameClient: json["firtsLastNameClient"],
        secondLastNameClient: json["secondLastNameClient"],
        telephoneClient: json["telephoneClient"],
        dateBirth: DateTime.parse(json["dateBirth"]),
        idSex: json["idSex"],
      );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "idClient": idClient,
    "nameClient": nameClient,
    "firtsLastNameClient": firtsLastNameClient,
    "secondLastNameClient": secondLastNameClient,
    "telephoneClient": telephoneClient,
    "dateBirth":
        "${dateBirth.year.toString().padLeft(4, '0')}-${dateBirth.month.toString().padLeft(2, '0')}-${dateBirth.day.toString().padLeft(2, '0')}",
    "idSex": idSex,
  };
}
