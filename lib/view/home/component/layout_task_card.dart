import 'package:flutter/material.dart';
import '../../../core/router/router.dart';
import '../widgets/task_card_widget.dart';
import '../../task/model/task_model.dart';
import '../../task/task_view.dart';

class LayoutTaskCard extends StatelessWidget {
  const LayoutTaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return TaskCardWidget(
        onTap: () => MagicRouter.navigateTo(TaskView(
              task: task,
            )),
        title: task.title!,
        id: task.id!,
        subTitle: task.description);
  }
}
