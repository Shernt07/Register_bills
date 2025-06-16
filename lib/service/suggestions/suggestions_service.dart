import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class SuggestionsService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "suggestion";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Map<String, String> get _headers => {
    //mandar encabezado para trabajar con json
    'Content-type': 'application/json',
  };

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase/$_api/$endpoint');
  } //armar la base

  // SERVICE GETALL
  Future<ResponseApi> allSuggestionService() async {
    try {
      Uri url = _buildUri("client");
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodificar el JSON recibido
        print('lo que recibe el service-allSuggestion:  $data');
        return ResponseApi.fromJson(
          data,
        ); // Devolverlo como un objeto ResponseApi
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print("emessage de service-allSuggestion: $emessage");
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('e de service-allSuggestion: $e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }

  // MÉTODO PUT PARA ACTUALIZAR isRead
  Future<ResponseApi> updateSuggestion(int idComment) async {
    try {
      Uri url = _buildUri("read/$idComment");
      print('PUT URL: $url');

      final response = await http.put(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Respuesta PUT: $data');
        return ResponseApi.fromJson(data);
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print("Error PUT: $emessage");
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('Excepción PUT: $e');
      return ResponseApi(message: 'Excepción: $e', success: false);
    }
  }
}
