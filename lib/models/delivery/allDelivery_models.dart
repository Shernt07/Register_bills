// To parse this JSON data, do
//
//     final allDeliveryModels = allDeliveryModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllDeliveryModels> allDeliveryModelsFromJson(String str) =>
    List<AllDeliveryModels>.from(
      json.decode(str).map((x) => AllDeliveryModels.fromJson(x)),
    );

String allDeliveryModelsToJson(List<AllDeliveryModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllDeliveryModels {
  final int idUser;
  final int idStaff;
  final String nameCompleteClient;
  final String descriptionSex;
  final String emailStaff;
  final String nameUser;
  final String passwordUser;
  final String nameType;
  final String nameStatus;
  final String dateCreation;
  final String telephoneStaff;
  final String urlPhotoStaff;
  final String nameStaff;
  final String firtsLastNameStaff;
  final String secondLastNameStaff;
  final String initalSex;

  AllDeliveryModels({
    required this.idUser,
    required this.idStaff,
    required this.nameCompleteClient,
    required this.descriptionSex,
    required this.emailStaff,
    required this.nameUser,
    required this.passwordUser,
    required this.nameType,
    required this.nameStatus,
    required this.dateCreation,
    required this.telephoneStaff,
    required this.urlPhotoStaff,
    required this.nameStaff,
    required this.firtsLastNameStaff,
    required this.secondLastNameStaff,
    required this.initalSex,
  });

  factory AllDeliveryModels.fromJson(Map<String, dynamic> json) =>
      AllDeliveryModels(
        idUser: json["idUser"],
        idStaff: json["idStaff"],
        nameCompleteClient: json["nameCompleteClient"],
        descriptionSex: json["descriptionSex"],
        emailStaff: json["emailStaff"],
        nameUser: json["nameUser"],
        passwordUser: json["passwordUser"],
        nameType: json["nameType"],
        nameStatus: json["nameStatus"],
        dateCreation: json["dateCreation"],
        telephoneStaff: json["telephoneStaff"],
        urlPhotoStaff: json["urlPhotoStaff"],
        nameStaff: json["nameStaff"],
        firtsLastNameStaff: json["firtsLastNameStaff"],
        secondLastNameStaff: json["secondLastNameStaff"],
        initalSex: json["initalSex"],
      );

  Map<String, dynamic> toJson() => {
    "idUser": idUser,
    "idStaff": idStaff,
    "nameCompleteClient": nameCompleteClient,
    "descriptionSex": descriptionSex,
    "emailStaff": emailStaff,
    "nameUser": nameUser,
    "passwordUser": passwordUser,
    "nameType": nameType,
    "nameStatus": nameStatus,
    "dateCreation": dateCreation,
    "telephoneStaff": telephoneStaff,
    "urlPhotoStaff": urlPhotoStaff,
    "nameStaff": nameStaff,
    "firtsLastNameStaff": firtsLastNameStaff,
    "secondLastNameStaff": secondLastNameStaff,
    "initalSex": initalSex,
  };
}
