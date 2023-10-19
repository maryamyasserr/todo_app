import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/login/login_view.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'SplashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset('assets/images/splash_screen.png'),
    );
  }
}
