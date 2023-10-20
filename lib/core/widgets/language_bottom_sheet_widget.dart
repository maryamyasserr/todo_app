import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/widgets/selected_option_widget.dart';
import 'package:todo_app/core/widgets/unselected_option_widget.dart';

import '../../../core/provider/app_provider.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
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
                appProvider.changeLanguage('en');
                Navigator.pop(context);
              },
              child: appProvider.currentLocale == 'en'
                  ? SelectedOptionWidget(selectedTitle: 'English')
                  : UnselectedOptionWidget(unselectedTitle: 'English')),
          SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                appProvider.changeLanguage('ar');
                Navigator.pop(context);
              },
              child: appProvider.currentLocale == 'ar'
                  ? SelectedOptionWidget(selectedTitle: 'عربي')
                  : UnselectedOptionWidget(unselectedTitle: 'عربي'))
        ],
      ),
    );
  }
}
