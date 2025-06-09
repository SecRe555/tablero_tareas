import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tablero_tareas/constants/supabase.dart';
import 'package:tablero_tareas/pages/auth/login.dart';
import 'package:tablero_tareas/pages/auth/recovery_password.dart';
import 'package:tablero_tareas/pages/auth/register.dart';
import 'package:tablero_tareas/pages/layout.dart';
import 'package:tablero_tareas/pages/profile/profile.dart';
import 'package:tablero_tareas/pages/test.dart';
import 'package:tablero_tareas/states/user_controller.dart';

import 'models/user_model.dart';

const bool isTesting = false;

final router = GoRouter(
  initialLocation: isTesting ? "/test" : '/',
  redirect: (context, state) {
    final session = supabase.auth.currentSession;
    final isCurrentSession = session != null;
    final isLoggingIn =
        state.uri.toString() == '/login' ||
        state.uri.toString() == '/register' ||
        state.uri.toString() == '/recovery-password';

    if (isTesting) return '/test';
    if (!isCurrentSession && !isLoggingIn) return '/login';
    if (isCurrentSession && isLoggingIn) return '/';

    return null;
  },
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final currentUser = supabase.auth.currentUser;
        final UserSupabase user = UserSupabase(
          id: currentUser!.id,
          role: currentUser.role,
          lastSignInAt: currentUser.lastSignInAt,
          email: currentUser.email as String,
          phone: currentUser.phone,
          username: currentUser.userMetadata?['username'],
          name: currentUser.userMetadata?['name'],
          lastName: currentUser.userMetadata?['lastname'],
          profilePhoto: currentUser.userMetadata?['profile_photo'],
          birthday: currentUser.userMetadata?['birthday'],
        );
        final userController = Get.find<UserController>();
        userController.setUser(user);
        return MainLayout(child: child);
      },
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
    GoRoute(path: '/test', builder: (context, state) => TestPage()),
  ],
);
