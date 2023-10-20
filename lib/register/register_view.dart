import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../core/theme/my_theme.dart';
import '../core/widgets/custom_text_form_field.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = 'Register';

  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  static TextEditingController fullNameController = TextEditingController();
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmPasswordController =
      TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = AppLocalizations.of(context);
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
              locale!.create_account,
              style: theme.textTheme.titleLarge,
            ),
            centerTitle: true,
            toolbarHeight: 120,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                    SizedBox(height: 40),
                    CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return locale!.you_must_enter_your_full_name;
                          }
                          return null;
                        },
                        labelText: locale!.full_name,
                        controller: fullNameController),
                    SizedBox(height: 20),
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
                        var regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (!regex.hasMatch(value)) {
                          return locale!.enter_valid_password;
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
                    SizedBox(height: 20),
                    CustomTextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return locale!.you_must_confirm_your_password;
                        }
                        if (value != passwordController.text) {
                          return locale!.password_does_not_match;
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
                      labelText: locale!.confirm_password,
                      controller: confirmPasswordController,
                      obscureText: !isVisible,
                    ),
                    SizedBox(height: 40),
                    MaterialButton(
                      onPressed: () {
                        register();
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
                              locale!.create_account,
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
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        EasyLoading.dismiss();
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.dismiss();
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          EasyLoading.dismiss();
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
