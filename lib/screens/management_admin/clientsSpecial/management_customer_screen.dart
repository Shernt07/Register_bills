import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/providers/customer_provider.dart';
import 'package:h2o_admin_app/providers/deliverys_provider.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_distributor_custom.dart';

class ManagementCustomerScreen extends ConsumerWidget {
  static const String name = 'management_customer_screen';

  const ManagementCustomerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customerProvider);
    final notifier = ref.read(customerProvider.notifier);

    return Scaffold(
      appBar: const AppBarCustom(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF08A5C0),
                    endIndent: 10,
                  ),
                ),
                Text(
                  'Mis clientes',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                ),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    color: Color(0xFF08A5C0),
                    indent: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed("management_customerAdd_screen");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF08A5C0),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 32.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Agregar nuevo cliente',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await notifier.loadCustomer(),
                child: ListView.builder(
                  itemCount: customers.length,
                  itemBuilder: (context, index) {
                    final customer = customers[index];
                    return DistributorCardCustom(
                      distributorName: customer.nameCompleteClient,
                      imageUrl: customer.urlPhotoClient,
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomAlertDialog(
                                title: 'Borrar cliente',
                                subtitle:
                                    "Estas seguro que deseas borrar a ${customer.nameCompleteClient}",
                                onConfirm: () async {
                                  Navigator.of(context).pop();
                                  notifier.deleteCustomer(customer.idUser);
                                  await notifier.loadCustomer();
                                },
                                onCancel: () {},
                              ),
                        );
                      },
                      onEdit: () {
                        context.pushNamed(
                          'management_customerEdit_screen',
                          extra: customer.toJson(),
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
      bottomNavigationBar: const BottomNavigatorBarCustom(),
    );
  }
}
