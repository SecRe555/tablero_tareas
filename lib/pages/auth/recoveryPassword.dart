import 'package:flutter/material.dart';
import 'package:tablero_tareas/logic/auth.dart';

class RecoveryPasswordPage extends StatelessWidget {
  RecoveryPasswordPage({super.key});

  final _recoveryPasswordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: Form(
            key: _recoveryPasswordFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Correo inválido';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                ElevatedButton(
                  child: Text('Recuperar contraseña'),
                  onPressed: () => _validateAndSubmit(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateAndSubmit(BuildContext context) async {
    if (_recoveryPasswordFormKey.currentState!.validate()) {
      final result = await recoveryPassword(_emailController.text);
      switch (result) {
        case RecoveryPasswordReturnValue.SUCCESS:
        case RecoveryPasswordReturnValue.INVALID_USER:
        case RecoveryPasswordReturnValue.INVALID_EMAIL:
        case RecoveryPasswordReturnValue.EMAIL_NOT_CONFIRMED:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Si el correo existe. Se ha mandado un correo de confirmacion',
              ),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case RecoveryPasswordReturnValue.RATE_LIMIT_EXCEEDED:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Limite de peticiones excedido. Intente de nuevo mas tarde.',
              ),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case RecoveryPasswordReturnValue.NETWORK_ERROR:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Ocurrio un error de red. Intente de nuevo mas tarde.',
              ),
              duration: Duration(seconds: 3),
            ),
          );
          break;
        case RecoveryPasswordReturnValue.UNKNOWN_ERROR:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ocurrio un error. Intente de nuevo mas tarde.'),
              duration: Duration(seconds: 3),
            ),
          );
          break;
      }
    }
  }
}
