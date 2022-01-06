// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class LanguageRow extends StatelessWidget {
  const LanguageRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "lang".tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
        TextButton(
            onPressed: () {
              if (context.locale.languageCode == 'en') {
                context.setLocale(const Locale('ar', 'EG'));
              } else if (context.locale.languageCode == 'ar') {
                context.setLocale(const Locale('en', 'US'));
              }
            },
            child: Text(
                context.locale.languageCode == 'en' ? 'العربية' : 'English')),
      ],
    );
  }
}
