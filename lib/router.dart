import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tablero_tareas/pages/auth/login.dart';
import 'package:tablero_tareas/pages/auth/register.dart';
import 'package:tablero_tareas/pages/layout.dart';
import 'package:tablero_tareas/pages/profile/profile.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => Center(child: Text("Index")),
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
  ],
);
