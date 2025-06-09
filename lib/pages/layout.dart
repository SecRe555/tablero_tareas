import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tablero_tareas/router.dart';
import 'package:tablero_tareas/states/user_controller.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  MainLayout({super.key, required this.child});

  final tabs = [
    {'path': '/', 'icon': Icons.access_time_outlined, 'label': 'Pendientes'},
    {'path': '/realizadas', 'icon': Icons.check, 'label': 'Realizadas'},
    {'path': '/materias', 'icon': Icons.grid_view, 'label': 'Materias'},
    {'path': '/grupos', 'icon': Icons.groups, 'label': 'Grupos'},
  ];

  int _locationToIndex(String location) {
    final index = tabs.indexWhere((tab) => tab['path'] == location);
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _locationToIndex(location);

    final user = Get.find<UserController>().user.value;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tablero de tareas'),
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () => router.push('/profile'),
            child: CircleAvatar(
              backgroundImage: NetworkImage(user.profilePhoto as String),
              child:
                  user.profilePhoto == null
                      ? Text('${user.name[0]}${user.lastName[0]}')
                      : null,
            ),
          ),
        ],
        actionsPadding: EdgeInsets.only(right: 15),
      ),
      body: child,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: GNav(
          selectedIndex: index,
          tabs:
              tabs
                  .map(
                    (tab) => GButton(
                      icon: tab['icon'] as IconData,
                      text: tab['label'] as String,
                    ),
                  )
                  .toList(),
          onTabChange: (index) => context.go(tabs[index]['path'] as String),
        ),
      ),
    );
  }
}
