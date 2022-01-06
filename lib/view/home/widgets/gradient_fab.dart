// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class GradientFAB extends StatelessWidget {
  const GradientFAB({
    required this.onPressed,
    Key? key,
    this.borderRadius = 20,
    this.primaryColor = const Color(0xff4338CA),
    this.secondaryColor = const Color(0xff6D28D9),
    this.icon = Icons.add_rounded,
    this.iconSize = 36.0,
    this.visible = true,
    this.isHome = true,
  }) : super(key: key);
  final Function() onPressed;
  final Color? primaryColor;
  final Color? secondaryColor;
  final double borderRadius;
  final IconData? icon;
  final double? iconSize;
  final bool? visible;
  final bool? isHome;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible!,
      child: Positioned(
        bottom: 12.0,
        right: context.locale.languageCode == 'en' ? 8.0 : null,
        left: context.locale.languageCode == 'en' ? null : 8.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient:
                    LinearGradient(colors: [primaryColor!, secondaryColor!])),
            child: IconButton(
              padding: const EdgeInsets.all(12.0),
              onPressed: onPressed,
              iconSize: iconSize!,
              alignment: Alignment.center,
              icon: Icon(icon!, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
