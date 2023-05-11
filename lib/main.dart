import 'package:flutter/material.dart';
import 'package:customer_management/common/theme/default.dart';
import 'package:customer_management/injections.dart';
import 'package:customer_management/presentation/routes.dart';

Future<void> main() async {
  runApp(const SplashApp());

  await ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Customer Manager',
      routerConfig: Routes.router,
      theme: defaultThemeData,
    );
  }
}

class SplashApp extends StatelessWidget {
  const SplashApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Manager',
      theme: defaultThemeData,
      home: const Scaffold(
        body: Center(
          child: FlutterLogo(
            size: 120,
          ),
        ),
      ),
    );
  }
}
