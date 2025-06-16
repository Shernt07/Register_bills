import 'dart:convert';
import 'package:h2o_admin_app/models/usersdata_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const jwtKey = 'jwt_token'; // json web token
  static const idTypeUserKey = 'id_type_user';

  // JSON WEB TOKEN
  // Se obtiene el token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(jwtKey);
  }

  // Se guarda el token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(jwtKey, token);
  }

  // Se elimina el token
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(jwtKey);
  }

  // USER
  // Se obtiene el usuario
  Future<UserData?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return null;
    return UserData.fromJson(jsonDecode(userJson));
  }

  // Se guarda el usuario
  Future<void> saveUser(UserData user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  // Método para imprimir el contenido del usuario guardado
  Future<void> printSavedUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) {
      print('No se ha guardado ningún usuario.');
    } else {
      print('Usuario guardado: $userJson');
      // Si quieres ver los datos decodificados, puedes hacer:
      final userMap = jsonDecode(userJson);
      print('Usuario decodificado: $userMap');
    }
  }

  // Se elimina el usuario
  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  // Se elimina la sesión
  Future<void> deleteSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user');
  }

  // Agrega en SharedPreferencesService

  Future<void> saveIdTypeUser(int? idTypeUser) async {
    final prefs = await SharedPreferences.getInstance();
    if (idTypeUser != null) {
      await prefs.setInt(idTypeUserKey, idTypeUser);
    }
  }

  Future<int?> getIdTypeUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(idTypeUserKey);
  }

  Future<void> deleteIdTypeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(idTypeUserKey);
  }
}



  // static const fcmTokenKey = 'fcm_token'; // firebase token

  // FIREBASE
  // Future<void> saveFcmToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(fcmTokenKey, token);
  // }

  // Future<String?> getFcmToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(fcmTokenKey);
  // }

  // Future<void> deleteFcmToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove(fcmTokenKey);
  // }
