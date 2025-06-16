import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/providers/deliverys_provider.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_distributor_custom.dart';

class ManagementDistributorsScreen extends ConsumerWidget {
  static const String name = 'management_distributors_screen';

  const ManagementDistributorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final categories = ref.watch(categoriesProvider);
    // final notifier = ref.read(categoriesProvider.notifier);
    final deliverys = ref.watch(deliverysProvider);
    final notifier = ref.read(deliverysProvider.notifier);

    return Scaffold(
      appBar: const AppBarCustom(),
      body: Padding(
        //padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
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
                  'Mis repartidores',
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
                  context.pushNamed("management_distributorsAdd_screen");
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
                  'Agregar nuevo repartidor',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await notifier.loadDeliverys(),
                child: ListView.builder(
                  itemCount: deliverys.length,
                  itemBuilder: (context, index) {
                    final delivery = deliverys[index];
                    return DistributorCardCustom(
                      distributorName: delivery.nameCompleteClient,
                      imageUrl: delivery.urlPhotoStaff,
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomAlertDialog(
                                title: 'Borrar repartidor',
                                subtitle:
                                    "Estas seguro que deseas borrar a ${delivery.nameCompleteClient}",
                                onConfirm: () {
                                  //await notifier.loadCategories();
                                  Navigator.of(context).pop();
                                  notifier.deleteDelivery(delivery.idUser);
                                },
                                onCancel: () {},
                              ),
                        );
                      },
                      onEdit: () {
                        context.pushNamed(
                          'management_distributorsEdit_screen',
                          extra: delivery.toJson(),
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
