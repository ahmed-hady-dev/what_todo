// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:what_todo/core/router/router.dart';
import 'package:what_todo/widgets/simple_button.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key, required this.onPressed}) : super(key: key);
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('dialog_delete'.tr()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      actionsPadding: const EdgeInsetsDirectional.only(end: 6),
      actions: [
        SimpleButton(
          text: "cancel".tr(),
          onPressed: MagicRouter.pop,
          invertedColors: true,
        ),
        SimpleButton(
          text: "delete".tr(),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
