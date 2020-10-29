import 'package:flutter/material.dart';
import 'package:manageus_flutter/Provider/AdminMode.dart';
import 'package:manageus_flutter/screens/signup_screen.dart';
import 'package:manageus_flutter/widgets/CustomTextField.dart';
import 'package:manageus_flutter/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:manageus_flutter/Provider/ModalHud.dart';

import 'Admin/AdminHome.dart';
import 'User/UserHome.dart';



class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email, _password;
  final adminPass='admin12345', adminEmail='admin@manageus.com';
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  bool isAdmin = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/icons/logo.png'),
                        height: 140,
                      ),
                      // Text(
                      //   'ManageUs',
                      //   style: TextStyle(
                      //     fontFamily: 'Tillium Web',
                      //     fontSize: 25,
                      //     color: Colors.white
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .04,
              ),

              CustomTextField(
                onClick: (value){
                  _email=value;
                },
                hint: 'Enter Your Email',
                icon: Icons.email,
                controller: emailcontroller,
              ),
              SizedBox(
                height: height * .015,
              ),
              CustomTextField(
                onClick: (value){
                  _password=value;
                },
                hint: 'Enter Your Password',
                icon: Icons.lock,
                controller: passcontroller,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Builder(
                  builder:(context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                     _validate(context);
                    },
                    color: Colors.amber,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .016,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Dont have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    child: Text(
                      ' Signup',
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModalHud>(context, listen: false);
    modelhud.changeIsLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
        if (_password == adminPass) {
          try {
           await _auth.signIn(_email.trim(), _password.trim());
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelhud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        }
       else {
        try {
          await _auth.signIn(_email.trim(), _password.trim());
          Navigator.pushNamed(context, UserHome.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeIsLoading(false);
  }
  }



