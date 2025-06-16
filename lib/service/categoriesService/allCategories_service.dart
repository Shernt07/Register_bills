import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class AllCategoriesService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "categories";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase/$_api/$endpoint');
  } //armar la base

  Future<ResponseApi> allCategoriesService() async {
    try {
      // se concatena para mandar el valor recibido en date.
      Uri url = _buildUri("categories");
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodificar el JSON recibido
        print('lo que recibe el service:  $data');
        return ResponseApi.fromJson(
          data,
        ); // Devolverlo como un objeto ResponseApi
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print("emessage de service-allcategories: $emessage");
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('e de service-allcategories: $e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }
}
