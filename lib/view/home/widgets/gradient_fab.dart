import 'package:flutter/material.dart';

class GradientFAB extends StatelessWidget {
  final Function() onPressed;

  const GradientFAB({
    required this.onPressed,
    Key? key,
    this.borderRadius = 20,
    this.primaryColor = const Color(0xff4338CA),
    this.secondaryColor = const Color(0xff6D28D9),
    this.icon = Icons.add_rounded,
    this.iconSize = 36.0,
    this.visible = true,
  }) : super(key: key);
  final Color? primaryColor;
  final Color? secondaryColor;
  final double borderRadius;
  final IconData? icon;
  final double? iconSize;
  final bool? visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible!,
      child: Positioned(
        bottom: 0.0,
        right: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
              icon: Icon(
                icon!,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
