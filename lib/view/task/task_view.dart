// ignore_for_file: implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/app_colors.dart';
import '../home/controller/home_cubit.dart';
import '../home/widgets/gradient_fab.dart';
import 'component/description_text_field.dart';
import 'component/title_text_field.dart';
import 'widgets/back_button_widget.dart';
import 'widgets/todo_widget.dart';
import 'component/todo_row.dart';
import 'model/task_model.dart';
import 'model/todo_model.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key, this.task}) : super(key: key);
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  BuildContext? myContext;
  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";
  bool _contentVisible = false;
  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _todoController;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task!.title!;
      _taskDescription = widget.task!.description ?? '';
      _taskId = widget.task!.id!;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _todoController = TextEditingController();
    // WidgetsBinding.instance!.addPostFrameCallback(
    //     (_) => Future.delayed(const Duration(milliseconds: 500), () {
    //           ShowCaseWidget.of(myContext!)!.startShowCase([
    //             // Constant.titleKey,
    //             // Constant.descriptionKey,
    //             // Constant.todoCheckKey,
    //             // Constant.todoDeleteKey,
    //             // Constant.todoAddKey,
    //             // Constant.taskFabKey,
    //           ]);
    //         }));
    // WidgetsBinding.instance!.addPostFrameCallback(
    //   (_) => ShowCaseWidget.of(myContext!)!.startShowCase(
    //     [
    //       Constant.titleKey,
    //       Constant.descriptionKey,
    //       // Constant.todoCheckKey,
    //       Constant.todoDeleteKey,
    //       Constant.todoAddKey,
    //       Constant.taskFabKey,
    //     ],
    //   ),
    // );
    // if (Constant.isFirst) {
    //   WidgetsBinding.instance!.addPostFrameCallback(
    //     (_) => ShowCaseWidget.of(myContext!)!.startShowCase(
    //       [Constant.taskFabKey],
    //     ),
    //   );
    // }
    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    _todoController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          myContext = context;
          return Scaffold(
            resizeToAvoidBottomInset:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? true
                    : false,
            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        children: [
                          const BackButtonWidget(),
                          TitleTextField(
                            controller: _titleController,
                            taskTitle: _taskTitle,
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value.isNotEmpty || value != '') {
                                if (widget.task == null) {
                                  Task _newTask = Task(title: value);
                                  _taskId =
                                      (await cubit.insertTask(task: _newTask))!;
                                  _contentVisible = true;
                                  _taskTitle = value.toString();
                                } else {
                                  _taskTitle = value.toString();
                                  await cubit.updateTaskTitle(
                                      id: widget.task!.id!,
                                      title: value.toString());
                                }
                                _descriptionFocus.requestFocus();
                              } else {
                                Fluttertoast.showToast(msg: 'title_empty'.tr());
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    DescriptionTextField(
                      visible: _contentVisible,
                      controller: _descriptionController,
                      taskDescription: _taskDescription,
                      focusNode: _descriptionFocus,
                      onSubmitted: (value) async {
                        if (_taskId == 0) return;
                        await cubit.updateTaskDescription(
                            id: _taskId, description: value.toString());
                        _taskDescription = value.toString();
                        _todoFocus.requestFocus();
                      },
                    ),
                    Visibility(
                      visible: _contentVisible,
                      child: FutureBuilder(
                        future: cubit.dbHelper.getTodo(taskId: _taskId),
                        initialData: const <Todo>[],
                        builder:
                            (context, AsyncSnapshot<List<Todo>?> snapshot) {
                          return Expanded(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return TodoWidget(
                                    todo: snapshot.data![index],
                                    text: snapshot.data![index].title,
                                    isDone: snapshot.data![index].isDone == 0
                                        ? false
                                        : true);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    TodoRow(
                        contentVisible: _contentVisible,
                        todoFocus: _todoFocus,
                        todoController: _todoController,
                        taskId: _taskId),
                  ],
                ),
                GradientFAB(
                  isHome: false,
                  visible: _contentVisible,
                  icon: Icons.delete_forever_rounded,
                  primaryColor: AppColors.pinkColor,
                  secondaryColor: const Color(0xFFF54770),
                  onPressed: () async {
                    if (_taskId == 0) return;
                    await cubit.deleteTask(id: _taskId);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
