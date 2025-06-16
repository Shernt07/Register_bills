// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  final int? idStaff;
  final int idUser;
  final int idTypeUser;
  final String? tokeFB;
  final String tokeJW;

  UserData({
    this.idStaff,
    required this.idUser,
    required this.idTypeUser,
    this.tokeFB,
    required this.tokeJW,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    idStaff: json["idStaff"],
    idUser: json["idUser"] ?? 0,
    idTypeUser: json["idTypeUser"] ?? 0,
    tokeFB: json["tokeFB"],
    tokeJW: json["tokeJW"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "idStaff": idStaff,
    "idUser": idUser,
    "idTypeUser": idTypeUser,
    "tokeFB": tokeFB,
    "tokeJW": tokeJW,
  };
}
