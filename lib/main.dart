import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/provider/app_provider.dart';
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
  runApp(ChangeNotifierProvider(
      create: (context) => AppProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(appProvider.currentLocale),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        LoginView.routeName: (context) => LoginView(),
        RegisterView.routeName: (context) => RegisterView()
      },
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darkMode,
      themeMode: appProvider.currentTheme,
      builder: EasyLoading.init(),
    );
  }
}
