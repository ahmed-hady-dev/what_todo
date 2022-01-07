import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/home_cubit.dart';
import '../widgets/logo_widget.dart';
import '../widgets/no_tasks.dart';
import '../../task/model/task_model.dart';
import '../../../widgets/loading_widget.dart';

import 'layout_task_card.dart';

class HomePortraitLayout extends StatelessWidget {
  const HomePortraitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            const LogoWidget(),
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
                  child: ListView.separated(
                    itemCount: tasksList.length,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16.0),
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 16.0, start: 22.0, end: 22.0),
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
