import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/db_helper/database_helper.dart';
import '../../task/model/task_model.dart';
import '../../task/model/todo_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

//===============================================================
  final DatabaseHelper _dbHelper = DatabaseHelper();

//===============================================================
  @override
  Future<void> close() async {
    return super.close();
  }

//===============================================================
//*TASKS Methods*//
//===============================================================
  Future<int?> insertTask({required Task task}) async {
    emit(InsertTaskLoadingState());
    try {
      int? taskInsertedId = await _dbHelper.insertTask(task: task);
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
      return await _dbHelper.getTasks();
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
      await _dbHelper.updateTaskTitle(id: id, title: title);
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
      _dbHelper.updateTaskDescription(id: id, description: description);
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
      _dbHelper.deleteTask(id: id);
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
      _dbHelper.insertTodo(todo: todo);
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
      return await _dbHelper.getTodo(taskId: taskId);
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
      _dbHelper.updateTodoDone(id: id, isDone: isDone);
      emit(UpdateTodoSuccessState());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      emit(UpdateTodoFailedState());
    }
  }
//===============================================================

}
