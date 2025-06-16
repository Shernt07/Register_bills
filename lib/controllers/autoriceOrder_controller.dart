import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:h2o_admin_app/service/autoriceOrder_service.dart';

class AutoriceOrderController {
  BuildContext? context;

  final TextEditingController txtIdorder = TextEditingController();
  final TextEditingController txtComment = TextEditingController();

  final AutoriceOrderService autoriceOrderService = AutoriceOrderService();

  void init(BuildContext context) async {
    this.context = context;
    autoriceOrderService.init(context);
  }

  void autorice(BuildContext context) async {
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
}
