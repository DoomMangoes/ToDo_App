import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screens/editTodoPage.dart';
import '../Provider/toDoProvider.dart';
import '../models/toDoItem.dart';
import '../utils.dart';

class ToDoWidget extends StatelessWidget {
  final ToDoItem toDo;
  const ToDoWidget({super.key, required this.toDo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditTodoPage(
                      toDo: toDo,
                    )));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTodoPage(
                                toDo: toDo,
                              )));
                },
                backgroundColor: Colors.green,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  context.read<ToDoProvider>().remove(toDo);

                  Utils.showSnackBar(context, "Deleted the task");
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                    activeColor: Colors.pink,
                    checkColor: Colors.white,
                    value: toDo.isDone,
                    onChanged: (_) {
                      final provider =
                          Provider.of<ToDoProvider>(context, listen: false);
                      final isDone = provider.changeStatus(toDo);

                      Utils.showSnackBar(context,
                          isDone ? "Task completed" : "Task marked incomplete");
                    }),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        toDo.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontSize: 22,
                        ),
                      ),
                      if (toDo.description.isNotEmpty)
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Text(
                            toDo.description,
                            style: TextStyle(fontSize: 20, height: 1.5),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
