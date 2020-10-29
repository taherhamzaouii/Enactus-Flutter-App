import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  static String id = 'TasksScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Text(
        'Tasks',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}