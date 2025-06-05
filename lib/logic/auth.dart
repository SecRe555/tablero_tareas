import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tablero_tareas/constants/supabase.dart';
import 'package:tablero_tareas/models/user.dart';

enum RegisterReturnValues {
  SUCCESS, // Sin errores
  USERNAME_TAKEN, // Nombre de usuario ya existe
  EMAIL_TAKEN, // Correo ya registrado
  NETWORK_ERROR, // Problema de red o timeout
  SERVER_ERROR, // Error genérico del servidor (500)
  UNKNOWN_ERROR, // Cualquier otro error no categorizado
}

Future<RegisterReturnValues> registerUser(UserModel userRegistering) async {
  try {
    final AuthResponse response = await supabase.auth.signUp(
      email: userRegistering.email,
      password: userRegistering.password!,
      data: {
        'username': userRegistering.username,
        'name': userRegistering.name,
        'lastname': userRegistering.lastname,
      },
    );
    print(response);
    if (response.user != null)
      return RegisterReturnValues.SUCCESS;
    else
      return RegisterReturnValues.UNKNOWN_ERROR;
  } catch (e) {
    final error = e as AuthException;
    if (error.message.contains('username')) {
      return RegisterReturnValues.USERNAME_TAKEN;
    } else if (error.message.contains('email')) {
      return RegisterReturnValues.EMAIL_TAKEN;
    } else if (error.message.contains('network')) {
      return RegisterReturnValues.NETWORK_ERROR;
    } else if (error.message.contains('server')) {
      return RegisterReturnValues.SERVER_ERROR;
    } else {
      return RegisterReturnValues.UNKNOWN_ERROR;
    }
  }
}

enum LoginReturnValues {
  SUCCESS,
  NO_VERIFICATION,
  INVALID_VALUES,
  UNKNOWN_ERROR,
}

Future<LoginReturnValues> loginUser(String email, String password) async {
  try {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return LoginReturnValues.SUCCESS;
  } on AuthException catch (e) {
    if (e.message == 'Invalid login credentials') {
      return LoginReturnValues.INVALID_VALUES;
    } else if (e.message == 'Email not confirmed') {
      return LoginReturnValues.NO_VERIFICATION;
    }
    return LoginReturnValues.UNKNOWN_ERROR;
  } catch (e) {
    // Cualquier otro error inesperado
    return LoginReturnValues.UNKNOWN_ERROR;
  }
}
