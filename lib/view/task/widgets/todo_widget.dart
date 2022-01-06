// ignore_for_file: implementation_imports

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:what_todo/core/cacheHelper/cache_helper.dart';
import '../../../constants/app_colors.dart';
import '../../home/controller/home_cubit.dart';
import '../model/todo_model.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({
    Key? key,
    this.text,
    required this.isDone,
    required this.todo,
  }) : super(key: key);
  final String? text;
  final bool isDone;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1!;
    final cubit = HomeCubit.get(context);
    return InkWell(
      splashColor: const Color(0x66C8C8C8),
      onTap: () async {
        HapticFeedback.vibrate();
        if (todo.isDone == 0) {
          final boo = await CacheHelper.getSound ?? true;
          if (boo) {
            await AudioCache().play('music/task_done.mp3');
          }
          await cubit.updateTodoDone(id: todo.id!, isDone: 1);
        } else {
          await cubit.updateTodoDone(id: todo.id!, isDone: 0);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24.0),
        child: Row(
          children: <Widget>[
            // description: 'showcase_todo_check'.tr(),
            // widgetKey: Constant.todoCheckKey,
            Container(
              width: 32.0,
              height: 32.0,
              margin: const EdgeInsetsDirectional.only(end: 12.0),
              decoration: BoxDecoration(
                  color: isDone ? AppColors.purpleColor : Colors.transparent,
                  border:
                      isDone ? null : Border.all(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(6.0)),
              child: isDone
                  ? const Icon(Icons.done_rounded, color: Colors.white)
                  : null,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(text!,
                        style: bodyText1.copyWith(
                            fontWeight:
                                isDone ? FontWeight.bold : FontWeight.normal,
                            color: isDone
                                ? bodyText1.color
                                : bodyText1.color!.withOpacity(0.6))),
                  ),
                  IconButton(
                    iconSize: 18,
                    splashRadius: 20.0,
                    onPressed: () => cubit.deleteTodo(todoId: todo.id!),
                    // description: 'showcase_todo_delete'.tr(),
                    // widgetKey: Constant.todoDeleteKey,
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
