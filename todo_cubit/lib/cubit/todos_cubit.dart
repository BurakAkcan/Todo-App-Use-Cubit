import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/data/model/todo.dart';

import 'package:todo/data/repository.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit({required this.repository}) : super(TodosInitial());
  final Repository repository;

  void fetchTodos() {
    try {
      //Buraya sahte bir bekleme koyduk
      emit(TodosLoading());
      Timer(Duration(seconds: 2), () {
        print('Timer finished');
        repository.fetchDatas().then((todos) {
          return emit(TodosLoaded(todoList: todos!));
        }).catchError((e) {
          emit(TodosError(message: '$e'));
        });
      });
    } catch (e) {
      emit(TodosError(message: 'Hata geldi $e'));
    }
  }

  void changeCompletion(Todo todo) {
    repository.changeCompletion(!todo.isCompleted!, todo.id ?? 1).then(
      (isChange) {
        if (isChange ?? false) {
          todo.isCompleted = !todo.isCompleted!;
          updateTodoList();
        }
      },
    );
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodosLoaded) {
      emit(TodosLoaded(todoList: currentState.todoList));
    }
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodosLoaded) {
      final todoList = currentState.todoList;
      todoList.add(todo);
      emit(TodosLoaded(todoList: todoList));
    }
  }

  void deleteTodo(Todo todo) {
    final currenState = state;
    if (currenState is TodosLoaded) {
      final todoList = currenState.todoList
          .where(
            (element) => element.id != todo.id,
          )
          .toList();

      emit(TodosLoaded(todoList: todoList));
    }
  }
}
