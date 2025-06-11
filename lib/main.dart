import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tablero_tareas/constants/supabase.dart';
import 'package:tablero_tareas/router.dart';
import 'package:tablero_tareas/states/theme_controller.dart';
import 'package:tablero_tareas/states/user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] as String,
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] as String,
  );
  supabase = Supabase.instance.client;

  final UserController userController = Get.put(UserController());
  final ThemeController themeController = Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = Get.find<ThemeController>();

    return Obx(
      () => MaterialApp.router(
        title: "Tablero de tareas",
        theme: theme.lightTheme.value,
        darkTheme: theme.darkTheme.value,
        themeMode: theme.themeMode,
        routerConfig: router,
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [Locale('es')],
      ),
    );
  }
}
