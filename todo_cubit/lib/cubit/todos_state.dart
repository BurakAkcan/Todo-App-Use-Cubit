part of 'todos_cubit.dart';

@immutable
abstract class TodosState {}

class TodosInitial extends TodosState {}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  final List<Todo> todoList;

  TodosLoaded({required this.todoList});
}

class TodosError extends TodosState {
  final String message;
  TodosError({
    required this.message,
  });
}
