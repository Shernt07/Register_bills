



//  SE OCUPARA USER DATA MODELS












// // To parse this JSON data, do
// //
// //     final users = usersFromJson(jsonString);

// import 'dart:convert';

// Users usersFromJson(String str) => Users.fromJson(json.decode(str));

// String usersToJson(Users data) => json.encode(data.toJson());

// class Users {
//   final int idUsers;
//   final String nameUser;
//   final String passwordUser;
//   final int idTypeUser;
//   final int idStatusUser;

//   Users({
//     required this.idUsers,
//     required this.nameUser,
//     required this.passwordUser,
//     required this.idTypeUser,
//     required this.idStatusUser,
//   });

//   factory Users.fromJson(Map<String, dynamic> json) => Users(
//     idUsers: json["idUsers"],
//     nameUser: json["nameUser"],
//     passwordUser: json["passwordUser"],
//     idTypeUser: json["idTypeUser"],
//     idStatusUser: json["idStatusUser"],
//   );

//   Map<String, dynamic> toJson() => {
//     "idUsers": idUsers,
//     "nameUser": nameUser,
//     "passwordUser": passwordUser,
//     "idTypeUser": idTypeUser,
//     "idStatusUser": idStatusUser,
//   };
// }


//comentado por que no se usa?