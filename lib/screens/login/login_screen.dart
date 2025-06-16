import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';
import 'package:h2o_admin_app/controllers/login_controller.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_password_custom.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String name = 'login_screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // bool _isChecked = false;
  final LoginController _loginController = LoginController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loginController.init(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Cierra el teclado al tocar fuera
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xAF08A5C0), Color(0xAF3CCCDC)],
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: [
                    const SizedBox(height: 60),
                    Image.asset('assets/img/logoh2o.png', height: 120),
                    const SizedBox(height: 10),
                    const Text(
                      'Linda Vista',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const Text(
                      'AGUA PURIFICADA',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 30,
                        ),
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Iniciar sesión',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff08A5C0),
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextFormFieldCustom(
                                labelText: 'Usuario',
                                icon: Icons.person,
                                controller: _loginController.txtcorreo,
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(height: 20),
                              TextFormFieldPasswordCustom(
                                labelText: 'Contraseña',
                                controller: _loginController.txtpassword,
                                keyboardType: TextInputType.visiblePassword,
                              ),
                              const SizedBox(height: 10),
                              Row(children: [
                               
                             
                                ],
                              ),
                              const SizedBox(height: 30),
                              Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 250,
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: const Color(0xff08A5C0),
                                    ),
                                    onPressed: () {
                                      _loginController.login(context);
                                    },
                                    child: const Text(
                                      'Ingresar',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
