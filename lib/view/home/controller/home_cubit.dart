import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_todo/core/cacheHelper/cache_helper.dart';
import '../../../core/db_helper/database_helper.dart';
import '../../task/model/task_model.dart';
import '../../task/model/todo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

//===============================================================
  final DatabaseHelper dbHelper = DatabaseHelper();
  final TextEditingController nameController = TextEditingController();
  bool isSoundOn = true;
  late bool isFirst;
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();
  GlobalKey key5 = GlobalKey();

//===============================================================
  @override
  Future<void> close() async {
    nameController.dispose();
    return super.close();
  }

  //===============================================================
  void showCase({required bool? isFirstTime}) async {
    if (isFirstTime!) {
      await dbHelper.insertTask(
          task: Task(
              title: 'My wonderful day 🙌',
              description: 'To-do list to get the best out of the day ✨'));
      await dbHelper.insertTodo(
          todo: Todo(
        taskId: 1,
        title: 'Wake up at 7 am 🛏️.',
        isDone: 0,
      ));
      await dbHelper.insertTodo(
          todo: Todo(
        taskId: 1,
        title: 'Go to the Gym at 10 am 🏋️.',
        isDone: 0,
      ));
      await dbHelper.insertTodo(
          todo: Todo(
        taskId: 1,
        title: 'Finish the homework 📖.',
        isDone: 0,
      ));
      await CacheHelper.cacheShowCase(value: false);
    }
  }

  //===============================================================

  void changeSound({bool? soundFromCache}) async {
    if (soundFromCache != null) {
      isSoundOn = soundFromCache;
      emit(SoundChangeState());
    } else {
      isSoundOn = !isSoundOn;
      await CacheHelper.cacheSound(value: isSoundOn);
      emit(SoundChangeState());
    }
  }

//===============================================================
//*TASKS Methods*//
//===============================================================
  Future<int?> insertTask({required Task task}) async {
    emit(InsertTaskLoadingState());
    try {
      int? taskInsertedId = await dbHelper.insertTask(task: task);
      emit(InsertTaskSuccessState());
      return taskInsertedId;
    } catch (e) {
      debugPrint(e.toString());
      emit(InsertTaskFailedState());
    }
  }

//===============================================================
  Future<List<Task>?> getTasks() async {
    emit(GetTasksLoadingState());
    try {
      emit(GetTasksSuccessState());
      return await dbHelper.getTasks();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetTasksFailedState());
    }
  }

  //===============================================================
  Future<void> updateTaskTitle({required int id, required String title}) async {
    emit(UpdateTaskTitleLoadingState());
    try {
      await dbHelper.updateTaskTitle(id: id, title: title);
      emit(UpdateTaskTitleSuccessState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(UpdateTaskTitleFailedState());
    }
  }

  //===============================================================
  Future<void> updateTaskDescription(
      {required int id, required String description}) async {
    emit(UpdateTaskDescriptionLoadingState());
    try {
      dbHelper.updateTaskDescription(id: id, description: description);
      emit(UpdateTaskDescriptionSuccessState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(UpdateTaskDescriptionFailedState());
    }
  }

  //===============================================================
  Future<void> deleteTask({required int id}) async {
    emit(DeleteTaskLoadingState());
    try {
      dbHelper.deleteTask(id: id);
      emit(DeleteTaskSuccessState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(DeleteTaskFailedState());
    }
  }

//===============================================================
//*TODO Methods*//
//===============================================================
  Future<void> insertTodo({required Todo todo}) async {
    emit(InsertTodoLoadingState());
    try {
      dbHelper.insertTodo(todo: todo);
      emit(InsertTodoSuccessState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(InsertTodoFailedState());
    }
  }

//===============================================================
  Future<List<Todo>?> getTodo({required int taskId}) async {
    emit(GetTodoLoadingState());
    try {
      emit(GetTodoSuccessState());
      return await dbHelper.getTodo(taskId: taskId);
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(GetTodoFailedState());
    }
  }

//===============================================================
  Future<void> updateTodoDone({required int id, required int isDone}) async {
    emit(UpdateTodoLoadingState());
    try {
      dbHelper.updateTodoDone(id: id, isDone: isDone);
      emit(UpdateTodoSuccessState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(UpdateTodoFailedState());
    }
  }

//===============================================================
  Future<void> deleteTodo({required int todoId}) async {
    emit(DeleteTodoLoadingState());
    try {
      dbHelper.deleteTodo(todoId: todoId);
      emit(DeleteTodoSuccessState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(DeleteTodoFailedState());
    }
  }
}
