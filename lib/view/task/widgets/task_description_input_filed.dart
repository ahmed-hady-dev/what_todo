import 'package:flutter/material.dart';

class TaskDescriptionInputField extends StatelessWidget {
  const TaskDescriptionInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController inputController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextField(
        controller: inputController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.go,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
          hintText: 'Enter Description for the title',
          hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context)
                  .textTheme
                  .headline6!
                  .color!
                  .withOpacity(0.6)),
          border: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
