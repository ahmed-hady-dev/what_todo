// import 'package:flutter/material.dart';
// import 'package:showcaseview/showcaseview.dart';
// import 'package:what_todo/constants/app_colors.dart';
//
// class CustomShowCase extends StatelessWidget {
//   const CustomShowCase({
//     Key? key,
//     required this.widgetKey,
//     required this.child,
//     this.title,
//     required this.description,
//     this.animationDuration = const Duration(milliseconds: 2000),
//     this.contentPadding = const EdgeInsets.all(8),
//     this.overlayPadding = EdgeInsets.zero,
//     this.radius,
//     this.container,
//     this.height,
//     this.width,
//     this.shapeBorder,
//   }) : super(key: key);
//   final GlobalKey widgetKey;
//   final Widget child;
//   final String? title;
//   final String? description;
//   final BorderRadius? radius;
//   final EdgeInsets contentPadding;
//   final Widget? container;
//   final double? height;
//   final double? width;
//   final ShapeBorder? shapeBorder;
//   final Duration animationDuration;
//   final EdgeInsets overlayPadding;
//
//   @override
//   Widget build(BuildContext context) {
//     return Showcase(
//       key: widgetKey,
//       description: description,
//       title: title,
//       shapeBorder: shapeBorder,
//       animationDuration: animationDuration,
//       showcaseBackgroundColor: AppColors.purpleColor,
//       titleTextStyle:
//           Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
//       descTextStyle:
//           Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
//       contentPadding: contentPadding,
//       radius: radius ?? BorderRadius.circular(8),
//       overlayPadding: overlayPadding,
//       child: child,
//     );
//   }
// }
