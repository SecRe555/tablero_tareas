import 'package:flutter/material.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => router.go('/login'),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 10),
      ),
      body: Center(child: Text('Profile')),
    );
  }
}
