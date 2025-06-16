import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/providers/carousel_provider.dart';
import 'package:h2o_admin_app/service/categoriesService/createCategorie_service.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alertDialog_CategoryAdd_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alertDialog_CategoryEdit_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_news_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';
import 'package:h2o_admin_app/widgets/cards/card_categories_custom.dart';
import 'package:h2o_admin_app/providers/categories_provider.dart';
import 'package:h2o_admin_app/widgets/cards/card_news_custom.dart'; // Asegúrate que este import esté bien

class ManagementNewsScreen extends ConsumerWidget {
  static const String name = 'management_news_screen';

  const ManagementNewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carousel = ref.watch(carouselProvider);
    final notifier = ref.read(carouselProvider.notifier);

    return Scaffold(
      appBar: const AppBarCustom(),
      body: Padding(
        // padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
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
                  'Mis anuncios',
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
                    barrierDismissible:
                        false, //  evita que se cierre tocando fuera
                    builder:
                        (context) => CustomAlertDialogNews(
                          title: 'Agregar anuncio',
                          onConfirm: () async {
                            await notifier.loadCarousel();
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
                  'Agregar nuevo anuncio',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await notifier.loadCarousel(),
                child: ListView.builder(
                  itemCount: carousel.length,
                  itemBuilder: (context, index) {
                    final carusel = carousel[index];
                    return NewsCardCustom(
                      distributorName: "",
                      imageUrl: carusel.urlImg,
                      onDelete: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext contex) {
                            return CustomAlertDialog(
                              title: 'Borrar anuncio',
                              subtitle:
                                  '¿Estas seguro que deseas borrar el anuncio?',
                              onConfirm: () {
                                notifier.deleteImg(carusel.id);
                                //  notifier.updateCategory(name: category.nameCategorie, myFile: category.);

                                notifier.loadCarousel();
                                Navigator.of(context).pop();
                              },

                              //destination: '/listOrders',
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
