import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/toDoProvider.dart';
import 'package:todoapp/screens/editTodoPage.dart';
import 'models/toDoItem.dart';
import 'screens/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ToDoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // Application theme data, you can set the colors for the application as
        // you want
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Color(0xFFF6F5EE),
        ),
        // A widget which will be started on application startup
        home: HomePage(),
      ),
    );
  }
}
