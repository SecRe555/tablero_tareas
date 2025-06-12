import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tablero_tareas/logic/auth.dart';
import 'package:tablero_tareas/router.dart';
import 'package:tablero_tareas/states/theme_controller.dart';
import 'package:tablero_tareas/states/user_controller.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Map<String, Color> _flutterColors = {
    'Rojo': Colors.red,
    'Rosa': Colors.pink,
    'Morado': Colors.purple,
    'Morado oscuro': Colors.deepPurple,
    'Índigo': Colors.indigo,
    'Azul': Colors.blue,
    'Azul claro': Colors.lightBlue,
    'Cian': Colors.cyan,
    'Verde azulado': Colors.teal,
    'Verde': Colors.green,
    'Verde claro': Colors.lightGreen,
    'Lima': Colors.lime,
    'Amarillo': Colors.yellow,
    'Ámbar': Colors.amber,
    'Naranja': Colors.orange,
    'Naranja oscuro': Colors.deepOrange,
    'Café': Colors.brown,
    'Gris': Colors.grey,
    'Gris azulado': Colors.blueGrey,
  };

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
                value: theme.themeMode.value,
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
                    theme.updateThemeMode(value);
                  }
                },
              ),
            ),
            Obx(
              () => DropdownButton<Color>(
                value: theme.primaryColor.value,
                items:
                    _flutterColors.entries
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.value,
                            child: Text(e.key),
                          ),
                        )
                        .toList(),
                onChanged: (Color? color) {
                  if (color != null) {
                    theme.updatePrimaryColor(color);
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
