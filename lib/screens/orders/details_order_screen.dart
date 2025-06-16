import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/config/utils/date_formatter.dart';
import 'package:h2o_admin_app/controllers/detailsOrders_controller.dart';
import 'package:h2o_admin_app/providers/user_provider.dart';
import 'package:h2o_admin_app/providers/users_provider.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/dividerDetails/divider_details_widget.dart';
import 'package:h2o_admin_app/widgets/productDetails/product_details_widget.dart';
import 'package:h2o_admin_app/widgets/textFormField/text_form_field_description_widget.dart';

class DetailOrderScreen extends ConsumerStatefulWidget {
  static const String name = 'details_order_screen';

  final Map<String, dynamic> order;

  const DetailOrderScreen({super.key, required this.order});

  @override
  ConsumerState<DetailOrderScreen> createState() => _DetailOrderScreenState();
}

class _DetailOrderScreenState extends ConsumerState<DetailOrderScreen> {
  bool _isChecked = false;
  DetailsOrdersController detailsOrdersController =
      DetailsOrdersController(); //uso este por que aqui mando a usar los otros endpoint...
  final TextEditingController _commentController = TextEditingController();
  String _deliveryStatusMessage = '';

  @override
  void initState() {
    super.initState();
    detailsOrdersController.init(context);

    final int idOrder = widget.order['idOrder'];
    detailsOrdersController.txtIdorder.text = idOrder.toString();
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final productDetails = order['productDetails'] as List<dynamic>;

    return Scaffold(
      appBar: const AppBarCustom(),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Detalles pedido',
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
                height: 820,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        //CARD 1 SOLICUTUD ----------
                        Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DividerDetailsCustom(
                                iconPrincipal: Icons.list_alt,
                                titleCard: 'Solicitud',
                                folio: '#${order['idOrder'].toString()}',
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                // padding: EdgeInsets.only(left: 40, right: 30),
                                padding: EdgeInsets.symmetric(horizontal: 32),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cliente:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      order['nameComplete'] ??
                                          'Nombre no encontrado',
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Fecha de solicitud:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      DateFormatter.formatEleganteCards(
                                        order['dateOrder'],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      "Status de pedido:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      order['nameOrderStatus'] ?? 'Sin status',
                                    ),
                                    const SizedBox(height: 10),
                                    //  COMENTARIO DEL CLIENTE
                                    Text(
                                      "Comentario del cliente:",
                                      softWrap: true,
                                      maxLines: 5,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(order['commentOrder'] ?? ''),
                                    const SizedBox(height: 10),
                                    //  COMENTARIO DEL REPARTIDOR
                                    Text(
                                      "Comentario del repartidor:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(order['comentarioRepartidor'] ?? ''),
                                    const SizedBox(height: 10),
                                    //  COMENTARIO DEL ADMINISTRADOR
                                    Text(
                                      "Comentario administrador:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      order['comentarioAdministrador'] ?? '',
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // CARD 2------ DIRECCIÓN
                        Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Column(
                            children: [
                              DividerDetailsCustom(
                                iconPrincipal: Icons.map_outlined,
                                titleCard: 'Dirección',
                                folio: '',
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                // padding: EdgeInsets.only(left: 40, right: 30),
                                padding: EdgeInsets.symmetric(horizontal: 32),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(order['address'] ?? ''),
                                    const SizedBox(height: 15),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // CARD 3-- PRODUCTOS
                        Card(
                          color: Colors.white,
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DividerDetailsCustom(
                                iconPrincipal: Icons.grid_view,
                                titleCard: 'Productos',
                                folio: '',
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children:
                                    productDetails.map((product) {
                                      return ProductDetailsCustom(
                                        image: product['urlImage'],
                                        title: product['nameProduct'],
                                        amount: product['quantity'].toString(),
                                        price1:
                                            product['priceProduct'].toString(),
                                        price2: product['subtotal'].toString(),
                                      );
                                    }).toList(),
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 27),
                                  Text(
                                    'Monto total: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text('\$${order['total'].toString()}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: 27),
                                  Text(
                                    'Estado de pago: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(order['nameOrderStatus'.toString()]),
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        //  LEYENDA DE AGREGAR COMENTARIO
                        if (order['nameOrderStatus'] != 'entregado')
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 15),
                              Text('Agregar comentario'),
                            ],
                          ),
                        const SizedBox(height: 10),
                        if (order['nameOrderStatus'] !=
                            'entregado') // TEXTEDITING PARA AGREGAR COMENTARIO
                          TextFormFieldDescriptionCustom(
                            controller: _commentController,
                          ),
                        if (order['nameOrderStatus'] != 'entregado' ||
                            order['nameOrderStatus'] != 'cancelada por cliente')
                          const SizedBox(height: 15),
                        if (_deliveryStatusMessage.isNotEmpty)
                          if (order['nameOrderStatus'] == 'entregado' ||
                              order['nameOrderStatus'] !=
                                  'cancelada por cliente')
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                _deliveryStatusMessage,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                        Row(
                          // CHECKBOX
                          children: [
                            if ((order['nameOrderStatus'] == 'aceptada') ||
                                (order['estadoPago'] == 'Pendiente')) ...[
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                },
                              ),
                              const Text('¿El pedido fue cobrado?'),
                            ],
                          ],
                        ),
                        //Comentario por si ya esta entregado
                        if (order['nameOrderStatus'] == 'entregado')
                          SizedBox(
                            child: Text(
                              'Entregado',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff08A5C0),
                              ),
                            ),
                          ),

                        const SizedBox(height: 30),
                        /////////////////////////// BOTONES DE RECHAZAR, ACEPTAR, CANCELAR Y ENTREGAR /////////////////////////
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //RECHAZAR PEDIDO
                            if (order['nameOrderStatus'] != 'cancelada' &&
                                order['nameOrderStatus'] != 'aceptada' &&
                                order['nameOrderStatus'] != 'entregado' &&
                                order['nameOrderStatus'] !=
                                    'cancelada por cliente')
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext contex) {
                                      return CustomAlertDialog(
                                        title: 'Rechazar pedido',
                                        subtitle:
                                            '¿Estas seguro que deseas Rechazar el pedido?',
                                        onConfirm: () {
                                          detailsOrdersController
                                              .txtComment
                                              .text = _commentController.text;
                                          detailsOrdersController.cancel(
                                            context,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        destination: '/listOrders',
                                      );
                                    },
                                  );
                                },
                                child: const Text('Rechazar'),
                              ),

                            const SizedBox(width: 20),
                            //AUTORIZAR PEDIDO
                            if (order['nameOrderStatus'] != 'aceptada' &&
                                order['nameOrderStatus'] != 'entregado' &&
                                order['nameOrderStatus'] !=
                                    'cancelada por cliente')
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext contex) {
                                      return CustomAlertDialog(
                                        title: 'Autorizar pedido',
                                        subtitle:
                                            '¿Estas seguro que deseas aceptar el pedido?',
                                        onConfirm: () {
                                          detailsOrdersController
                                              .txtComment
                                              .text = _commentController.text;
                                          detailsOrdersController.autorice(
                                            context,
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        destination: '/listOrders',
                                      );
                                    },
                                  );
                                },
                                child: const Text('Autorizar'),
                              ),
                            // CANCELAR PEDIDO
                            //debe ser en camino.
                            if (order['nameOrderStatus'] == 'aceptada')
                              ElevatedButton(
                                onPressed: () {
                                  int valueToSend =
                                      _isChecked
                                          ? 1
                                          : 0; // Si el checkbox está marcado, pasa 2, sino 1.
                                  // 2 == pagado | 1 == pediente
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext contex) {
                                      return CustomAlertDialog(
                                        title: 'Cancelar pedido',
                                        subtitle:
                                            '¿Estas seguro que deseas cancelar el pedido?',
                                        onConfirm: () {
                                          detailsOrdersController
                                              .txtComment
                                              .text = _commentController.text;
                                          // Le pasamos el idtyUser desde el provider
                                          final user = ref.read(userProvider);
                                          final idTypeUser =
                                              user?.idTypeUser ?? 0;
                                          //metodo del controlador
                                          detailsOrdersController
                                              .orderUnDeliveredController(
                                                context,
                                                valueToSend,
                                                idTypeUser,
                                              );
                                          setState(() {
                                            _deliveryStatusMessage =
                                                _isChecked
                                                    ? 'El pedido fue cobrado.'
                                                    : 'El pedido fue entregado sin cobrar.';
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        destination: '/listOrders',
                                      );
                                    },
                                  );
                                },
                                child: const Text('Cancelar'),
                              ),

                            const SizedBox(width: 20),

                            // ENTREGAR PEDIDO
                            if ((order['nameOrderStatus']
                                        ?.toLowerCase()
                                        .trim() ==
                                    'aceptada') ||
                                ((order['nameOrderStatus']
                                            ?.toLowerCase()
                                            .trim() ==
                                        'entregado') &&
                                    (order['estadoPago']
                                            ?.toLowerCase()
                                            .trim() ==
                                        'pendiente')))
                              ElevatedButton(
                                onPressed: () {
                                  int valueToSend =
                                      _isChecked
                                          ? 1
                                          : 0; // Si el checkbox está marcado, pasa 2, sino 1.
                                  // 2 == pagado | 1 == pediente

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext contex) {
                                      return CustomAlertDialog(
                                        title: 'Entregar pedido',
                                        subtitle:
                                            '¿Estas seguro que deseas entregar el pedido?',
                                        onConfirm: () {
                                          detailsOrdersController
                                              .txtComment
                                              .text = _commentController.text;
                                          // Le pasamos el idtyUser desde el provider
                                          final user = ref.read(usersProvider);
                                          // final idTypeUser =
                                          //     user?.idTypeUser ?? 0;
                                          //metodo del controlador
                                          detailsOrdersController
                                              .orderDeliveredController(
                                                context,
                                                valueToSend,
                                                // idTypeUser,
                                                user!.idUser,
                                              );
                                          setState(() {
                                            _deliveryStatusMessage =
                                                _isChecked
                                                    ? 'El pedido fue cobrado.'
                                                    : 'El pedido fue entregado sin cobrar.';
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        destination: '/listOrders',
                                      );
                                    },
                                  );
                                },
                                child: const Text('Entregar'),
                              ),
                          ],
                        ),
                        /////////////////////////// FIN DE BOTONES DE RECHAZAR, ACEPTAR, CANCELAR Y ENTREGAR /////////////////////////
                      ],
                    ),
                    const SizedBox(height: 150),
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
