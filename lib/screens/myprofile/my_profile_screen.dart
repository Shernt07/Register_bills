import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/providers/profile_provider.dart';
import 'package:h2o_admin_app/providers/users_provider.dart';
import 'package:h2o_admin_app/widgets/alertDialog/alert_dialog_custom.dart';
import 'package:h2o_admin_app/widgets/appBar/app_bar_widget.dart';
import 'package:h2o_admin_app/widgets/bottomNavigatorBar/bottom_navigator_bar_widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static const String name = 'profile_screen';
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(usersProvider);
      if (user == null) {
        context.goNamed('login_screen');
      } else {
        ref.read(profileProvider.notifier).loadProfile(user.idUser);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final user = ref.watch(usersProvider);
    final idTypeUser = user?.idTypeUser;

    if (profileState.error.isNotEmpty) {
      return Center(child: Text(profileState.error));
    }

    final profile = profileState.profile;

    return Scaffold(
      appBar: const AppBarCustom(),
      bottomNavigationBar: const BottomNavigatorBarCustom(),
      backgroundColor: const Color(0xFFF0F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                profile?.urlImg ?? 'assets/img/profile_image.png',
              ),
            ),
            const SizedBox(height: 10),
            Text(
              profile?.name ?? 'Cargando...',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.black),
                    title: const Text('Mis Datos'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.pushNamed('my_information_screen');
                    },
                  ),

                  // Estas opciones solo para admin (idTypeUser != 2)
                  if (idTypeUser != 2) ...[
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.people_alt_outlined,
                        color: Colors.black,
                      ),
                      title: const Text('Administrar repartidores'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.pushNamed('management_distributors_screen');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.nature_people_outlined,
                        color: Colors.black,
                      ),
                      title: const Text('Administrar clientes especiales'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.pushNamed('management_customer_screen');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.view_cozy_outlined,
                        color: Colors.black,
                      ),
                      title: const Text('Administrar categorías'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.pushNamed('management_categories_screen');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.interests_outlined,
                        color: Colors.black,
                      ),
                      title: const Text('Administrar productos'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.pushNamed('management_products_screen');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.insert_comment_outlined,
                        color: Colors.black,
                      ),
                      title: const Text('Sugerencias de clientes'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.pushNamed('management_suggestions_screen');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.new_label_outlined,
                        color: Colors.black,
                      ),
                      title: const Text('Anuncios'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.pushNamed('management_news_screen');
                      },
                    ),
                  ],

                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.help_outline,
                      color: Colors.black,
                    ),
                    title: const Text('Ayuda'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext contex) {
                          return CustomAlertDialog(
                            title: 'Cerrar sesión',
                            subtitle: '¿Estás seguro de cerrar sesión?',
                            onConfirm: () async {
                              Navigator.of(context).pop();
                              await ref
                                  .read(usersProvider.notifier)
                                  .logout(ref);
                              if (context.mounted) {
                                context.goNamed('login_screen');
                              }
                            },
                            onCancel: () {},
                            destination: '/login',
                          );
                        },
                      );
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

// // // //com.ulv.h2oadminapp
// // // //package com.ulv.h2oadminapp-admin-app
