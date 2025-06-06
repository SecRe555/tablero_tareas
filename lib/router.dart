import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tablero_tareas/constants/supabase.dart';
import 'package:tablero_tareas/pages/auth/login.dart';
import 'package:tablero_tareas/pages/auth/recoveryPassword.dart';
import 'package:tablero_tareas/pages/auth/register.dart';
import 'package:tablero_tareas/pages/layout.dart';
import 'package:tablero_tareas/pages/profile/profile.dart';

final router = GoRouter(
  initialLocation: "/",
  redirect: (context, state) {
    final session = supabase.auth.currentSession;
    final isCurrentSession = session != null;
    final isLoggingIn =
        state.uri.toString() == '/login' ||
        state.uri.toString() == '/register' ||
        state.uri.toString() == '/recovery-password';

    if (!isCurrentSession && !isLoggingIn) return '/login';
    if (isCurrentSession && isLoggingIn) return '/';

    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => Center(child: Text("Index")),
        ),
        GoRoute(
          path: "/realizadas",
          builder: (context, state) => Center(child: Text("Realizadas")),
        ),
        GoRoute(
          path: "/materias",
          builder: (context, state) => Center(child: Text("materias")),
        ),
        GoRoute(
          path: "/grupos",
          builder: (context, state) => Center(child: Text("grupos")),
        ),
      ],
    ),
    GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(
      path: '/recovery-password',
      builder: (context, state) => RecoveryPasswordPage(),
    ),
  ],
);
