import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ToDoItem {
  bool isDone;
  String title;
  String description;
  final String uuid;

  ToDoItem({required this.title, required this.description})
      : uuid = const Uuid().v4(),
        isDone = false;

  @override
  bool operator ==(covariant ToDoItem other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}
