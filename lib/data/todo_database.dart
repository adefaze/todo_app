import 'package:hive/hive.dart';

class TodoDatabase {
  // List todoList = [];

  //todo list
  List<Todo> todos = [
    Todo(name: 'play football', completed: false),
    Todo(name: 'buy beans and bread', completed: false),
  ];

  // reference the hive box

  final myBox = Hive.openBox('my box');
}

class Todo {
  String name;
  bool completed;

  Todo({required this.name, required this.completed});
}
