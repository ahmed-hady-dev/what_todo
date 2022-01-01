import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/db_helper/database_helper.dart';
import '../../core/router/router.dart';
import 'controller/home_cubit.dart';
import 'widgets/gradient_fab.dart';
import 'widgets/logo_image.dart';
import 'widgets/task_card_widget.dart';
import 'widgets/theme_button.dart';
import '../task/model/task_model.dart';
import '../task/task_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          debugPrint('home view rebuild');
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const LogoImage(),
                    FutureBuilder(
                      future: _dbHelper.getTasks(),
                      initialData: const <Task>[],
                      builder: (context, AsyncSnapshot<List<Task>?> snapshot) {
                        final tasksList = snapshot.data!;
                        if (tasksList.isEmpty) {
                          return const Expanded(
                              child: Center(
                                  child: Text(
                                      'No tasks yet. add Some to start...')));
                        }
                        return Expanded(
                          child: ListView.separated(
                            itemCount: tasksList.length,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 18.0),
                            padding: const EdgeInsetsDirectional.only(
                                bottom: 16.0, start: 24.0, end: 24.0),
                            itemBuilder: (context, index) {
                              return TaskCardWidget(
                                onTap: () => MagicRouter.navigateTo(TaskView(
                                  task: tasksList[index],
                                )),
                                title: tasksList[index].title.toString(),
                                subTitle:
                                    tasksList[index].description.toString(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                GradientFAB(
                    onPressed: () =>
                        MagicRouter.navigateTo(const TaskView(task: null))),
                const ThemeButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}
