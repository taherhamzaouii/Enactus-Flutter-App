import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  static String id = 'MembersScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Text(
        'Members',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}