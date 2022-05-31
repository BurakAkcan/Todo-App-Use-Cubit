import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/constants/strings.dart';
import 'package:todo/cubit/tema_cubit.dart';
import 'package:todo/cubit/todos_cubit.dart';
import 'package:todo/data/model/todo.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.read<TemaCubit>().changeTheme();
          },
          icon: Icon(Icons.brightness_6_outlined),
        ),
        title: Text('Todos'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ADD_TODO_ROUTE);
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is TodosError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is TodosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodosLoaded) {
            List<Todo> notListem = state.todoList;
            return ListView.builder(
              itemCount: notListem.length,
              itemBuilder: (BuildContext context, int index) {
                return myDismis(notListem, index, context);
              },
            );
          } else {
            return const Center(
              child: Text('Liste Boş'),
            );
          }
        },
      ),
    );
  }

  InkWell myDismis(List<Todo> notListem, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EDIT_TODO_ROUTE,
            arguments: notListem[index]);
      },
      child: Dismissible(
        confirmDismiss: (direction) async {
          BlocProvider.of<TodosCubit>(context)
              .changeCompletion(notListem[index]);
          return false;
        },
        background: Container(color: Colors.indigo),
        key: Key('${notListem[index]}'),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                notListem[index].todoMessage.toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
              _completionIndicator(notListem[index]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _completionIndicator(Todo todo) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              width: 4, color: todo.isCompleted! ? Colors.green : Colors.red)),
    );
  }
}
