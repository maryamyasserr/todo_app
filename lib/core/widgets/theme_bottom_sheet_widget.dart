import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/widgets/selected_option_widget.dart';
import 'package:todo_app/core/widgets/unselected_option_widget.dart';

import '../provider/app_provider.dart';

class ThemeBottomSheetWidget extends StatelessWidget {
  const ThemeBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    var locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          GestureDetector(
              onTap: () {
                appProvider.changeTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              child: appProvider.isDark()
                  ? SelectedOptionWidget(selectedTitle: locale!.dark)
                  : UnselectedOptionWidget(unselectedTitle: locale!.dark)),
          SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                appProvider.changeTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              child: appProvider.isDark()
                  ? UnselectedOptionWidget(unselectedTitle: locale.light)
                  : SelectedOptionWidget(selectedTitle: locale.light))
        ],
      ),
    );
  }
}
