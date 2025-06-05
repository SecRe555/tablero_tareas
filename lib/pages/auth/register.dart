import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tablero_tareas/logic/auth/register.dart';
import 'package:tablero_tareas/models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();
  final double _verticalPadding = 15;
  final double _horizontalPadding = 10;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                spacing: 25,
                children: [
                  Form(
                    key: _registerFormKey,
                    child: ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: _verticalPadding,
                              horizontal: _horizontalPadding,
                            ),
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                label: Text('Nombre de usuario'),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Rellene este campo';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: _verticalPadding,
                              horizontal: _horizontalPadding,
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                label: Text('Correo electronico'),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Rellene este campo';
                                }
                                final emailRegex = RegExp(
                                  r'^[\w\.-]+@[\w\.-]+\.\w{2,}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Correo inválido';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: _verticalPadding,
                              horizontal: _horizontalPadding,
                            ),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                label: Text('Nombre(s)'),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Rellene este campo';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: _verticalPadding,
                              horizontal: _horizontalPadding,
                            ),
                            child: TextFormField(
                              controller: _lastnameController,
                              decoration: InputDecoration(
                                label: Text('Apellidos'),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Rellene este campo';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: _verticalPadding,
                              horizontal: _horizontalPadding,
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                label: Text('Contraseña'),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Rellene este campo';
                                }
                                if (value.length < 8) {
                                  return 'Deben ser minimo 8 caracteres';
                                }
                                if (value != _confirmPasswordController.text) {
                                  return 'Las contraseñas no coinciden';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 12,
                          md: 6,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: _verticalPadding,
                              horizontal: _horizontalPadding,
                            ),
                            child: TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                label: Text('Confirmar contraseña'),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Rellene este campo';
                                }
                                if (value.length < 8) {
                                  return 'Deben ser minimo 8 caracteres';
                                }
                                if (value != _passwordController.text) {
                                  return 'Las contraseñas no coinciden';
                                }
                                return null;
                              },
                              obscureText: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: ElevatedButton(
                      child: Text('Registrarse'),
                      onPressed: () async {
                        if (_registerFormKey.currentState!.validate()) {
                          final userRegistering = UserModel(
                            username: _usernameController.text,
                            email: _emailController.text,
                            name: _nameController.text,
                            lastname: _lastnameController.text,
                            password: _passwordController.text,
                            confirmPassword: _confirmPasswordController.text,
                          );

                          final result = await registerUser(userRegistering);
                          switch (result) {
                            case RegisterReturnValues.SUCCESS:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Usuario registrado'),
                                ),
                              );
                              break;
                            case RegisterReturnValues.USERNAME_TAKEN:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Nombre de usuario ya registrado',
                                  ),
                                ),
                              );
                              break;
                            case RegisterReturnValues.EMAIL_TAKEN:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Correo ya registrado'),
                                ),
                              );
                              break;
                            case RegisterReturnValues.NETWORK_ERROR:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Ocurrio ')),
                              );
                              break;
                            case RegisterReturnValues.SERVER_ERROR:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error genérico del servidor (500)',
                                  ),
                                ),
                              );
                              break;
                            case RegisterReturnValues.UNKNOWN_ERROR:
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Error genérico del servidor (500)',
                                  ),
                                ),
                              );
                              break;
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
