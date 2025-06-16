import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:h2o_admin_app/models/detailsOrders_model.dart';
import 'package:h2o_admin_app/service/autoriceOrder_service.dart';
import 'package:h2o_admin_app/service/cancelOrder_service.dart';
import 'package:h2o_admin_app/service/detailsOrders_service.dart';
import 'package:h2o_admin_app/service/orderDelivered_service.dart';
import 'package:h2o_admin_app/service/orderUnDelivered_service.dart';

class DetailsOrdersController {
  //final TextEditingController txtIdOrder = TextEditingController();
  BuildContext? context;
  // DetailsOrdersModel? detailsList; --modelo separado

  final TextEditingController txtIdorder = TextEditingController();
  final TextEditingController txtComment = TextEditingController();
  final TextEditingController txtStatusPago = TextEditingController();
  final TextEditingController txtIdUser = TextEditingController();

  // Getter para acceder a los detalles desde cualquier parte de la app
  // DetailsOrdersModel? get orderDetails => detailsList; --modelo separado

  // final DetailsordersService detailsordersService = DetailsordersService(); //--modelo separado
  final AutoriceOrderService autoriceOrderService = AutoriceOrderService();
  final CancelOrderService cancelOrderService = CancelOrderService();
  final OrderDeliveredService orderDeliveredService = OrderDeliveredService();
  final OrderUnDeliveredService orderUnDeliveredService =
      OrderUnDeliveredService();

  void init(BuildContext context) async {
    this.context = context;
    // detailsordersService.init(context); -- modelo separado
    autoriceOrderService.init(context);
  }

  //  01AUTORIZAR
  Future<void> autorice(BuildContext context) async {
    int idorder = int.parse(txtIdorder.text.trim());
    String comment = txtComment.text.trim();

    print(idorder);
    print(comment);
    try {
      ResponseApi responseApi = await autoriceOrderService.autoriceOrderService(
        idorder,
        comment,
      );
      if (responseApi.success) {
        //UserData user = UserData.fromJson(responseApi.data);
        // print("Datos a grabar: ${user.toJson()}");
        print('paso y se envio al service');
      } else {
        EasyLoading.showToast(
          responseApi.message,
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      }
    } catch (e) {
      EasyLoading.showToast(
        "$e",
        toastPosition: EasyLoadingToastPosition.center,
      );
    }
  }

  // 02RECHAZAR
  Future<void> cancel(BuildContext context) async {
    int idorder = int.parse(txtIdorder.text.trim());
    String comment = txtComment.text.trim();

    print(idorder);
    print(comment);
    try {
      ResponseApi responseApi = await cancelOrderService.cancelOrderService(
        idorder,
        comment,
      );
      if (responseApi.success) {
        //UserData user = UserData.fromJson(responseApi.data);
        // print("Datos a grabar: ${user.toJson()}");
        print('paso y se envio al service');
      } else {
        EasyLoading.showToast(
          responseApi.message,
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      }
    } catch (e) {
      EasyLoading.showToast(
        "$e",
        toastPosition: EasyLoadingToastPosition.center,
      );
    }
  }

  // 03ENTREGAR ORDEN
  Future<void> orderDeliveredController(
    BuildContext context,
    int statusPago,
    int idTypeUser,
  ) async {
    int idorder = int.parse(txtIdorder.text.trim());
    String comment = txtComment.text.trim();
    //int statusPago = int.parse(txtStatusPago.text.trim());
    // int iduser = int.parse(txtIdUser.text.trim());

    print(idorder);
    print(comment);
    print(statusPago);
    print(idTypeUser);
    try {
      ResponseApi responseApi = await orderDeliveredService
          .orderDeliveredService(idorder, comment, statusPago, idTypeUser);
      if (responseApi.success) {
        print('paso y se envio al service');
      } else {
        EasyLoading.showToast(
          responseApi.message,
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      }
    } catch (e) {
      EasyLoading.showToast(
        "$e",
        toastPosition: EasyLoadingToastPosition.center,
      );
    }
  }

  //04CANCELAR ORDEN
  Future<void> orderUnDeliveredController(
    BuildContext context,
    int statusPago,
    int idTypeUser,
  ) async {
    int idorder = int.parse(txtIdorder.text.trim());
    String comment = txtComment.text.trim();
    //int statusPago = int.parse(txtStatusPago.text.trim());
    // int iduser = int.parse(txtIdUser.text.trim());

    print(idorder);
    print(comment);
    print(statusPago);
    print(idTypeUser);
    try {
      ResponseApi responseApi = await orderUnDeliveredService
          .orderUnDeliveredService(idorder, comment, statusPago, idTypeUser);
      if (responseApi.success) {
        print('paso y se envio al service');
      } else {
        EasyLoading.showToast(
          responseApi.message,
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      }
    } catch (e) {
      EasyLoading.showToast(
        "$e",
        toastPosition: EasyLoadingToastPosition.center,
      );
    }
  }
}
