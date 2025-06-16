import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  final int idOrder;
  final String nameComplete;
  final String nameOrderStatus;
  final String estadoPago;
  final String? commentOrder;
  final String? comentarioRepartidor;
  final String? comentarioAdministrador;
  final String dateOrder;
  final String address; //
  final int total; //
  List<ProductDetails> productDetails;

  OrdersModel({
    required this.idOrder,
    required this.nameComplete,
    required this.estadoPago,
    required this.nameOrderStatus,
    required this.dateOrder,
    required this.address,
    required this.total,
    required this.productDetails,
    required this.commentOrder,
    required this.comentarioRepartidor,
    required this.comentarioAdministrador,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    idOrder: json["idOrder"] ?? 0,
    nameComplete: json["nameComplete"] ?? '',
    estadoPago: json["estadoPago"] ?? '',
    nameOrderStatus: json["nameOrderStatus"] ?? '',
    commentOrder: json["commentOrder"] ?? '',
    comentarioRepartidor: json["comentarioRepartidor"] ?? '',
    comentarioAdministrador: json["comentarioAdministrador"] ?? '',
    dateOrder: json["dateOrder"] ?? '',
    address: json["address"] ?? '', // <-- Nuevo mapeo
    total: json["total"] ?? 0, // <-- Nuevo mapeo
    productDetails:
        json["productDetails"] == null
            ? []
            : List<ProductDetails>.from(
              json["productDetails"].map((x) => ProductDetails.fromJson(x)),
            ), // Cambiado para que maneje null y mapee correctamente.
  );

  Map<String, dynamic> toJson() => {
    "idOrder": idOrder,
    "nameComplete": nameComplete,
    "estadoPago": estadoPago,
    "nameOrderStatus": nameOrderStatus,
    "commentOrder": commentOrder,
    "comentarioRepartidor": comentarioRepartidor,
    "comentarioAdministrador": comentarioAdministrador,
    "dateOrder": dateOrder,
    "address": address, //
    "total": total, //
    "productDetails": List<dynamic>.from(productDetails.map((x) => x.toJson())),
  };
}

class ProductDetails {
  final String nameProduct;
  final String urlImage;
  final int quantity;
  final int priceProduct;
  final int subtotal;

  ProductDetails({
    required this.nameProduct,
    required this.urlImage,
    required this.quantity,
    required this.priceProduct,
    required this.subtotal,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    nameProduct: json["nameProduct"] ?? '',
    urlImage: json["urlImage"] ?? '',
    quantity: json["quantity"] ?? 0,
    priceProduct: json["priceProduct"] ?? 0,
    subtotal: json["subtotal"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "nameProduct": nameProduct,
    "urlImage": urlImage,
    "quantity": quantity,
    "priceProduct": priceProduct,
    "subtotal": subtotal,
  };
}
