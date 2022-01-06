import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_todo/view/home/controller/home_cubit.dart';
import 'package:what_todo/view/home/widgets/logo_image.dart';
import 'package:what_todo/view/home/widgets/no_tasks.dart';
import 'package:what_todo/view/task/model/task_model.dart';
import 'package:what_todo/widgets/loading_widget.dart';

import 'layout_task_card.dart';

class HomeLandscapeLayout extends StatelessWidget {
  const HomeLandscapeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Row(
          children: [
            const LogoImage(),
            FutureBuilder(
              future: HomeCubit.get(context).dbHelper.getTasks(),
              initialData: const <Task>[],
              builder: (context, AsyncSnapshot<List<Task>?> snapshot) {
                final tasksList = snapshot.data!;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                }
                if (tasksList.isEmpty) return const NoTasks();
                return Expanded(
                  child: GridView.builder(
                    itemCount: tasksList.length,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 16.0, start: 22.0, end: 22.0, top: 16.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.15,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0),
                    itemBuilder: (context, index) {
                      final task = tasksList[index];
                      return LayoutTaskCard(task: task);
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
