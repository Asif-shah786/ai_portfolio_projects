import 'package:ai_portfolio_projects/features/employee_productivity/bloc/emplyee_productivity_bloc.dart';
import 'package:ai_portfolio_projects/features/employee_productivity/employee_productivity_view.dart';
import 'package:ai_portfolio_projects/libraries/productivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_view.dart';
import 'injection.dart';
import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'AI Portfolio Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          primary: Colors.purple,
          secondary: Color(0xFF1a237e), // Dark blue
          surface: Colors.purple.shade50,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: Colors.red.shade700,
        ),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _employeeProductivityNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  // https://pub.dev/documentation/go_router/latest/go_router/ShellRoute-class.html
  // To display a child route on a different Navigator,
  // provide it with a parentNavigatorKey that matches the key provided
  // to either the GoRouter or ShellRoute constructor.
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<EmplyeeProductivityBloc>(create: (BuildContext context) => getIt<EmplyeeProductivityBloc>()),
          ],
          child: MainScreen(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
                path: '/home',
                builder: (context, state) {
                  return Home();
                }),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _employeeProductivityNavigatorKey,
          routes: [
            GoRoute(
                path: '/employee-productivity',
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<EmplyeeProductivityBloc>(
                          create: (BuildContext context) => getIt<EmplyeeProductivityBloc>()),
                    ],
                    child: EmployeeProductivityView(),
                  );
                }),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) async {
        return '/home';
      },
    ),

    // Other routes...
  ],
);
