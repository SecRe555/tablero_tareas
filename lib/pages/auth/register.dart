import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:tablero_tareas/logic/auth.dart';
import 'package:tablero_tareas/models/user_model.dart';
import 'package:tablero_tareas/router.dart';
import 'package:tablero_tareas/utils/show_dialogs.dart';

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

  ResponsiveGridCol buildGridItem({required Widget child}) => ResponsiveGridCol(
    xs: 12,
    md: 6,
    child: Padding(
      padding: EdgeInsets.symmetric(
        vertical: _verticalPadding,
        horizontal: _horizontalPadding,
      ),
      child: child,
    ),
  );

  TextFormField buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) => TextFormField(
    controller: controller,
    decoration: InputDecoration(label: Text(label)),
    validator: validator,
    obscureText: obscureText,
    keyboardType: keyboardType,
  );

  Widget buildGrid() => ResponsiveGridRow(
    children: [
      buildGridItem(
        child: buildTextField(
          controller: _usernameController,
          label: 'Nombre de usuario',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Rellene este campo';
            }
            return null;
          },
        ),
      ),
      buildGridItem(
        child: buildTextField(
          controller: _emailController,
          label: 'Correo electronico',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Rellene este campo';
            }
            final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
            if (!emailRegex.hasMatch(value)) {
              return 'Correo inválido';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
      buildGridItem(
        child: buildTextField(
          controller: _nameController,
          label: 'Nombre(s)',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Rellene este campo';
            }
            return null;
          },
        ),
      ),
      buildGridItem(
        child: buildTextField(
          controller: _lastnameController,
          label: 'Apellidos',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Rellene este campo';
            }
            return null;
          },
        ),
      ),
      buildGridItem(
        child: buildTextField(
          controller: _passwordController,
          label: 'Contraseña',
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
      buildGridItem(
        child: buildTextField(
          controller: _confirmPasswordController,
          label: 'Confirmar contraseña',
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
    ],
  );

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
                  Form(key: _registerFormKey, child: buildGrid()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: ElevatedButton(
                      child: Text('Registrarse'),
                      onPressed: _validateAndSubmit,
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

  Future<void> _validateAndSubmit() async {
    if (_registerFormKey.currentState!.validate()) {
      final userRegistering = UserRegisterModel(
        username: _usernameController.text,
        email: _emailController.text,
        name: _nameController.text,
        lastname: _lastnameController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
      showLoadingDialog(context: context, text: 'Registrando usuario');
      final result = await registerUser(userRegistering);
      router.pop();
      switch (result) {
        case RegisterReturnValues.SUCCESS:
          showAcceptDialog(
            context: context,
            title: 'Registro exitoso',
            text: 'Se le ha enviado un email para confirmar su correo',
            onConfirm: () => context.go('/login'),
          );
          break;
        case RegisterReturnValues.USERNAME_TAKEN:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Nombre de usuario ya registrado'),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case RegisterReturnValues.EMAIL_TAKEN:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Correo ya registrado'),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case RegisterReturnValues.NETWORK_ERROR:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Ocurrio un error de red. Intente de nuevo mas tarde',
              ),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case RegisterReturnValues.SERVER_ERROR:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Error al conectarse con el servidor. Intente de nuevo mas tarde',
              ),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case RegisterReturnValues.UNKNOWN_ERROR:
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
