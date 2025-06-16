import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/service/categoriesService/createCategorie_service.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alertDialog_CategoryAdd_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alertDialog_CategoryEdit_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_categories_custom.dart';
import 'package:h2o_admin_app/providers/categories_provider.dart';

class ManagementCategoriesScreen extends ConsumerStatefulWidget {
  static const String name = 'management_categories_screen';

  const ManagementCategoriesScreen({super.key});

  @override
  ConsumerState<ManagementCategoriesScreen> createState() =>
      _ManagementCategoriesScreenState();
}

class _ManagementCategoriesScreenState
    extends ConsumerState<ManagementCategoriesScreen> {
  @override
  void initState() {
    super.initState();
    // cargar automáticamente las categorías cuando entres a la pantalla
    Future.microtask(
      () => ref.read(categoriesProvider.notifier).loadCategories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final notifier = ref.read(categoriesProvider.notifier);

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
                  'Mis categorías',
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
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (context) => CustomAlertDialogImg(
                          title: 'Agregar categoría',
                          onConfirm: () async {
                            await notifier.loadCategories();
                          },
                        ),
                  );
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
                  'Agregar nueva categoria',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await notifier.loadCategories(),
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoriesCardCustom(
                      distributorName: category.nameCategorie,
                      imageUrl: category.urlImage,
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              title: 'Borrar categoría',
                              subtitle:
                                  '¿Estas seguro que deseas borrar ${category.nameCategorie}?',
                              onConfirm: () async {
                                notifier.deleteCategory(category.idCategorie);
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      },
                      onEdit: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return CustomAlertDialogEdit(
                              title: "Editar categoría",
                              namedefault: category.nameCategorie,
                              urlImage: category.urlImage,
                              idCategorie: "${category.idCategorie}",
                              onConfirm: () async {
                                await notifier.loadCategories();
                              },
                            );
                          },
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
