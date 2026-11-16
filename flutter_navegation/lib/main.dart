import 'package:flutter/material.dart';
import 'package:flutter_navegation/config/router/app_router.dart';
import 'package:flutter_navegation/config/theme/app_theme.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Navegando_ando',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 4).getTheme(),
    );
  }
}