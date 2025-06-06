import 'package:flutter/material.dart';
import 'package:tablero_tareas/logic/auth.dart';
import 'package:tablero_tareas/router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _signOut)],
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: Center(child: Text('Profile')),
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
