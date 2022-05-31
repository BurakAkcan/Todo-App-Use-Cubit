import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo/cubit/edit_todo_cubit.dart';

import '../../data/model/todo.dart';

class EditTodoScreen extends StatelessWidget {
  EditTodoScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final Todo todo;
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todoMessage!;
    return BlocListener<EditTodoCubit, EditTodoState>(
      listener: (context, state) {
        if (state is EditTodoEdited) {
          Navigator.of(context).pop();
        } else if (state is EditTodoError) {
          Fluttertoast.showToast(
              msg: 'Boş not...',
              gravity: ToastGravity.TOP,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16,
              toastLength: Toast.LENGTH_SHORT);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Not Güncelle'),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context).delete(todo);
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.delete),
              ),
            ),
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              autocorrect: true,
              decoration: InputDecoration(hintText: 'Yapılacakları girin...'),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<EditTodoCubit>(context)
                    .updateTodo(todo, _controller.text);
              },
              child: _updateBtn(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _updateBtn(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
          child: Text(
        'Yapılacakları Güncelle',
        style: TextStyle(color: Colors.white),
      )),
    );
  }
}
