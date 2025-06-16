import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/models/response_api.dart';
import 'package:h2o_admin_app/models/usersdata_models.dart';
import 'package:h2o_admin_app/providers/auth_provider.dart';
import 'package:h2o_admin_app/providers/users_provider.dart';
import 'package:h2o_admin_app/service/sharedPreferences/shared_preferences_service.dart';
import 'package:h2o_admin_app/service/user_service.dart';
import 'package:h2o_admin_app/providers/user_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginController {
  BuildContext? context;
  WidgetRef? ref;

  final TextEditingController txtcorreo = TextEditingController();
  final TextEditingController txtpassword = TextEditingController();
  final TextEditingController txttokenFB = TextEditingController();

  final UserService userService = UserService();
  // final SharedPreferencesService prefsService = SharedPreferencesService();

  void init(BuildContext context, WidgetRef ref) {
    this.context = context;
    this.ref = ref;
    userService.init(context);
  }

  Future<void> login(BuildContext context) async {
    String correo = txtcorreo.text.trim();
    String password = txtpassword.text.trim();

    if (correo.isEmpty || password.isEmpty) {
      EasyLoading.showToast("Email y contraseña son requeridos");
      return;
    }

    try {
      final String? tokenFB = await FirebaseMessaging.instance.getToken();

      ResponseApi responseApi = await userService.login(
        correo,
        password,
        tokenFB,
      );
      // Validación segun el idTypeUseer (Administrador o repartidor)
      if (responseApi.success) {
        UserData user = UserData.fromJson(responseApi.data);

        ref?.read(authProvider.notifier).state = true;
        ref?.read(usersProvider.notifier).login(user, user.tokeJW);

        if (context.mounted) {
          if (user.idTypeUser == 1) {
            context.goNamed('dashboard_screen');
          } else {
            context.goNamed('list_orders_screen');
          }
        }
      } else {
        EasyLoading.showToast(responseApi.message);
      }
    } catch (e) {
      EasyLoading.showToast("Error: $e");
    }
  }
}
