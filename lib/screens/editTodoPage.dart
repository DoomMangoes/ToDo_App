import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/toDoItem.dart';
import '../Provider/toDoProvider.dart';
import '../utils.dart';

class EditTodoPage extends StatefulWidget {
  final ToDoItem toDo;

  const EditTodoPage({
    super.key,
    required this.toDo,
  });

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.toDo.title);
    _descriptionController =
        TextEditingController(text: widget.toDo.description);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<ToDoProvider>().remove(widget.toDo);
                Navigator.of(context).pop();

                Utils.showSnackBar(context, "Deleted the task");
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Title",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            TextField(
              maxLines: 1,
              controller: _titleController,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black.withOpacity(0.7),
              ),
            ),
            TextField(
              maxLines: 3,
              controller: _descriptionController,
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    final titleText = _titleController.text;
                    final descriptionText = _descriptionController.text;

                    if (titleText.isNotEmpty) {
                      context
                          .read<ToDoProvider>()
                          .updateItem(widget.toDo, titleText, descriptionText);

                      Navigator.of(context).pop();
                      Utils.showSnackBar(context, "Successfully edited todo");
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text("Cannot Add Empty Todo"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      child: Center(child: Text("Back"))),
                                ]);
                          });
                    }
                    ;
                  },
                  child: Text("Save")),
            ),
          ],
        ),
      ),
    );
  }
}
