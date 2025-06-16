import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';

import 'package:http/http.dart' as http;

class DetailsordersService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "orders";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase/$_api/$endpoint');
  } //armar la base

  Future<ResponseApi> detailsOrdersService(int idOrder) async {
    try {
      // se concatena para mandar el valor recibido en idOrder.
      Uri url = _buildUri("detailOrder/$idOrder");
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodificar el JSON recibido
        return ResponseApi.fromJson(
          data,
        ); // Devolverlo como un objeto ResponseApi
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print(emessage);
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print(e);
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }
}
