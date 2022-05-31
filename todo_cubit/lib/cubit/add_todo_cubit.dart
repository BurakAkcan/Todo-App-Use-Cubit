import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/cubit/todos_cubit.dart';

import 'package:todo/data/repository.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(this.todosCubit, {required this.repository})
      : super(AddTodoInitial());
  final Repository repository;
  final TodosCubit todosCubit;

  void addTodo(String message) {
    if (message.isEmpty) {
      emit(AddTodoIError(error: 'İçerisi Boş '));
      return;
    }
    emit(AddingTodo());
    Timer(Duration(seconds: 2), () {
      repository.addTodo(message).then(
        (todo) {
          if (todo != null) {
            todosCubit.addTodo(todo);
            emit(AddedTodo());
          }
        },
      );
    });
  }
}
