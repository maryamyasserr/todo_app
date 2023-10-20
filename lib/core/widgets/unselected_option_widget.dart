import 'package:flutter/material.dart';

class UnselectedOptionWidget extends StatelessWidget {
  final String unselectedTitle;

  const UnselectedOptionWidget({super.key, required this.unselectedTitle});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(14),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        unselectedTitle,
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}
