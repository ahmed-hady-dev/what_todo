part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

//===============================================================
class DatabaseInitialized extends HomeState {}

//===============================================================
class InsertTaskLoadingState extends HomeState {}

class InsertTaskSuccessState extends HomeState {}

class InsertTaskFailedState extends HomeState {}

//===============================================================
class GetTasksLoadingState extends HomeState {}

class GetTasksSuccessState extends HomeState {}

class GetTasksFailedState extends HomeState {}

//===============================================================

class UpdateTaskTitleLoadingState extends HomeState {}

class UpdateTaskTitleSuccessState extends HomeState {}

class UpdateTaskTitleFailedState extends HomeState {}
//===============================================================

class UpdateTaskDescriptionLoadingState extends HomeState {}

class UpdateTaskDescriptionSuccessState extends HomeState {}

class UpdateTaskDescriptionFailedState extends HomeState {}

//===============================================================
class DeleteTaskLoadingState extends HomeState {}

class DeleteTaskSuccessState extends HomeState {}

class DeleteTaskFailedState extends HomeState {}

//===============================================================
class InsertTodoLoadingState extends HomeState {}

class InsertTodoSuccessState extends HomeState {}

class InsertTodoFailedState extends HomeState {}
//===============================================================

class GetTodoLoadingState extends HomeState {}

class GetTodoSuccessState extends HomeState {}

class GetTodoFailedState extends HomeState {}
//===============================================================

class UpdateTodoLoadingState extends HomeState {}

class UpdateTodoSuccessState extends HomeState {}

class UpdateTodoFailedState extends HomeState {}
