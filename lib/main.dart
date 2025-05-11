import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'utilities/app_font.dart';
import 'utilities/routes.dart';
import 'view/authentication/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: AppFont.fontFamily,
      ),
      routes: routes,
      home: Splash(),
    );
  }
}
