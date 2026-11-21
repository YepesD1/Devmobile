import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:app_form/main.dart';
import 'package:app_form/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:app_form/presentation/screen/login/login_screen.dart';

void main() {
  testWidgets('Login es la primera vista de la aplicación', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Correo electrónico'), findsOneWidget);
  });

  testWidgets('Login valida los campos con FormController', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: LoginScreen()),
    );

    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresa tu correo electrónico'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña'), findsOneWidget);
    expect(find.text('Formulario enviado'), findsNothing);
  });

  testWidgets('Login acepta un usuario registrado en el mapa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(
          initialLocation: '/login',
          routes: [
            GoRoute(
              path: '/login',
              builder: (context, state) => const LoginScreen(),
            ),
            GoRoute(
              path: '/dashboard',
              builder: (context, state) {
                final user = state.extra! as Map<String, String>;
                return DashboardScreen(
                  email: user['email']!,
                  name: user['name']!,
                );
              },
            ),
          ],
        ),
      ),
    );

    await tester.enterText(
      find.byType(TextFormField).first,
      'alejandro@example.com',
    );
    await tester.enterText(
      find.byType(TextFormField).last,
      'alejandro1234',
    );
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Alejandro'), findsOneWidget);
    expect(find.text('alejandro@example.com'), findsOneWidget);

    await tester.tap(find.byTooltip('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('Login rechaza credenciales que no están en el mapa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: LoginScreen()),
    );

    await tester.enterText(
      find.byType(TextFormField).first,
      'usuario@example.com',
    );
    await tester.enterText(find.byType(TextFormField).last, 'clave123');
    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Correo o contraseña incorrectos'), findsOneWidget);
  });
}
