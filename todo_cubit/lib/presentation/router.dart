import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/constants/strings.dart';
import 'package:todo/cubit/add_todo_cubit.dart';
import 'package:todo/cubit/edit_todo_cubit.dart';
import 'package:todo/cubit/todos_cubit.dart';
import 'package:todo/data/model/todo.dart';
import 'package:todo/data/network_service.dart';
import 'package:todo/data/repository.dart';
import 'package:todo/presentation/screens/add_todo_screen.dart';
import 'package:todo/presentation/screens/edit_todo_screen.dart';
import 'package:todo/presentation/screens/todos_screen.dart';

class AppRouter {
  Repository? repository;
  TodosCubit? todosCubit;
  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository!);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Home_Page_Route:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: todosCubit!,
            child: TodosScreen(),
          ),
        );

      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todo;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                EditTodoCubit(repository: repository!, todosCubit: todosCubit!),
            child: EditTodoScreen(
              todo: todo,
            ),
          ),
        );

      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AddTodoCubit(todosCubit!, repository: repository!),
            child: AddTodoScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body:
                Center(child: Text('Sayfa route generate kısmında hata aldı')),
          ),
        );
    }
  }
}
