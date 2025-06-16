import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:h2o_admin_app/api/enviroment.dart';
import 'package:h2o_admin_app/models/generateReports/generateReports_models.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:http/http.dart' as http;

class GenerateReportService {
  final String _urlbase = Enviroment.apiBase;
  final String _api = "reports";

  BuildContext? context;

  void init(BuildContext context) {
    this.context = context;
  }

  Map<String, String> get _headers => {'Content-Type': 'application/json'};

  Uri _buildUri(String endpoint) {
    return Uri.parse('$_urlbase/$_api/$endpoint');
  }

  // POST
  Future<GenerateReportsModels?> createReport(
    String fechaInicio,
    String fechaFin,
    int idTypePayment,
    int idStatusPayment,
  ) async {
    try {
      Uri url = _buildUri("salesbytypepayment");
      String bodyParams = json.encode({
        "fechaInicio": fechaInicio,
        "fechaFin": fechaFin,
        "idTypePayment": idTypePayment,
        "idStatusPayment": idStatusPayment,
      });

      final response = await http.post(
        url,
        headers: _headers,
        body: bodyParams,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final responseApi = ResponseApi.fromJson(data);

        if (responseApi.success) {
          if (responseApi.data != null) {
            //  Convertimos directamente un objeto JSON
            final report = GenerateReportsModels.fromJson(responseApi.data);
            return report;
          } else {
            print('Data vacía en responseApi-createReport');
            return null;
          }
        } else {
          print('Error desde el servidor-createReport: ${responseApi.message}');
          return null;
        }
      } else {
        final error = json.decode(response.body);
        String emessage = error["message"] ?? 'Error desconocido';
        print("Error service createReport: $emessage");
        return null;
      }
    } catch (e) {
      print('Exception en createReport: $e');
      return null;
    }
  }
}
