import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class AllDeliveryService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "users";

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
  Future<ResponseApi> allDeliveryService() async {
    try {
      Uri url = _buildUri("deliverys");
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodificar el JSON recibido
        print('lo que recibe el service-allDelivery:  $data');
        return ResponseApi.fromJson(
          data,
        ); // Devolverlo como un objeto ResponseApi
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print("emessage de service-allDelivery: $emessage");
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('e de service-allDelivery: $e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }

  // SERVICE AGREGAR
  Future<ResponseApi> addDeliveryService(
    String nameUser,
    String password,
    String name,
    String lastName,
    String secondLastName,
    String telephone,
    String email,
    int idSex,
  ) async {
    try {
      Uri url = _buildUri("createDelivery");
      String bodyParams = json.encode({
        "nameUser": nameUser,
        "password": password,
        "name": name,
        "lastName": lastName,
        "secondLastName": secondLastName,
        "telephone": telephone,
        "email": email,
        "idSex": idSex,
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
        return ResponseApi(
          message: 'error service-delivery:$emessage',
          success: false,
        );
      }
    } catch (e) {
      print('e de service-delivery: $e');
      return ResponseApi(
        message: 'exepction service-delivery:$e',
        success: false,
      );
    }
  }

  // Método DELETE para eliminar
  Future<ResponseApi> deleteDeliveryService(int idDelivery) async {
    try {
      // Construir la URL para el endpoint de eliminación con el idCategorie
      Uri url = _buildUri(
        "delete/$idDelivery",
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
      print('Error en deleteDeliveryService: $e');
      return ResponseApi(message: 'Excepción: $e', success: false);
    }
  }

  // SERVICE Editar/actualizar
  Future<ResponseApi> updateDeliveryService(
    int idUser,
    String password,
    String name,
    String lastName,
    String secondLastName,
    String telephone,
    String email,
    int idSex,
  ) async {
    try {
      Uri url = _buildUri("updateDelivery");
      String bodyParams = json.encode({
        "idUser": idUser,
        "password": password,
        "name": name,
        "lastName": lastName,
        "secondLastName": secondLastName,
        "telephone": telephone,
        "email": email,
        "idSex": idSex,
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
        return ResponseApi(
          message: 'error service-delivery:$emessage',
          success: false,
        );
      }
    } catch (e) {
      print('e de service-delivery: $e');
      return ResponseApi(
        message: 'exepction service-delivery:$e',
        success: false,
      );
    }
  }
}
