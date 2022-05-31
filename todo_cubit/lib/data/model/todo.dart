class Todo {
  String? todoMessage;
  bool? isCompleted;
  int? id;

  Todo({this.todoMessage, this.isCompleted, this.id});

  Todo.fromJson(Map<String, dynamic> json) {
    todoMessage = json['todo'];
    isCompleted = json['isCompleted'] == "true";
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['todo'] = todoMessage;
    data['isCompleted'] = isCompleted;
    data['id'] = id;
    return data;
  }
}
