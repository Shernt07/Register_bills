import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_custom.dart';

// convertir tu StatelessWidget en un StatefulWidget
//(No acepta variables de estado)
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isChecked = false;

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
          //alignment: Alignment.center,
          children: [
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
                        'Registrate',
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
                      const TextFormFieldCustom(
                        labelText: 'Usuario',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      const TextFormFieldCustom(
                        labelText: 'Contraseña',
                        icon: Icons.remove_red_eye,
                      ),
                      const SizedBox(height: 20),
                      const TextFormFieldCustom(
                        labelText: 'Repetir contraseña',
                        icon: Icons.remove_red_eye,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 7),
                          Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                            visualDensity: VisualDensity.standard,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color:
                                    _isChecked
                                        ? const Color(0xff08A5C0)
                                        : Colors.grey,
                                width: 2,
                              ),
                            ),
                            fillColor: WidgetStateProperty.all(
                              _isChecked
                                  ? const Color(0xff08A5C0)
                                  : Colors.transparent,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 0.01),
                            child: const Text('Recordar'),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     TextButton(
                      //       style: const ButtonStyle(),
                      //       onPressed: () {},
                      //       child: const Text(
                      //         'Al registrarte aceptas nuestros Términos y Condiciones',
                      //         style: TextStyle(
                      //             color: Color.fromARGB(255, 0, 0, 0),
                      //             fontWeight: FontWeight.w200),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 18,
                      ), //Espacio entre "Recordar y ButtonIngresar"
                      //Boton de "Ingresar"
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
                            'Ingresar',
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
