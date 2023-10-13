import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 170,
          width: double.infinity,
          color: theme.primaryColor,
          child: Text(
            'Settings',
            style: theme.textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
