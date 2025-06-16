import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class CarouselService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "carousel";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Map<String, String> get _headers => {
    //mandar encabezado para trabajar con json
    'Content-type': 'application/json',
  };

  Uri _buildUri() {
    return Uri.parse('$_urlbase/$_api');
  } //armar la base

  Uri buildUriImg() {
    return Uri.parse('$_urlbase/upload/carousel');
  } //armar la base

  Uri buildUriImgDelete(String id) {
    return Uri.parse('$_urlbase/carousel/$id');
  } //armar la base

  // SERVICE GETall
  Future<ResponseApi> allCarouselService() async {
    try {
      Uri url = _buildUri();
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

  //CREAR ANUNCIO
  Future<ResponseApi> createNewImg({required File myFile}) async {
    try {
      Uri url = buildUriImg();
      print(url);

      var request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath('myFile', myFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        return ResponseApi.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body);
        return ResponseApi(
          message: 'error: ${error["message"]}',
          success: false,
        );
      }
    } catch (e) {
      return ResponseApi(message: 'exception: $e', success: false);
    }
  }

  // Método DELETE para eliminar anuncio
  Future<ResponseApi> deleteNewImgService(int id) async {
    try {
      // Construir la URL para el endpoint de eliminación con el idImage
      Uri url = buildUriImgDelete("$id");
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
      print('Error en deleteAnuncioService: $e');
      return ResponseApi(message: 'Excepción: $e', success: false);
    }
  }
}
