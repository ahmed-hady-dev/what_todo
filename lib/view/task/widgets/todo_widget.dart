import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../home/controller/home_cubit.dart';
import '../model/todo_model.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget(
      {Key? key, this.text, required this.isDone, required this.todo})
      : super(key: key);
  final String? text;
  final bool isDone;
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1!;
    final cubit = HomeCubit.get(context);
    return InkWell(
      onTap: () async {
        if (todo.isDone == 0) {
          await cubit.updateTodoDone(id: todo.id!, isDone: 1);
        } else {
          await cubit.updateTodoDone(id: todo.id!, isDone: 0);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24.0),
        child: Row(
          children: <Widget>[
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
            Text(text ?? '(Unnamed Todo)',
                style: bodyText1.copyWith(
                    fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                    color: isDone
                        ? bodyText1.color
                        : bodyText1.color!.withOpacity(0.6)))
          ],
        ),
      ),
    );
  }
}
