import 'package:flutter/material.dart';
import '../../../core/theme/theme_cubit.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      right: 0.0,
      child: IconButton(
        onPressed: ThemeCubit.get(context).changeTheme,
        icon: const Icon(Icons.dark_mode),
      ),
    );
  }
}
