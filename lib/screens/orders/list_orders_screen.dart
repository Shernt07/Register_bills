import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_order_custom.dart';
import 'package:h2o_admin_app/controllers/list_orders_controllers.dart';
import 'package:intl/intl.dart';

class ListOrdersScreen extends ConsumerStatefulWidget {
  static String name = 'list_orders_screen';

  const ListOrdersScreen({super.key});

  @override
  ConsumerState<ListOrdersScreen> createState() => ListOrdersScreenState();
}

class ListOrdersScreenState extends ConsumerState<ListOrdersScreen> {
  bool isloading = false;

  final Map<String, String> statusMap = {
    "Pendientes": "1",
    "Aceptada": '2',
    // "En camino": '3',
    "Entregados": '4',
    "Cancelados": '5',
    "Cancelado por cliente": '6',
    "No entregado": '7',
    "Adeudos": '8',
    "Todos": '0',
  };

  @override
  void initState() {
    super.initState();
    // Cargar automáticamente los pedidos con la fecha actual por defecto
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchOrders();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final orderController = ref.read(orderProvider.notifier);

    final initialDate = orderController.selectedDate ?? DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Llamar a fetchOrders automáticamente después de seleccionar la fecha
      orderController.setFilters(date: picked);
      await fetchOrders();
    }
  }

  Future<void> fetchOrders() async {
    setState(() => isloading = true);
    final orderController = ref.read(orderProvider.notifier);
    await orderController.ordersFetch(context);
    setState(() => isloading = false);
  }

  String getStatusKey(String value) {
    return statusMap.entries.firstWhere((entry) => entry.value == value).key;
  }

  @override
  Widget build(BuildContext context) {
    // intancio el provider para ser usado en la card
    final orders = ref.watch(orderProvider);
    final orderController = ref.read(orderProvider.notifier);

    final selectedStatusKey = getStatusKey(orderController.selectedStatus);
    final selectedDate = orderController.selectedDate;

    return Scaffold(
      appBar: const AppBarCustom(),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF08A5C0),
                    size: 18.0,
                  ),
                  label: Text(
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 13.0,
                    ),
                    selectedDate == null
                        ? 'Fecha'
                        : DateFormat('yyyy/MM/dd').format(selectedDate),
                  ),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),

                DropdownButton<String>(
                  value: selectedStatusKey,
                  items:
                      statusMap.keys.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                  onChanged: (String? newValue) async {
                    if (newValue != null) {
                      // Ejecutar automáticamente la recarga de pedidos
                      final newStatus = statusMap[newValue]!;
                      orderController.setFilters(status: newStatus);
                      await fetchOrders();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await fetchOrders(),
                child:
                    isloading
                        ? const Center(child: CircularProgressIndicator())
                        : orders.isEmpty
                        ? ListView(
                          // physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            SizedBox(
                              height: 300,
                            ), // para centrarlo un poco más abajo
                            Center(
                              child: Text(
                                'No hay pedidos disponibles',
                                // style: TextStyle(
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.w400,
                                //   color: Colors.grey,
                                // ),
                              ),
                            ),
                          ],
                        )
                        : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            final order = orders[index];
                            return CardOrderCustom(
                              clientName: order.nameComplete,
                              deliveryStatus: order.nameOrderStatus,
                              fechaPedido: order.dateOrder,
                              folio: "${order.idOrder}",
                              onDetailsPressed: () {
                                context.pushNamed(
                                  'details_order_screen',
                                  extra: order.toJson(),
                                );
                              },
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
