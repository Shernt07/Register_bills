import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/orders_models.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class OrderService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "orders";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Map<String, String> get _headers => {'Content-Type': 'application/json'};
  // Creación del url.
  Uri buildUri(String endpoint) {
    return Uri.parse('$_urlbase/$_api/$endpoint'); //login
    //return Uri.https(_urlbase, '$_api/$endpoint');
  }

  Future<ResponseApi> order(String date, String status) async {
    try {
      Uri url = buildUri("listOrderDetail");
      //Uri url = Uri.parse('$_urlbase/$_api/listAdmin');
      String bodyParams = json.encode({"fecha": date, "estatus": status});
      print(url);
      final response = await http.post(
        url,
        headers: _headers,
        body: bodyParams,
      );
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseApi = ResponseApi.fromJson(data);

        if (responseApi.success && responseApi.data != null) {
          // Si data es una lista de pedidos
          if (responseApi.data is Map<String, dynamic>) {
            //List<dynamic> jsonList = responseApi.data;
            var dataMap = responseApi.data as Map<String, dynamic>;
            //Accedemos a orders con el dataMap
            var ordersList = dataMap['orders'];
            if (ordersList is List<dynamic>) {
              List<OrdersModel> orders =
                  ordersList
                      .map(
                        (item) =>
                            OrdersModel.fromJson(item as Map<String, dynamic>),
                      )
                      .toList();

              responseApi.data = orders; // Asignamos la lista de pedidos
              print('ordenes service: $orders');
            }
          } else {
            return ResponseApi(
              message: 'Formato de datos inválido.',
              success: false,
            );
          }
        }

        print(responseApi);
        return responseApi;
      } else {
        final error = json.decode(response.body);
        // modificación a string.
        String emessage = (error?["message"] ?? 'error desconocido').toString();
        return ResponseApi(message: 'error: $emessage', success: false);
      }
    } catch (e) {
      print('error service: $e');
      return ResponseApi(message: 'excepción: $e', success: false);
    }
  }
}
