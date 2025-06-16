import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:h2o_admin_app/providers/users_provider.dart';
import 'package:lottie/lottie.dart';

class AnimatedIntroScreen extends ConsumerStatefulWidget {
  static const String name = 'intro_screen';
  const AnimatedIntroScreen({super.key});

  @override
  ConsumerState<AnimatedIntroScreen> createState() =>
      _AnimatedIntroScreenState();
}

class _AnimatedIntroScreenState extends ConsumerState<AnimatedIntroScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final userNotifier = ref.read(usersProvider.notifier);

    // Cargar usuario desde SharedPreferences
    await userNotifier.loadUserFromPrefs();
    final user = ref.read(usersProvider);

    // Espera opcional para mostrar intro (editable al gusto)
    await Future.delayed(const Duration(seconds: 2));

    // validación de si ya esta logueado lo redigue, de lo contrario manda la login
    if (mounted) {
      if (user != null && user.idTypeUser != null) {
        if (user.idTypeUser == 1) {
          context.goNamed('dashboard_screen'); // Admin
        } else {
          context.goNamed('list_orders_screen'); // Repartidor
        }
      } else {
        context.goNamed('login_screen'); // No hay sesión guardada
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 250),
          const Text(
            'Bienvenido a tu aplicación',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Agua Linda Vista',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff08A5C0),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'ADMIN',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff08A5C0),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Lottie.asset(
              'assets/intro.json',
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
