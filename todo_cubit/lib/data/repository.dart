import 'package:todo/data/model/todo.dart';
import 'package:todo/data/network_service.dart';

class Repository {
  final NetworkService networkService;
  Repository({required this.networkService});
  Future<List<Todo>?> fetchDatas() async {
    final todos = await networkService.getDatas();
    List<Todo> todoList = todos!
        .map(
          (e) => Todo.fromJson(e),
        )
        .toList();

    return todoList;
  }

  Future<bool?> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo?> addTodo(String message) async {
    final todoObj = {"todo": message, "isCompleted": "false"};
    final todoMap = await networkService.addTodo(todoObj);
    if (todoMap == null) return null;
    return Todo.fromJson(todoMap);
  }

  Future<bool?> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool?> updateTodo(String text, int id) async {
    final patchObj = {"todo": text};
    return await networkService.patchTodo(patchObj, id);
  }
}
