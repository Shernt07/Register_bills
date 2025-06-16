import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router/app_router.dart';
import 'package:h2o_admin_app/config/themes/app_theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:h2o_admin_app/service/sharedPreferences/shared_preferences_service.dart';
import 'package:h2o_admin_app/providers/users_provider.dart';
import 'package:h2o_admin_app/providers/auth_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final container = ProviderContainer();
  final prefs = SharedPreferencesService();

  final token = await prefs.getToken();
  final user = await prefs.getUser();

  if (token != null && !JwtDecoder.isExpired(token) && user != null) {
    container.read(usersProvider.notifier).state =
        user; //inicializar el provider con los datos del sharedPreferences
    container.read(authProvider.notifier).state = true;
  }

  // Carga la sesión guardada si existe
  await container.read(usersProvider.notifier).loadUserFromPrefs();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: ProviderScope(child: MyApp()),
    ),
  );
  // runApp(ProviderScope(child: MyApp()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.white
    //..maskColor = Colors.blue.withOpacity(0.5)
    //..maskColor = Colors.blue
    ..userInteractions = false
    ..dismissOnTap = false; // Para que no desaparezca al tocar
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'H2O Admin', //Material App
      builder: EasyLoading.init(),
      theme: AppTheme(selectedColor: 0).theme(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'), // Forzar idioma español
      supportedLocales: const [Locale('es'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
