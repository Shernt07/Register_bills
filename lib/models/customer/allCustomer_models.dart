// To parse this JSON data, do
//
//     final allCustomerModels = allCustomerModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllCustomerModels> allCustomerModelsFromJson(String str) =>
    List<AllCustomerModels>.from(
      json.decode(str).map((x) => AllCustomerModels.fromJson(x)),
    );

String allCustomerModelsToJson(List<AllCustomerModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCustomerModels {
  final int idUser;
  final int idClient;
  final String nameCompleteClient;
  final String descriptionSex;
  final String emailClient;
  final String nameUser;
  final String passwordUser;
  final String nameType;
  final String typeUser;
  final String nameStatus;
  final DateTime dateCreation;
  final String telephoneClient;
  final String urlPhotoClient;
  final String nameClient;
  final String firtsLastNameClient;
  final String secondLastNameClient;
  final String initalSex;

  AllCustomerModels({
    required this.idUser,
    required this.idClient,
    required this.nameCompleteClient,
    required this.descriptionSex,
    required this.emailClient,
    required this.nameUser,
    required this.passwordUser,
    required this.nameType,
    required this.typeUser,
    required this.nameStatus,
    required this.dateCreation,
    required this.telephoneClient,
    required this.urlPhotoClient,
    required this.nameClient,
    required this.firtsLastNameClient,
    required this.secondLastNameClient,
    required this.initalSex,
  });

  factory AllCustomerModels.fromJson(Map<String, dynamic> json) =>
      AllCustomerModels(
        idUser: json["idUser"],
        idClient: json["idClient"],
        nameCompleteClient: json["nameCompleteClient"],
        descriptionSex: json["descriptionSex"],
        emailClient: json["emailClient"],
        nameUser: json["nameUser"],
        passwordUser: json["passwordUser"],
        nameType: json["nameType"],
        typeUser: json["typeUser"],
        nameStatus: json["nameStatus"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        telephoneClient: json["telephoneClient"] ?? '',
        urlPhotoClient: json["urlPhotoClient"],
        nameClient: json["nameClient"],
        firtsLastNameClient: json["firtsLastNameClient"],
        secondLastNameClient: json["secondLastNameClient"],
        initalSex: json["initalSex"],
      );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "idClient": idClient,
    "nameCompleteClient": nameCompleteClient,
    "descriptionSex": descriptionSex,
    "emailClient": emailClient,
    "nameUser": nameUser,
    "passwordUser": passwordUser,
    "nameType": nameType,
    "typeUser": typeUser,
    "nameStatus": nameStatus,
    "dateCreation": dateCreation.toIso8601String(),
    "telephoneClient": telephoneClient,
    "urlPhotoClient": urlPhotoClient,
    "nameClient": nameClient,
    "firtsLastNameClient": firtsLastNameClient,
    "secondLastNameClient": secondLastNameClient,
    "initalSex": initalSex,
  };
}
