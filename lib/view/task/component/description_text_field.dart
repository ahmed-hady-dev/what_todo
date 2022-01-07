// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField(
      {Key? key,
      required this.visible,
      required this.controller,
      required this.taskDescription,
      required this.onSubmitted,
      required this.focusNode})
      : super(key: key);
  final bool visible;
  final TextEditingController controller;
  final String taskDescription;
  final Function(String) onSubmitted;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    var bodyText1 = Theme.of(context).textTheme.bodyText1!;
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.2),
      child: Visibility(
        visible: visible,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 12.0),
          child: TextField(
            controller: controller..text = taskDescription.toString(),
            focusNode: focusNode,
            keyboardType: TextInputType.text,
            maxLines: null,
            textInputAction: TextInputAction.go,
            style: bodyText1.copyWith(fontWeight: FontWeight.bold),
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
                hintText: "description".tr(),
                hintStyle: bodyText1.copyWith(
                    color: bodyText1.color!.withOpacity(0.6)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 24.0)),
          ),
        ),
      ),
    );
  }
}
