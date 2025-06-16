// To parse this JSON data, do
//
//     final generateReportsModels = generateReportsModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GenerateReportsModels generateReportsModelsFromJson(String str) =>
    GenerateReportsModels.fromJson(json.decode(str));

String generateReportsModelsToJson(GenerateReportsModels data) =>
    json.encode(data.toJson());

class GenerateReportsModels {
  final int totalGeneral;
  final String fechaInicio;
  final String fechaFin;
  final String tipoIngreso;
  final String vistoBueno;
  final String realizo;
  final List<Dato> datos;

  GenerateReportsModels({
    required this.totalGeneral,
    required this.fechaInicio,
    required this.fechaFin,
    required this.tipoIngreso,
    required this.vistoBueno,
    required this.realizo,
    required this.datos,
  });

  factory GenerateReportsModels.fromJson(Map<String, dynamic> json) =>
      GenerateReportsModels(
        totalGeneral: json["totalGeneral"] ?? 0,
        fechaInicio: json["fechaInicio"] ?? '',
        fechaFin: json["fechaFin"] ?? '',
        tipoIngreso: json["tipoIngreso"] ?? '',
        vistoBueno: json["vistoBueno"] ?? '',
        realizo: json["realizo"] ?? '',
        datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "totalGeneral": totalGeneral,
    "fechaInicio": fechaInicio,
    "fechaFin": fechaFin,
    "tipoIngreso": tipoIngreso,
    "vistoBueno": vistoBueno,
    "realizo": realizo,
    "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
  };
}

class Dato {
  final String numeroItem;
  final String dateCreateOrder;
  final String dataSale;
  final String nameClient;
  final int folio;
  final int monto;

  Dato({
    required this.numeroItem,
    required this.dateCreateOrder,
    required this.dataSale,
    required this.nameClient,
    required this.folio,
    required this.monto,
  });

  factory Dato.fromJson(Map<String, dynamic> json) => Dato(
    numeroItem: json["numero_item"] ?? '',
    dateCreateOrder: json["dateCreateOrder"] ?? '',
    dataSale: json["dataSale"] ?? '',
    nameClient: json["nameClient"] ?? '',
    folio: json["folio"] ?? 0,
    monto: json["monto"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "numero_item": numeroItem,
    "dateCreateOrder": dateCreateOrder,
    "dataSale": dataSale,
    "nameClient": nameClient,
    "folio": folio,
    "monto": monto,
  };
}
