import 'package:get/get.dart';
import 'package:tablero_tareas/models/user_model.dart';

class UserController extends GetxController {
  final user = UserSupabase.empty().obs;

  void setUser(UserSupabase newUser) {
    user.value = newUser;
  }

  void clearUser() {
    user.value = UserSupabase.empty();
  }
}
