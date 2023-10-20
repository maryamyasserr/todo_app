import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  final String? title;
  final String? labelText;
  Widget? suffixIcon;

  bool obscureText;

  CustomTextFormField(
      {super.key,
      this.labelText,
      this.title,
      this.controller,
      this.validator,
      this.suffixIcon,
      this.obscureText = false,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffix: suffixIcon,
        labelStyle: theme.textTheme.titleMedium!
            .copyWith(color: Colors.grey.withOpacity(1)),
        hintStyle: theme.textTheme.titleMedium!
            .copyWith(color: Colors.grey.withOpacity(0.8)),
        labelText: labelText,
        hintText: title,
      ),
    );
  }
}
