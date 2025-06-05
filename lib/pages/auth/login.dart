import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tablero_tareas/logic/auth.dart';
import 'package:tablero_tareas/router.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: Text('Correo electronico'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Rellene este campo';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextFormField(
                        controller: _passwordController,
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
                        onPressed: _validateAndLogin,
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

  Future<void> _validateAndLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      final result = await loginUser(
        _emailController.text,
        _passwordController.text,
      );
      switch (result) {
        case LoginReturnValues.SUCCESS:
          // Guardar user y session
          context.go('/');
          break;
        case LoginReturnValues.NO_VERIFICATION:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Falta verificación de correo'),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case LoginReturnValues.INVALID_VALUES:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Usuario o contraseña incorrectos'),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case LoginReturnValues.UNKNOWN_ERROR:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ocurrio un error. Intente de nuevo mas tarde'),
              duration: Duration(seconds: 3),
            ),
          );
          break;
      }
    }
  }
}
