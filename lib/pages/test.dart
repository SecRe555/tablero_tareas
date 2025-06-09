import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tablero_tareas/constants/supabase.dart';
import 'package:tablero_tareas/models/user_model.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 35,
          children: [
            // ElevatedButton(
            //   onPressed:
            //       () => showAcceptDialog(
            //         context: context,
            //         title: 'Test del titulo',
            //         text: 'Test del text',
            //         type: QuickAlertType.warning,
            //       ),
            //   child: Text('Test AcceptDialog'),
            // ),
            // ElevatedButton(
            //   child: Text('Test ConfirmDialog'),
            //   onPressed:
            //       () => showConfirmDialog(
            //         context: context,
            //         title: 'Prueba de titulo',
            //         text: 'Prueba de texto',
            //         onConfirm: () => print('Confirm'),
            //         onCancel: () => print('Cancel'),
            //       ),
            // ),
            ElevatedButton(
              onPressed: () {
                final User? currentUser = supabase.auth.currentUser;
                if (currentUser != null) {
                  final user = UserSupabase(
                    id: currentUser.id,
                    role: currentUser.role,
                    email: currentUser.email!,
                    phone: currentUser.phone,
                    lastSignInAt: currentUser.lastSignInAt,
                    username: currentUser.userMetadata?['username'] ?? '',
                    name: currentUser.userMetadata?['name'] ?? '',
                    lastName: currentUser.userMetadata?['lastname'] ?? '',
                    birthday:
                        currentUser.userMetadata?['birthday'] != null
                            ? DateTime.tryParse(
                              currentUser.userMetadata?['birthday'],
                            )
                            : null,
                    profilePhoto: currentUser.userMetadata?['profilePhoto'],
                  );
                  print(user);
                }
              },
              child: Text('Test metadata'),
            ),
          ],
        ),
      ),
    );
  }
}
