// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:what_todo/core/theme/theme_cubit.dart';

class ThemeRow extends StatelessWidget {
  const ThemeRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("dark_theme".tr(), style: Theme.of(context).textTheme.headline6),
          CupertinoSwitch(
            activeColor: Colors.black38,
            thumbColor: Colors.black,
            value: ThemeCubit.get(context).isDark,
            onChanged: (value) {
              ThemeCubit.get(context).changeTheme();
            },
          ),
        ],
      ),
    );
  }
}
