import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/core/theme/my_theme.dart';
import 'package:todo_app/core/widgets/custom_text_form_field.dart';
import 'package:todo_app/home/home_screen.dart';

import '../register/register_view.dart';

class LoginView extends StatefulWidget {
  static const String routeName = 'Login';

  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login_pattern.png'),
            fit: BoxFit.cover),
        color: MyTheme.backgroundColorLight,
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              locale!.login,
              style: theme.textTheme.titleLarge,
            ),
            centerTitle: true,
            toolbarHeight: 120,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.18),
                    Text(
                      locale!.welcome_back,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return locale!.you_must_enter_your_email;
                          }
                          var regex = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!regex.hasMatch(value)) {
                            return locale!.invalid_email;
                          }
                          return null;
                        },
                        labelText: locale!.email,
                        controller: emailController),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return locale!.you_must_enter_your_password;
                        }
                        return null;
                      },
                      suffixIcon: GestureDetector(
                          onTap: () {
                            isVisible = !isVisible;
                            setState(() {});
                          },
                          child: isVisible == true
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  size: 28,
                                  color: theme.primaryColor,
                                )
                              : Icon(
                                  Icons.visibility_outlined,
                                  size: 28,
                                  color: theme.primaryColor,
                                )),
                      labelText: locale!.password,
                      controller: passwordController,
                      obscureText: !isVisible,
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          locale!.forget_password,
                          textAlign: TextAlign.start,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () {
                        login();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        height: 55,
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale!.login,
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 25,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterView.routeName);
                        },
                        child: Text(
                          locale!.create_account,
                          textAlign: TextAlign.start,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        EasyLoading.dismiss();
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.dismiss();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          EasyLoading.dismiss();
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
