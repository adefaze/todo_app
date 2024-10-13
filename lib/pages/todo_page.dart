import 'package:flutter/material.dart';
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
//todo list
  List<Todo> todos = [
    Todo(name: 'play football', completed: false),
    Todo(name: 'buy beans and bread', completed: false),
  ];

  //checkbox tapped
  void checkboxChanged(bool? value, int index) {
    setState(() {
      todos[index].completed = value ?? false;
    });
  }

  // save new task
  void saveNewTask() {
    setState(() {
      todos.add(Todo(name: _myController.text, completed: false));
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
      todos.removeAt(index);
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
            taskName: todos[index].name,
            taskCompleted: todos[index].completed,
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (p0) => deletask(index),
          );
        },
        itemCount: todos.length,
      ),
      backgroundColor: Colors.green,
    );
  }
}

class Todo {
  String name;
  bool completed;

  Todo({required this.name, required this.completed});
}
