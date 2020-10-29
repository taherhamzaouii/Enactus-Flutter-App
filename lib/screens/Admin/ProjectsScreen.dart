import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  static String id = 'ProjectsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Text(
      'Projects',
      style: TextStyle(
          color: Colors.white,
        fontSize: 30,
      ),
      ),
    );
  }
}