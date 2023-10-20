import 'package:flutter/material.dart';

typedef settingsOptionClicked = void Function();

class SettingsItem extends StatelessWidget {
  final String settingsTitle, selectedOption;
  final settingsOptionClicked onOptionTap;

  const SettingsItem(
      {super.key,
      required this.settingsTitle,
      required this.onOptionTap,
      required this.selectedOption});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(settingsTitle,
              textAlign: TextAlign.start, style: theme.textTheme.titleMedium),
          GestureDetector(
            onTap: onOptionTap,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: mediaQuery.width,
              decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: theme.colorScheme.primary, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedOption,
                    style: theme.textTheme.bodyLarge!.copyWith(fontSize: 20),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
