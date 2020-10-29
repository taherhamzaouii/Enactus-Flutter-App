import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manageus_flutter/Provider/ModalHud.dart';
import 'package:manageus_flutter/screens/User/UserHome.dart';
import 'package:manageus_flutter/screens/login_screen.dart';
import 'package:manageus_flutter/widgets/CustomTextField.dart';
import 'package:manageus_flutter/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  static String id='SignupScreen';
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  String _email, _password;
  final _auth = Auth();
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
                    height: MediaQuery.of(context).size.height*.24,
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
                  height: height*.04,
                ),
                CustomTextField(
                    controller: namecontroller,
                    icon: Icons.person,
                    hint: 'Enter Your Name'),
                SizedBox(
                  height: height*.015,
                ),

                CustomTextField(
                  controller: phonecontroller,
                  hint: 'Enter Phone Number',
                    icon: Icons.phone,
                  ),
                SizedBox(
                  height: height*.015,
                ),
                CustomTextField(
                  controller: emailcontroller,
                  onClick: (value){
                    _email=value;
                  },
                  hint: 'Enter Your Email',
                  icon: Icons.email,
                ),
                SizedBox(
                  height: height*.015,
                ),
                CustomTextField(
                  controller: passcontroller,
                  onClick: (value){
                    _password=value;
                  },
                    hint: 'Enter Your Password',
                    icon: Icons.lock,
                  ),
                SizedBox(
                  height: height*.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Builder(
                    builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () async {
                        _validate(context);
                      },
                      color: Colors.amber,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height*.016,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already have an account?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(' Login',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 16
                        ),
                      ),
                    )
                  ],
                )

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
      try {
        final authResult = await _auth.signUp(
            _email.trim(), _password.trim());
        Navigator.pushNamed(context, UserHome.id);
        modelhud.changeIsLoading(false);
      }  catch (e) {
        modelhud.changeIsLoading(false);
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(e.message),
        ));
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Something went wrong'
        ),
      ));
      }
    modelhud.changeIsLoading(false);
  }
  }





