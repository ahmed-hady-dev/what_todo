// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../home/controller/home_cubit.dart';
import '../model/todo_model.dart';
import '../widgets/todo_text_filed.dart';

import 'check_icon.dart';

class TodoRow extends StatelessWidget {
  const TodoRow({
    Key? key,
    required bool contentVisible,
    required FocusNode todoFocus,
    required this.todoController,
    required int taskId,
  })  : _contentVisible = contentVisible,
        _todoFocus = todoFocus,
        _taskId = taskId,
        super(key: key);

  final bool _contentVisible;
  final FocusNode _todoFocus;
  final TextEditingController todoController;
  final int _taskId;

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    return Visibility(
      visible: _contentVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            const CheckIcon(),
            // description: 'showcase_todo_delete'.tr(),
            // widgetKey: Constant.todoAddKey,
            TodoTextFiled(
              focusNode: _todoFocus,
              controller: todoController,
              onSubmitted: (value) async {
                if (value != "") {
                  if (_taskId == 0) return;
                  Todo _newTodo =
                      Todo(title: value, isDone: 0, taskId: _taskId);
                  await cubit.insertTodo(todo: _newTodo);
                  _todoFocus.requestFocus();
                  todoController.clear();
                } else {
                  Fluttertoast.showToast(msg: 'todo_empty'.tr());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
