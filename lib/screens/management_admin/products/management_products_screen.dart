import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/providers/products_provider.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_categories_custom.dart';

class ManagementProductsScreen extends ConsumerStatefulWidget {
  static const String name = 'management_products_screen';

  const ManagementProductsScreen({super.key});

  @override
  ConsumerState<ManagementProductsScreen> createState() =>
      _ManagementProductsScreenState();
}

class _ManagementProductsScreenState
    extends ConsumerState<ManagementProductsScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar productos al entrar a la pantalla
    Future.microtask(() => ref.read(productsProvider.notifier).loadProducts());
    //ref.read(productsProvider.notifier).loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final notifier = ref.read(productsProvider.notifier);

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
                  'Mis productos',
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
                  final formControllers = ref.read(productsFormProvider);
                  formControllers.clear(); // Limpias los campos
                  context.pushNamed("management_productsAdd_screen");
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
                  'Agregar nuevo producto',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await notifier.loadProducts(),
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return CategoriesCardCustom(
                      distributorName: product.nameProduct,
                      imageUrl: product.urlImage,
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => CustomAlertDialog(
                                title: 'Borrar producto',
                                subtitle:
                                    "¿Estas seguro que deseas borrar ${product.nameProduct}?",
                                onConfirm: () async {
                                  notifier.deleteProduct(product.idProduct);
                                  Navigator.of(context).pop();
                                  await notifier.loadProducts();
                                },
                                onCancel: () {},
                              ),
                        );
                      },
                      onEdit: () {
                        context.pushNamed(
                          'management_productsEdit_screen',
                          extra: product.toJson(),
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
