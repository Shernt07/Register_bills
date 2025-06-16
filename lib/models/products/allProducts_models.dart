import 'package:meta/meta.dart';
import 'dart:convert';

List<AllProductsModels> allProductsModelsFromJson(String str) =>
    List<AllProductsModels>.from(
      json.decode(str).map((x) => AllProductsModels.fromJson(x)),
    );

String allProductsModelsToJson(List<AllProductsModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllProductsModels {
  final int idProduct;
  final int idCategorie;
  final String nameProduct;
  final String descriptionProduct;
  final String urlImage;
  final bool idStatusProduct;
  final List<Price> prices;

  AllProductsModels({
    required this.idProduct,
    required this.idCategorie,
    required this.nameProduct,
    required this.descriptionProduct,
    required this.urlImage,
    required this.idStatusProduct,
    required this.prices,
  });

  factory AllProductsModels.fromJson(Map<String, dynamic> json) =>
      AllProductsModels(
        idProduct: json["idProduct"],
        idCategorie: json["idCategorie"],
        nameProduct: json["nameProduct"] ?? '',
        descriptionProduct: json["descriptionProduct"] ?? '',
        urlImage: json["urlImage"] ?? '',
        idStatusProduct: json["idStatusProduct"],
        prices:
            json["prices"] != null
                ? List<Price>.from(json["prices"].map((x) => Price.fromJson(x)))
                : [], // Previene si "prices" es null
      );

  Map<String, dynamic> toJson() => {
    "idProduct": idProduct,
    "idCategorie": idCategorie,
    "nameProduct": nameProduct,
    "descriptionProduct": descriptionProduct,
    "urlImage": urlImage,
    "idStatusProduct": idStatusProduct,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
  };
}

class Price {
  final int idTypeUser;
  final String nameType;
  final int price;
  final bool idStatusPrice;

  Price({
    required this.idTypeUser,
    required this.nameType,
    required this.price,
    required this.idStatusPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    idTypeUser: json["idTypeUser"],
    nameType: json["nameType"] ?? '',
    price: json["price"],
    idStatusPrice: json["idStatusPrice"],
  );

  Map<String, dynamic> toJson() => {
    "idTypeUser": idTypeUser,
    "nameType": nameType,
    "price": price,
    "idStatusPrice": idStatusPrice,
  };
}
