import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class DeleteCategoriesService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "/categories";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Map<String, String> get _headers => {
    // Mandar encabezado para trabajar con json
    'Content-type': 'application/json',
  };

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase$_api/$endpoint'); // Construir la URL completa
  }

  // Método DELETE para eliminar categoría
  Future<ResponseApi> deleteCategoryService(int idCategorie) async {
    try {
      // Construir la URL para el endpoint de eliminación con el idCategorie
      Uri url = _buildUri(
        "delete/$idCategorie",
      ); // Ejemplo de endpoint: /categories/delete/1
      print(url);

      // Realizar la solicitud DELETE
      final response = await http.delete(url, headers: _headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseApi.fromJson(data);
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'Error desconocido';
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('Error en deleteCategoryService: $e');
      return ResponseApi(message: 'Excepción: $e', success: false);
    }
  }
}
