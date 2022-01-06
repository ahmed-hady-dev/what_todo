import 'package:flutter/material.dart';

const double kPortraitBreakPoint = 480.0;

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key? key,
    required this.mobilePortrait,
    this.mobileLandscape,
  }) : super(key: key);
  final Widget mobilePortrait;
  final Widget? mobileLandscape;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > kPortraitBreakPoint) {
        return mobileLandscape ?? mobilePortrait;
      }
      return mobilePortrait;
    });
  }
}
