import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tablero_tareas/logic/auth.dart';
import 'package:tablero_tareas/router.dart';
import 'package:tablero_tareas/states/theme_controller.dart';
import 'package:tablero_tareas/states/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Get.find<UserController>().user.value;
    final theme = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} ${user.lastName}'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _signOut)],
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 25.0,
          children: [
            Obx(
              () => DropdownButton<ThemeMode>(
                value: theme.mode.value,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('Sistema'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Claro'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Oscuro'),
                  ),
                ],
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    theme.setThemeMode(value);
                    theme.setPrimaryColor(theme.primaryColor.value)
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    final result = await signOutUser();
    if (result == SignOutReturnValues.SUCCESS) {
      router.go('/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ocurrio un error al cerrar sesión. Intente de nuevo mas tarde',
          ),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
