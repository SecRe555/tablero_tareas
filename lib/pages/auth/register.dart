import 'package:flutter/material.dart';
import 'package:tablero_tareas/widgets/ResponsiveGrid.dart';
import 'package:tablero_tareas/widgets/ResponsiveGridItem.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: ResponsiveGrid(
            children: [
              ResponsiveGridItem(child: TextField(), xs: 3, sm: 6, md: 9),
              ResponsiveGridItem(child: TextField()),
              ResponsiveGridItem(child: TextField()),
              ResponsiveGridItem(child: TextField()),
            ],
          ),
        ),
      ),
    );
  }
}
