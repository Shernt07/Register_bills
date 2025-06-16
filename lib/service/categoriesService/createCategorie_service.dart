import 'dart:io';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateCategorieService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "/upload";

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase$_api/$endpoint');
  }

  Future<ResponseApi> createCategorie({
    required String name,
    required File myFile,
  }) async {
    try {
      Uri url = _buildUri("categories");
      print(url);

      var request = http.MultipartRequest('POST', url);
      request.fields['name'] = name;
      request.files.add(
        await http.MultipartFile.fromPath('myFile', myFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
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
}
