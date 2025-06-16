// To parse this JSON data, do
//
//     final allCarouselModels = allCarouselModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AllCarouselModels> allCarouselModelsFromJson(String str) =>
    List<AllCarouselModels>.from(
      json.decode(str).map((x) => AllCarouselModels.fromJson(x)),
    );

String allCarouselModelsToJson(List<AllCarouselModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllCarouselModels {
  final int id;
  final String urlImg;

  AllCarouselModels({required this.id, required this.urlImg});

  factory AllCarouselModels.fromJson(Map<String, dynamic> json) =>
      AllCarouselModels(id: json["id"], urlImg: json["urlImg"]);

  Map<String, dynamic> toJson() => {"id": id, "urlImg": urlImg};
}
