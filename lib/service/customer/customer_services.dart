import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class AllCustomerService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "client";

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

  Uri _buildUriType() {
    return Uri.parse('$_urlbase/catalog/clientCustom');
  } //armar la base

  Uri _buildUriDelete(String endpoint) {
    return Uri.parse('$_urlbase/users/delete/$endpoint');
  } //armar la base

  // SERVICE GETALL
  Future<ResponseApi> allCustomerService() async {
    try {
      Uri url = _buildUri("custom");
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodificar el JSON recibido
        print('lo que recibe el service-allCustomer:  $data');
        return ResponseApi.fromJson(
          data,
        ); // Devolverlo como un objeto ResponseApi
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print("emessage de service-allCustomer: $emessage");
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('e de service-allCustomer: $e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }

  // SERVICE GET_TYPE_CUSTOMER
  Future<ResponseApi> allTypeCustomerService() async {
    try {
      Uri url = _buildUriType();
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decodificar el JSON recibido
        print('lo que recibe el service-allTypeCustomer:  $data');
        return ResponseApi.fromJson(
          data,
        ); // Devolverlo como un objeto ResponseApi
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        print("emessage de service-allTypeCustomer: $emessage");
        return ResponseApi(message: 'Error: $emessage', success: false);
      }
    } catch (e) {
      print('e de service-allTypeCustomer: $e');
      return ResponseApi(message: 'exepction:$e', success: false);
    }
  }

  // SERVICE AGREGAR
  Future<ResponseApi> addCustomerService(
    String nameUser,
    String password,
    int idType,
    String name,
    String lastName,
    String secondLastName,
    String telephone,
    String fechaNacimiento,
    int idSex,
    String email,
  ) async {
    try {
      Uri url = _buildUri("custom");
      String bodyParams = json.encode({
        "nameUser": nameUser,
        "password": password,
        "idType": idType,
        "nombre": name,
        "apellidoPaterno": lastName,
        "apellidoMaterno": secondLastName,
        "telefono": telephone,
        "fechaNacimiento": fechaNacimiento,
        "idSex": idSex,
        "email": email,
      });
      print(url);
      final response = await http.post(
        url,
        headers: _headers,
        body: bodyParams,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseApi.fromJson(data);
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        return ResponseApi(
          message: 'error service-customer:$emessage',
          success: false,
        );
      }
    } catch (e) {
      print('e de service-customer: $e');
      return ResponseApi(
        message: 'exepction service-customer:$e',
        success: false,
      );
    }
  }

  // Método DELETE para eliminar
  Future<ResponseApi> deleteCustomerService(int idCustomer) async {
    try {
      // Construir la URL para el endpoint de eliminación con el idCategorie
      Uri url = _buildUriDelete(
        "$idCustomer",
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
      print('Error en deleteCustomerService: $e');
      return ResponseApi(message: 'Excepción: $e', success: false);
    }
  }

  // SERVICE Editar/actualizar
  Future<ResponseApi> updateCustomerService(
    int idUser,
    String password,
    String name,
    String lastName,
    String secondLastName,
    String telephone,
    String fechaNacimiento,
    int idSex,
    String email,
  ) async {
    try {
      Uri url = _buildUri("updateCustom");
      String bodyParams = json.encode({
        "idUser": idUser,
        "password": password,
        "nombre": name,
        "apellidoPaterno": lastName,
        "apellidoMaterno": secondLastName,
        "telefono": telephone,
        "fechaNacimiento": fechaNacimiento,
        "idSex": idSex,
        "email": email,
      });
      print(url);
      final response = await http.post(
        url,
        headers: _headers,
        body: bodyParams,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ResponseApi.fromJson(data);
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'error desconocido';
        return ResponseApi(
          message: 'error service-customerUpdate:$emessage',
          success: false,
        );
      }
    } catch (e) {
      print('e de service-customerUpdate: $e');
      return ResponseApi(
        message: 'exepction service-customerUpdate:$e',
        success: false,
      );
    }
  }
}
