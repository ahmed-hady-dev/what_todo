import 'package:flutter/material.dart';

class TodoTextFiled extends StatelessWidget {
  const TodoTextFiled(
      {Key? key, this.focusNode, this.controller, this.onSubmitted})
      : super(key: key);
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: focusNode,
        controller: controller!..text = "",
        onSubmitted: onSubmitted,
        decoration: const InputDecoration(hintText: "Enter Todo item..."),
      ),
    );
  }
}