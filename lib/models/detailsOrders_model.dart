





  // NO SE OCUPA POR QUE EN EL MODELO DE
  // ORDERS YA TRAEMOS TAMBIEN LOS DETALLES DE ORDEN









// // To parse this JSON data, do
// //
// //     final detailsOrdersModel = detailsOrdersModelFromJson(jsonString);

// import 'dart:convert';

// DetailsOrdersModel detailsOrdersModelFromJson(String str) =>
//     DetailsOrdersModel.fromJson(json.decode(str));

// String detailsOrdersModelToJson(DetailsOrdersModel data) =>
//     json.encode(data.toJson());

// class DetailsOrdersModel {
//   final int idOrder;
//   final int folio;
//   final String cliente;
//   final String fecha;
//   final String fechaEntrega;
//   final String nombreDireccion;
//   final String direccion;
//   final int total;
//   final String estadoPago;
//   final String comentario;
//   final String comentarioRepartidor;
//   final String comentarioAdministrador;
//   final List<Producto> productos;

//   DetailsOrdersModel({
//     required this.idOrder,
//     required this.folio,
//     required this.cliente,
//     required this.fecha,
//     required this.fechaEntrega,
//     required this.nombreDireccion,
//     required this.direccion,
//     required this.total,
//     required this.estadoPago,
//     required this.comentario,
//     required this.comentarioRepartidor,
//     required this.comentarioAdministrador,
//     required this.productos,
//   });

//   factory DetailsOrdersModel.fromJson(Map<String, dynamic> json) =>
//       DetailsOrdersModel(
//         idOrder: json["idOrder"],
//         folio: json["folio"],
//         cliente: json["cliente"],
//         fecha: json["fecha"],
//         fechaEntrega: json["fechaEntrega"],
//         nombreDireccion: json["nombreDireccion"],
//         direccion: json["direccion"],
//         total: json["total"],
//         estadoPago: json["estadoPago"],
//         comentario: json["comentario"],
//         comentarioRepartidor: json["comentarioRepartidor"] ?? '',
//         comentarioAdministrador: json["comentarioAdministrador"] ?? '',
//         productos: List<Producto>.from(
//           json["productos"].map((x) => Producto.fromJson(x)),
//         ),
//       );

//   Map<String, dynamic> toJson() => {
//     "idOrder": idOrder,
//     "folio": folio,
//     "cliente": cliente,
//     "fecha": fecha,
//     "fechaEntrega": fechaEntrega,
//     "nombreDireccion": nombreDireccion,
//     "direccion": direccion,
//     "total": total,
//     "estadoPago": estadoPago,
//     "comentario": comentario,
//     "productos": List<dynamic>.from(productos.map((x) => x.toJson())),
//   };
// }

// class Producto {
//   final String nombre;
//   final int cantidad;
//   final int precio;
//   final int subtotal;

//   Producto({
//     required this.nombre,
//     required this.cantidad,
//     required this.precio,
//     required this.subtotal,
//   });

//   factory Producto.fromJson(Map<String, dynamic> json) => Producto(
//     nombre: json["nombre"],
//     cantidad: json["cantidad"],
//     precio: json["precio"],
//     subtotal: json["subtotal"],
//   );

//   Map<String, dynamic> toJson() => {
//     "nombre": nombre,
//     "cantidad": cantidad,
//     "precio": precio,
//     "subtotal": subtotal,
//   };
// }
