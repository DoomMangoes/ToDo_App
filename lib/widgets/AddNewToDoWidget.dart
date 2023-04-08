import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/toDoProvider.dart';
import 'package:todoapp/models/toDoItem.dart';

import '../utils.dart';

class AddNewToDoWidget extends StatefulWidget {
  const AddNewToDoWidget({super.key});

  @override
  State<AddNewToDoWidget> createState() => _AddNewToDoWidgetState();
}

class _AddNewToDoWidgetState extends State<AddNewToDoWidget> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
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
    return Column(
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
                  final newItem =
                      ToDoItem(title: titleText, description: descriptionText);
                  context.read<ToDoProvider>().add(newItem);

                  Navigator.of(context).pop();
                  Utils.showSnackBar(context, "Added new todo");
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
    );
  }
}
