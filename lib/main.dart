import 'package:eau/utils/laravel_backend.dart';
import 'package:eau/pages/accueil.dart';
import 'package:eau/pages/authentification.dart';
import 'package:eau/pages/mainpage.dart';
import 'package:eau/pages/recharge.dart';
import 'package:flutter/material.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  LaravelBackend.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const Accueil(),
        "/authentification": (context) => const Authentification(
              indexPageActuel: 0,
            ),
        "/main": (context) => const MainPage(),
        "/recharge": (context) => RechargePage(),
      },
    );
  }
}
