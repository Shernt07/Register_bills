import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';

import 'package:http/http.dart' as http;

class CancelOrderService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "/orders";

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

  Future<ResponseApi> cancelOrderService(
    int idOrder,
    String commentOrder,
  ) async {
    try {
      //Uri url = Uri.parse('$_urlbase/$_api/loginstaff');
      Uri url = _buildUri("rejected");
      String bodyParams = json.encode({
        "idOrder": idOrder,
        "commentOrder": commentOrder,
      });
      print(url);
      final response = await http.post(
        url,
        headers: _headers,
        body: bodyParams,
      );
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        return ResponseApi.fromJson(data);
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        return ResponseApi(message: 'error:$emessage', success: false);
      }
    } catch (e) {
      print('e de autoriceOrder: $e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }
}
