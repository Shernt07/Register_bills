import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:h2o_admin_app/models/profile_models.dart';
import 'package:h2o_admin_app/api/enviroment.dart';

class ProfileService {
  BuildContext? context;
  final String _urlbase = Enviroment.apiBase;
  final String _api = "staff";

  void init(BuildContext context) {
    this.context = context;
  }

  // final String _url = Environment.baseUrl;
  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase/$_api/$endpoint');
  } //armar la base

  Uri _buildUriUpdate(String endpoint) {
    return Uri.parse('$_urlbase/$endpoint');
  } //armar la base

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<ProfileModel?> fetchProfile(int userId) async {
    try {
      Uri url = _buildUri("profile/$userId");
      print(url);
      final response = await http.get(url, headers: _headers);

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseApi = ResponseApi.fromJson(json.decode(response.body));

        if (responseApi.success == true && responseApi.data is Map) {
          ProfileModel profile = ProfileModel.fromJson(responseApi.data);
          return profile;
        } else {
          debugPrint('Error en respuesta: ${responseApi.message}');
          return null;
        }
      } else {
        debugPrint('Error HTTP ${response.statusCode}: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Error en fetchProfile: $e');
      return null;
    }
  }

  Future<bool> updateProfileImage(int userId, File imageFile) async {
    try {
      Uri url = _buildUriUpdate("upload/avatars");
      print(url);
      var request =
          http.MultipartRequest('POST', url)
            ..fields['idUser'] = userId.toString()
            ..files.add(
              await http.MultipartFile.fromPath('myFile', imageFile.path),
            );

      final response = await request.send();

      if (response.statusCode == 200) {
        return true;
      } else {
        debugPrint(
          'Error HTTP ${response.statusCode}: ${response.reasonPhrase}',
        );
        return false;
      }
    } catch (e) {
      debugPrint('Error al actualizar la imagen: $e');
      return false;
    }
  }
}
