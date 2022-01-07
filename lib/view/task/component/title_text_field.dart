// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:easy_localization/src/public_ext.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField(
      {Key? key,
      required this.controller,
      required this.taskTitle,
      this.focusNode,
      this.onSubmitted})
      : super(key: key);
  final TextEditingController controller;
  final String taskTitle;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6!;
    return Expanded(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.2),
        child: TextField(
          controller: controller..text = taskTitle,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.go,
          focusNode: focusNode,
          onSubmitted: onSubmitted,
          maxLines: null,
          style: textTheme.copyWith(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: "title".tr(),
            hintStyle:
                textTheme.copyWith(color: textTheme.color!.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}
