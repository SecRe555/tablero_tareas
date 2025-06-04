import 'package:flutter/material.dart';
import 'package:tablero_tareas/router.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              Text(
                'Iniciar sesión',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Form(
                key: _loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    spacing: 25,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(label: Text('Usuario')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Rellene este campo';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(label: Text('Contraseña')),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Rellene este campo';
                          }
                          return null;
                        },
                      ),
                      ElevatedButton(
                        child: Text('Iniciar sesión'),
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            router.go('/');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                child: Text('¿Olvidaste tu contraseña?'),
                onPressed: () {},
              ),
              TextButton(
                child: Text('Registrate'),
                onPressed: () => router.push('/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
