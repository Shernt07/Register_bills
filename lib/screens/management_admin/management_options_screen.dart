import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';

///
///
///
///
// ESTA SCREEN YA NO SE UTILIZA, SE MIGRO A LA CARPETA DE MYPROFILE
///
///
///
///
class ManagementOptionsScreen extends StatelessWidget {
  static const String name = 'management_options_screen';

  const ManagementOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
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
                  'Opciones de administración',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13.0),
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
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.people, color: Colors.black),
                    title: const Text('Administrar repartidores'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.goNamed('management_distributors_screen');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.bar_chart, color: Colors.black),
                    title: const Text('Generar reportes'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.goNamed('reportes_screen');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
