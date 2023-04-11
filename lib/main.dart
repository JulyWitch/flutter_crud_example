import 'package:flutter/material.dart';
import 'package:mc_crud_test/common/theme/default.dart';
import 'package:mc_crud_test/customer/routes.dart';


void main() {
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
