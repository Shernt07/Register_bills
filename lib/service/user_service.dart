import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';

import 'package:http/http.dart' as http;

class UserService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "/auth";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Map<String, String> get _headers => {
    //mandar encabezado para trabajar con json
    'Content-type': 'application/json',
  };

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase$_api/$endpoint');
  } //armar la base

  Future<ResponseApi> login(
    String email,
    String password,
    String? tokenFB,
    //el signo indica que puede llegar vacio
  ) async {
    try {
      //Uri url = Uri.parse('$_urlbase/$_api/loginstaff');
      Uri url = _buildUri("loginstaff");
      String bodyParams = json.encode({
        "user": email,
        "password": password,
        'tokenFB': tokenFB,
      });
      print(url);
      print(email);
      print(password);
      print(tokenFB);

      final response = await http.post(
        url,
        headers: _headers,
        body: bodyParams,
      );
      print(' Código de estado user-service: ${response.statusCode}');
      print(' Cuerpo de respuesta user-service: ${response.body}');
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final data = json.decode(response.body);
          print('datos de login user-service: $data');
          return ResponseApi.fromJson(data);
        } else {
          return ResponseApi(
            message: 'Respuesta vacía del servidor',
            success: false,
          );
        }
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print('mensaje.: $emessage');
        return ResponseApi(message: 'error:$emessage', success: false);
      }
    } catch (e) {
      print('$e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }
}
