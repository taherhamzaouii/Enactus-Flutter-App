import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHome extends StatelessWidget {
  static String id='UserHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text (
          'Im a User',
          style: TextStyle(
              fontSize: 40
          ),
        ),
      ),
    );
  }




}


