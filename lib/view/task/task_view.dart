import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/app_colors.dart';
import '../../core/db_helper/database_helper.dart';
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
  const TaskView({Key? key, required this.task}) : super(key: key);
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";
  bool _contentVisible = false;
  late FocusNode _titleFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _todoFocus;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController todoController;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task!.title!;
      _taskDescription = widget.task!.description ?? '(no description)';
      _taskId = widget.task!.id!;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    todoController = TextEditingController();
    super.initState();
  }

  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    todoController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        children: [
                          const BackButtonWidget(),
                          TitleTextField(
                            controller: titleController,
                            taskTitle: _taskTitle,
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value.isNotEmpty || value != '') {
                                if (widget.task == null) {
                                  Task _newTask = Task(
                                      title: value,
                                      description: '(no description)');
                                  _taskId =
                                      (await cubit.insertTask(task: _newTask))!;
                                  setState(() {
                                    _contentVisible = true;
                                    _taskTitle = value.toString();
                                  });
                                } else {
                                  await cubit.updateTaskTitle(
                                      id: widget.task!.id!,
                                      title: value.toString());
                                  debugPrint("Task Updated");
                                }
                                _descriptionFocus.requestFocus();
                              } else {
                                debugPrint('The title must not be empty');
                                Fluttertoast.showToast(
                                    msg: 'The title must not be empty');
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    DescriptionTextField(
                      visible: _contentVisible,
                      controller: descriptionController,
                      taskDescription: _taskDescription,
                      focusNode: _descriptionFocus,
                      onSubmitted: (value) async {
                        if (value != "") {
                          if (_taskId == 0) return;
                          await cubit.updateTaskDescription(
                              id: _taskId, description: value.toString());
                          _taskDescription = value.toString();
                        }
                        _todoFocus.requestFocus();
                      },
                    ),
                    Visibility(
                      visible: _contentVisible,
                      child: FutureBuilder(
                        future: _dbHelper.getTodo(taskId: _taskId),
                        initialData: const <Todo>[],
                        builder:
                            (context, AsyncSnapshot<List<Todo>?> snapshot) {
                          final todoList = snapshot.data ?? [];
                          return Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return TodoWidget(
                                  todo: todoList[index],
                                  text: todoList[index].title,
                                  isDone: todoList[index].isDone == 0
                                      ? false
                                      : true,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    TodoRow(
                        contentVisible: _contentVisible,
                        todoFocus: _todoFocus,
                        todoController: todoController,
                        taskId: _taskId),
                  ],
                ),
                GradientFAB(
                  visible: _contentVisible,
                  icon: Icons.delete_forever_rounded,
                  primaryColor: AppColors.pinkColor,
                  secondaryColor: const Color(0xFFF54770),
                  onPressed: () async {
                    if (_taskId != 0) {
                      await cubit.deleteTask(id: _taskId);
                      Navigator.pop(context);
                    }
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
