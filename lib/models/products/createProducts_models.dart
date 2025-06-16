// To parse this JSON data, do
//
//     final createProductsModels = createProductsModelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreateProductsModels createProductsModelsFromJson(String str) =>
    CreateProductsModels.fromJson(json.decode(str));

String createProductsModelsToJson(CreateProductsModels data) =>
    json.encode(data.toJson());

class CreateProductsModels {
  final int idProduct;
  final String nameProduct;
  final String urlImg;
  final List<Price> prices;

  CreateProductsModels({
    required this.idProduct,
    required this.nameProduct,
    required this.urlImg,
    required this.prices,
  });

  factory CreateProductsModels.fromJson(Map<String, dynamic> json) =>
      CreateProductsModels(
        idProduct: json["idProduct"],
        nameProduct: json["nameProduct"],
        urlImg: json["urlImg"],
        prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "idProduct": idProduct,
    "nameProduct": nameProduct,
    "urlImg": urlImg,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
  };
}

class Price {
  final int idTypeUser;
  final String nameType;
  final int price;
  final int idStatusPrice;
  final int idProduct;

  Price({
    required this.idTypeUser,
    required this.nameType,
    required this.price,
    required this.idStatusPrice,
    required this.idProduct,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    idTypeUser: json["idTypeUser"],
    nameType: json["nameType"],
    price: json["price"],
    idStatusPrice: json["idStatusPrice"],
    idProduct: json["idProduct"],
  );

  Map<String, dynamic> toJson() => {
    "idTypeUser": idTypeUser,
    "nameType": nameType,
    "price": price,
    "idStatusPrice": idStatusPrice,
    "idProduct": idProduct,
  };
}
