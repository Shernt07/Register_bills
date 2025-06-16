import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:h2o_admin_app/providers/user_provider.dart';
import 'package:h2o_admin_app/providers/users_provider.dart';

class BottomNavigatorBarCustom extends ConsumerWidget {
  const BottomNavigatorBarCustom({super.key});

  int getCurrentIndex(String location, List<BottomNavigationBarItem> items) {
    switch (location) {
      case '/dashboard':
        return items.indexWhere((item) => item.label == 'Inicio');
      case '/listOrders':
        return items.indexWhere((item) => item.label == 'Pedidos');
      case '/reportes':
        return items.indexWhere((item) => item.label == 'Reportes');
      case '/myprofile':
        return items.indexWhere((item) => item.label == 'Perfil');
      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index, List<String> routes) {
    final route = routes[index];
    switch (route) {
      case 'dashboard_screen':
        context.pushNamed('dashboard_screen');
        break;
      case 'list_orders_screen':
        context.pushNamed('list_orders_screen');
        break;
      case 'reportes_screen':
        context.pushNamed('reportes_screen');
        break;
      case 'my_profile_screen':
        context.pushNamed('my_profile_screen');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(usersProvider);
    final idTypeUser = user?.idTypeUser;

    final items = <BottomNavigationBarItem>[
      if (idTypeUser != 2)
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.list_alt_outlined),
        label: 'Pedidos',
      ),
      if (idTypeUser != 2)
        const BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart_outlined),
          label: 'Reportes',
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_circle_outlined),
        label: 'Perfil',
      ),
    ];

    final routes = <String>[
      if (idTypeUser != 2) 'dashboard_screen',
      'list_orders_screen',
      if (idTypeUser != 2) 'reportes_screen',
      'my_profile_screen',
    ];

    final location = GoRouterState.of(context).uri.toString();
    int currentIndex = getCurrentIndex(location, items);

    if (currentIndex == -1 || currentIndex >= items.length) {
      currentIndex = 0;
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => onItemTapped(context, index, routes),
      items: items,
      selectedItemColor: const Color(0xFF08A5C0),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}
