import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/toDoProvider.dart';
import 'package:todoapp/models/toDoItem.dart';
import 'ToDoWidget.dart';

class ToDoListWidget extends StatelessWidget {
  final bool completed;
  const ToDoListWidget({super.key, required this.completed});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    final UnmodifiableListView<ToDoItem> toDoItems =
        completed ? provider.itemsCompleted : provider.items;

    return toDoItems.isEmpty
        ? Center(
            child: Text(completed ? "No completed todos" : "No todos"),
          )
        : ListView.separated(
            padding: EdgeInsets.all(16),
            physics: BouncingScrollPhysics(),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: toDoItems.length,
            itemBuilder: (BuildContext context, int index) {
              return ToDoWidget(
                toDo: toDoItems[index],
              );
            });
  }
}
