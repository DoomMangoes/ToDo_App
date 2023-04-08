import 'package:flutter/material.dart';
import 'package:todoapp/widgets/AddNewToDoWidget.dart';
import 'package:todoapp/widgets/ToDoListWidget.dart';
import 'package:todoapp/widgets/ToDoWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Center(
        child: ToDoListWidget(
          completed: false,
        ),
      ),
      Center(
        child: ToDoListWidget(
          completed: true,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text("Todo App"),
      ),
      body: tabs[current],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Add Todo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: AddNewToDoWidget(),
            );
          },
        ),
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: current,
        onTap: (index) => setState(() {
          current = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: "Todos"),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: "Completed"),
        ],
      ),
    );
  }
}
