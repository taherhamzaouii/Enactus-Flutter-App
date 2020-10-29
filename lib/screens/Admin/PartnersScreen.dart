import 'package:flutter/material.dart';

class PartnerScreen extends StatelessWidget {
  static String id = 'PartnerScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Text(
        'Partner',
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}