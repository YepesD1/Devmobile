import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parcial/presentation/screens/login_screen.dart';
import 'package:parcial/presentation/screens/register_screen.dart';

void main() {
  testWidgets('Login muestra correo y contraseña', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.text('Bienvenido'), findsOneWidget);
    expect(find.byKey(const Key('loginEmail')), findsOneWidget);
    expect(find.byKey(const Key('loginPassword')), findsOneWidget);
    expect(find.text('¿No tienes cuenta? Regístrate'), findsOneWidget);
    expect(find.byKey(const Key('googleLogin')), findsOneWidget);
    expect(find.byKey(const Key('facebookLogin')), findsOneWidget);
  });

  testWidgets('Login valida campos vacíos', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresa tu correo electrónico'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña'), findsOneWidget);
  });

  testWidgets('Login valida formato de correo', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.enterText(
      find.byKey(const Key('loginEmail')),
      'correo-invalido',
    );
    await tester.enterText(find.byKey(const Key('loginPassword')), 'clave123');
    await tester.tap(find.text('Ingresar'));
    await tester.pump();

    expect(find.text('Ingresa un correo electrónico válido'), findsOneWidget);
  });

  testWidgets('Registro muestra correo y contraseña', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    expect(find.text('Crear cuenta'), findsOneWidget);
    expect(find.byKey(const Key('registerName')), findsOneWidget);
    expect(find.byKey(const Key('registerEmail')), findsOneWidget);
    expect(find.byKey(const Key('registerPassword')), findsOneWidget);
    expect(find.byKey(const Key('registerConfirmPassword')), findsOneWidget);
    expect(find.text('¿Ya tienes cuenta? Inicia sesión'), findsOneWidget);
  });

  testWidgets('Registro valida todos los campos obligatorios', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    await tester.tap(find.text('Registrarme'));
    await tester.pump();

    expect(find.text('Ingresa tu nombre completo'), findsOneWidget);
    expect(find.text('Ingresa tu correo electrónico'), findsOneWidget);
    expect(find.text('Ingresa una contraseña'), findsOneWidget);
    expect(find.text('Confirma tu contraseña'), findsOneWidget);
  });

  testWidgets('Registro valida longitud y coincidencia', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    await tester.enterText(
      find.byKey(const Key('registerName')),
      'Alejandro Yepes',
    );
    await tester.enterText(
      find.byKey(const Key('registerEmail')),
      'alejandro@example.com',
    );
    await tester.enterText(find.byKey(const Key('registerPassword')), '123');
    await tester.enterText(
      find.byKey(const Key('registerConfirmPassword')),
      '1234',
    );
    await tester.tap(find.text('Registrarme'));
    await tester.pump();

    expect(
      find.text('La contraseña debe tener al menos 6 caracteres'),
      findsOneWidget,
    );
    expect(find.text('Las contraseñas no coinciden'), findsOneWidget);
  });
}
