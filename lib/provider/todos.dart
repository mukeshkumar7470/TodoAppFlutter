import 'package:flutter/material.dart';
import 'package:todo_app_flutter/models/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Buy Food 😋',
      description: '''- Eggs
- Milk
- Bread
- Water''', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan family trip to Norway',
      description: '''- Rent some hotels
- Rent a car
- Pack suitcase''', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog 🐕', id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan Jacobs birthday party 🎉🥳', id: '',
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
}