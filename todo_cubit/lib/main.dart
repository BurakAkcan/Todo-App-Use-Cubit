import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/tema_cubit.dart';
import 'package:todo/presentation/router.dart';

import 'package:todo/presentation/screens/todos_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoApp(
    router: AppRouter(),
  ));
}

class TodoApp extends StatelessWidget {
  final AppRouter router;
  const TodoApp({
    Key? key,
    required this.router,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TemaCubit(),
      child: BlocBuilder<TemaCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            theme: state,
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            onGenerateRoute: router.generateRoute,
          );
        },
      ),
    );
  }
}
