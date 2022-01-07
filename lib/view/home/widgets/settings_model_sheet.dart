import 'package:flutter/material.dart';
import '../component/language_row.dart';
import '../component/sound_row.dart';
import '../component/theme_row.dart';

class SettingModalSheet extends StatelessWidget {
  const SettingModalSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromWindowPadding(
        WidgetsBinding.instance!.window.viewInsets,
        WidgetsBinding.instance!.window.devicePixelRatio,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            LanguageRow(),
            Divider(height: 8.0),
            ThemeRow(),
            Divider(height: 8.0),
            SoundRow(),
          ],
        ),
      ),
    );
  }
}
