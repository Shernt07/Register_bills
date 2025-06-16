import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:h2o_admin_app/models/orders_models.dart';
import 'package:h2o_admin_app/service/order_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final orderProvider = StateNotifierProvider<OrderController, List<OrdersModel>>(
  (ref) {
    return OrderController();
  },
);

class OrderController extends StateNotifier<List<OrdersModel>> {
  OrderController() : super([]) {
    final now = DateTime.now();
    selectedDate = now;
    txtdate.text = DateFormat('yyyy-MM-dd').format(now);
  }

  final TextEditingController txtdate = TextEditingController();
  final TextEditingController txtstatus = TextEditingController();
  // Nueva propiedad para el estado de carga
  bool isLoading = false;
  final OrderService orderService = OrderService();

  DateTime? selectedDate;
  String selectedStatus = '1'; // "Pendientes" por defecto

  void setFilters({DateTime? date, String? status}) {
    if (date != null) {
      selectedDate = date;
      txtdate.text = DateFormat('yyyy-MM-dd').format(date);
    }

    if (status != null) {
      selectedStatus = status;
      txtstatus.text = status;
    }
  }

  Future<void> ordersFetch(BuildContext context) async {
    state = []; // Limpia la lista actual
    isLoading = true;

    final date =
        txtdate.text.trim().isEmpty
            ? DateFormat('yyyy-MM-dd').format(DateTime.now())
            : txtdate.text.trim();
    final status =
        txtstatus.text.trim().isEmpty ? selectedStatus : txtstatus.text.trim();

    try {
      ResponseApi responseApi = await orderService.order(date, status);

      if (responseApi.success) {
        state = responseApi.data as List<OrdersModel>;
      } else {
        // COMENTADO PARA QUE NO APAREZCA EN LA APP Y CORTE EL FLUJO DE UX
        // EasyLoading.showToast(
        //   responseApi.message,
        //   toastPosition: EasyLoadingToastPosition.center,
        // );
      }
    } catch (e) {
      EasyLoading.showToast(
        "Error al cargar pedidos: $e",
        toastPosition: EasyLoadingToastPosition.center,
      );
    } finally {
      isLoading = false;
    }
  }
}
