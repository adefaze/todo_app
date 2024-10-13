import 'package:hive/hive.dart';

class TodoDatabase {
  // List todoList = [];

  //todo list
  List<Todo> todos = [];

  // reference the hive box
  final _myBox = Hive.box('my box');

  //run this method if this is the first time open the app
  void createInitialData() {
    List<Todo> todos = [
      Todo(name: 'play football', completed: false),
      Todo(name: 'buy beans and bread', completed: false),
    ];
  }

  // load the data from database
  void loadData(){
    todos = _myBox.get('TODOLIST');

  }

  //update the databasw
  void updateDatabse(){
    _myBox.put('TODOLIST', todos);

  }
}



class Todo {
  String name;
  bool completed;

  Todo({required this.name, required this.completed});
}
