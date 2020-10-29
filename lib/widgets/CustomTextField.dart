import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String hint;
  final IconData icon;
  final Function onClick;
  final TextEditingController controller;

  String _errorMessage(String str) {
    switch (hint) {
      case 'Enter Your Name':
        return 'Please Enter Name';
      case 'Enter Your Password':
        return 'Please Enter Password';
      case 'Enter Your Email':
        return 'Please Enter Email';
      case 'Enter Phone Number':
        return 'Please Enter Phone Number';
    }
  }

  CustomTextField({@required this.controller, @required this.onClick, @required this.icon, @required this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
          }
        },
        controller: controller,
        onSaved: onClick,
        obscureText: hint == 'Enter Your Password' ? true : false,
        cursorColor: Colors.amber,
        // style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: Colors.amber,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
