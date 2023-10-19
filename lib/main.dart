import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/home/home_screen.dart';
import 'package:todo_app/login/login_view.dart';
import 'package:todo_app/register/register_view.dart';
import 'package:todo_app/splash_screen/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginView.routeName: (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView()
      },
      theme: MyTheme.lightMode,
      builder: EasyLoading.init(),
    );
  }
}
