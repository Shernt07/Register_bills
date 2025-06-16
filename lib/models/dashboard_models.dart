// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  final int? totalVentas;
  final int? deuda;
  final ProductosVendidos productosVendidos;
  final PedidosCliente pedidosCliente;

  DashboardModel({
    required this.totalVentas,
    required this.productosVendidos,
    required this.pedidosCliente,
    required this.deuda,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    totalVentas: json["totalVentas"] ?? 0,
    deuda: json["deuda"] ?? 0,
    productosVendidos: ProductosVendidos.fromJson(json["productosVendidos"]),
    pedidosCliente: PedidosCliente.fromJson(json["pedidosCliente"]),
  );

  Map<String, dynamic> toJson() => {
    "totalVentas": totalVentas,
    "deuda": deuda,
    "productosVendidos": productosVendidos.toJson(),
    "pedidosCliente": pedidosCliente.toJson(),
  };
}

class ProductosVendidos {
  final Map<String, int> productos;

  ProductosVendidos({required this.productos});

  factory ProductosVendidos.fromJson(Map<String, dynamic> json) {
    return ProductosVendidos(
      productos: Map<String, int>.from(
        json.map((key, value) => MapEntry(key, value as int)),
      ),
    );
  }

  Map<String, dynamic> toJson() => productos;

  Map<String, int> toMap() => productos;
}

class PedidosCliente {
  final Map<String, int> clientes;

  PedidosCliente({required this.clientes});

  factory PedidosCliente.fromJson(Map<String, dynamic> json) {
    return PedidosCliente(
      clientes: Map<String, int>.from(
        json.map((key, value) => MapEntry(key, value as int)),
      ),
    );
  }

  Map<String, dynamic> toJson() => clientes;

  Map<String, int> toMap() => clientes;
}
