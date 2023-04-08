import 'package:flutter/material.dart';
import '../models/toDoItem.dart';
import 'dart:collection';

class ToDoProvider extends ChangeNotifier {
  final List<ToDoItem> _items = [
    ToDoItem(title: "Never gonna", description: "give you up"),
    ToDoItem(title: "Somebody", description: "once told me"),
  ];

  //Read only view
  UnmodifiableListView<ToDoItem> get items =>
      UnmodifiableListView(_items.where((item) => item.isDone == false));

  UnmodifiableListView<ToDoItem> get itemsCompleted =>
      UnmodifiableListView(_items.where((item) => item.isDone == true));

  void add(ToDoItem toDoItem) {
    _items.add(toDoItem);
    notifyListeners();
  }

  void remove(ToDoItem toDoItem) {
    _items.remove(toDoItem);
    notifyListeners();
  }

  bool changeStatus(ToDoItem toDoItem) {
    toDoItem.isDone = !toDoItem.isDone;
    notifyListeners();

    return toDoItem.isDone;
  }

  void updateItem(ToDoItem toDoItem, String newTitle, String newDescription) {
    toDoItem.title = newTitle;
    toDoItem.description = newDescription;

    notifyListeners();
  }
}
