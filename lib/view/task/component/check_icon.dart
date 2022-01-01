import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class CheckIcon extends StatelessWidget {
  const CheckIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      height: 20.0,
      margin: const EdgeInsetsDirectional.only(end: 12.0),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: AppColors.greyColor, width: 1.5)),
      child: const FittedBox(child: Icon(Icons.check)),
    );
  }
}
