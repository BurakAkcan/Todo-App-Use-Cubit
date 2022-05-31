import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:todo/cubit/todos_cubit.dart';
import 'package:todo/data/model/todo.dart';
import 'package:todo/data/repository.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  EditTodoCubit({required this.repository, required this.todosCubit})
      : super(EditTodoInitial());
  final Repository repository;
  final TodosCubit todosCubit;

  void delete(Todo todo) {
    repository.deleteTodo(todo.id!).then(
      (isDelete) {
        if (isDelete ?? false) {
          todosCubit.deleteTodo(todo);
          emit(EditTodoEdited());
        }
      },
    );
  }

  void updateTodo(Todo todo, String text) {
    if (text.isEmpty) {
      emit(EditTodoError(error: 'Alan boş bırakılamaz'));
    } else {
      repository.updateTodo(text, todo.id!).then(
        (isEdited) {
          if (isEdited!) {
            todo.todoMessage = text;
            todosCubit.updateTodoList();
            emit(EditTodoEdited());
          }
        },
      );
    }
  }
}
