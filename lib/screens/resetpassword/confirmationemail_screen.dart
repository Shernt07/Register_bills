import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';

// convertir tu StatelessWidget en un StatefulWidget
//(No acepta variables de estado)
class ConfirmationEmailPassword extends StatefulWidget {
  const ConfirmationEmailPassword({super.key});

  @override
  State<ConfirmationEmailPassword> createState() =>
      _ConfirmationEmailPasswordState();
}

class _ConfirmationEmailPasswordState extends State<ConfirmationEmailPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          //decoration para el degradado...
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color.fromRGBO(8, 165, 192, 80),
              Color.fromRGBO(60, 204, 220, 80),
            ],
          ),
        ),
        child: Stack(
          children: [
            //logo
            Column(
              children: [
                const SizedBox(height: 100, width: 1000),
                Image.asset(
                  // height: 150,
                  // width: 150,
                  'assets/img/logoh2o.png',
                ),
                const Text(
                  'Linda Vista',
                  style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),
                ),
                const Text(
                  'AGUA PURIFICADA',
                  style: TextStyle(color: Color(0xffFFFFFF), fontSize: 10),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  constraints: const BoxConstraints.tightFor(
                    height: 600,
                    width: double.infinity,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Cambio de contraseña',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff08A5C0),
                        ),
                      ),
                      const SizedBox(
                        // Dar el espacio
                        height: 40,
                      ),
                      const Row(
                        children: [
                          SizedBox(width: 25),
                          Text(
                            'Ingresa el código enviado al correo porporcionado',
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const TextFormFieldCustom(
                        labelText: 'Código ',
                        icon: Icons.password,
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: 250,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xff08A5C0),
                          ),
                          onPressed: () {
                            context.goNamed('list_orders_screen');
                          },
                          child: const Text(
                            'Verificar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('¿Ya tienes cuenta?'),
                          TextButton(
                            onPressed: () {
                              context.goNamed('login_screen');
                            },
                            child: const Text(
                              style: TextStyle(color: Color(0xff08A5C0)),
                              'Inicia sesión',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextButton(
                          onPressed: () {
                            context.goNamed('resetpassword_screen');
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xff08A5C0),
                                size: 17,
                              ),
                              Text(
                                'Regresar',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff08A5C0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
