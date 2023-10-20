import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../core/provider/app_provider.dart';
import '../../core/widgets/language_bottom_sheet_widget.dart';
import '../../core/widgets/settings_item.dart';
import '../../core/widgets/theme_bottom_sheet_widget.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var appProvider = Provider.of<AppProvider>(context);
    var locale = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 170,
          width: double.infinity,
          color: theme.colorScheme.primary,
          child: Text(
            locale!.settings,
            style: theme.textTheme.titleLarge,
          ),
        ),
        SettingsItem(
          selectedOption:
              appProvider.currentLocale == 'en' ? 'English' : 'عربي',
          settingsTitle: locale!.language,
          onOptionTap: () {
            showLanguageBottomSheet(context);
          },
        ),
        SizedBox(height: 25),
        SettingsItem(
          selectedOption: appProvider.isDark() ? locale!.dark : locale!.light,
          settingsTitle: locale.theme_mode,
          onOptionTap: () {
            showThemeBottomSheet(context);
          },
        ),
      ],
    );
  }

  void showLanguageBottomSheet(context) {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheetWidget());
  }

  void showThemeBottomSheet(context) {
    showModalBottomSheet(
        context: context, builder: (context) => ThemeBottomSheetWidget());
  }
}
