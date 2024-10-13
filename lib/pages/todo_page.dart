import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/todo_database.dart';
import 'package:todo_app/utils/dialog_box.dart';
import 'package:todo_app/utils/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

// text editing controller
TextEditingController _myController = TextEditingController();

class _TodoPageState extends State<TodoPage> {
// reference the hive box
  final _myBox = Hive.box('mybox');
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
// if app is opened for the first time. then run this method
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    }
    super.initState();
  }

//todo list
  // List<Todo> todos = [
  //   Todo(name: 'play football', completed: false),
  //   Todo(name: 'buy beans and bread', completed: false),
  // ];

  //checkbox tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      db.todos[index].completed = value ?? false;
    });
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.todos.add(Todo(name: _myController.text, completed: false));
      _myController.clear();

      Navigator.of(context).pop();
    });
  }

  //create new task method
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _myController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // delete task
  void deletask(int index) {
    setState(() {
      db.todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.todos[index].name,
            taskCompleted: db.todos[index].completed,
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (p0) => deletask(index),
          );
        },
        itemCount: db.todos.length,
      ),
      backgroundColor: Colors.green,
    );
  }
}

// class Todo {
//   String name;
//   bool completed;

//   Todo({required this.name, required this.completed});
// }
