import 'package:flutter/material.dart';

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
      child: TextField(
        controller: controller..text = taskTitle,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.go,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        style: textTheme.copyWith(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: 'Enter Task Title',
          hintStyle:
              textTheme.copyWith(color: textTheme.color!.withOpacity(0.6)),
        ),
      ),
    );
  }
}
