import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/add_todo_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        centerTitle: true,
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        //Listener yapısı kullanarak eğer yapılacaklar eklernirse geriye git dedik
        listener: (context, state) {
          if (state is AddedTodo) {
            Navigator.of(context).pop();
          } else if (state is AddTodoIError) {
            Fluttertoast.showToast(
                msg: 'Boş not...',
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16,
                toastLength: Toast.LENGTH_SHORT);
            //Toast mesagge kullanımı package ile

          }
        },
        child: Container(
          margin: EdgeInsets.all(20),
          child: _myBody(context),
        ),
      ),
    );
  }

  Widget _myBody(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
              hintText: 'Yapılacaklar listesini giriniz...'),
        ),
        const SizedBox(
          height: 14,
        ),
        InkWell(
            child: _addBtn(context),
            onTap: () {
              final message = _controller.text;
              BlocProvider.of<AddTodoCubit>(context).addTodo(message);
            }),
      ],
    );
  }

  Widget _addBtn(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: BlocBuilder<AddTodoCubit, AddTodoState>(
              builder: (context, state) {
            if (state is AddingTodo)
              return const Center(
                child: CircularProgressIndicator(),
              );
            return const Text(
              'Yapılacak Ekle',
              style: TextStyle(color: Colors.white),
            );
          }),
        ));
  }
}
