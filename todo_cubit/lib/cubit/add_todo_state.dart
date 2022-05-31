part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}

class AddTodoIError extends AddTodoState {
  final String error;

  AddTodoIError({required this.error});
}

class AddingTodo extends AddTodoState {}

class AddedTodo extends AddTodoState {}
