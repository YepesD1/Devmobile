import 'package:app_form/main.dart';
import 'package:app_form/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:app_form/presentation/screen/login/login_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/login',
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) =>
          const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) {
        final email = state.extra;
        if (email is! Map<String, String> ||
            email['email'] == null ||
            email['name'] == null) {
          return const LoginScreen();
        }
        return DashboardScreen(
          email: email['email']!,
          name: email['name']!,
        );
      },
    ),
  ],
);
