import 'package:flutter/material.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_description_widget.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  String dropDownValue = 'Sin Stock';

  var items = [
    'Sin Stock',
    'Dirección no encontrada',
    'Deuda exedida',
    'Etc, etc...',
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    return Scaffold(
      appBar: const AppBarCustom(),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(thickness: 2, color: Color(0xFF34949C)),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Cancelar orden',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Divider(thickness: 2, color: Color(0xFF34949C)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 750.0,
                child: ListView(
                  children: [
                    Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15),
                            Text('Motivo de cancelación'),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              child: SizedBox(
                                height: 50,
                                width: 220,
                                child: Card(
                                  elevation: 4,
                                  child: DropdownButton<String>(
                                    // Valor inicial
                                    value: dropDownValue,
                                    // Icono de flecha hacia abajo
                                    // icon: const Icon(
                                    //   Icons.keyboard_arrow_down,
                                    // ),
                                    // Elementos del menú desplegable
                                    items:
                                        items.map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(item),
                                          );
                                        }).toList(),
                                    // Cambiar el valor al seleccionar un nuevo elemento
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropDownValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 15),
                            Text(
                              'Mensaje de cancelación',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        TextFormFieldDescriptionCustom(
                          controller: commentController,
                          //labelText: 'Mensaje de cancelación',
                        ),
                        const SizedBox(height: 30),
                        //---------------------
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 250,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xff08A5C0),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Aplicar cancelación'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
