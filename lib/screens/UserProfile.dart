import 'package:flutter/material.dart';
import 'package:manageus_flutter/screens/login_screen.dart';
import 'package:manageus_flutter/services/auth.dart';
import 'package:manageus_flutter/widgets/CustomTextField.dart';

class UserProfile extends StatelessWidget {
  static String id = 'UserProfile';
  final _auth = Auth();
  String _email;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
                controller: emailController,
                onClick: (_value) {
                  _value = _email;
                },
                icon: Icons.email,
                hint: 'Enter your Email'),
            SizedBox(height: 15,),

            RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              onPressed: () async {

                if(_globalKey.currentState.validate()){

                  await _auth.sendPasswordResetEmail(emailController.text);
                }
              },

              child: Text('Reset Password')
              ,
            ),
            RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              onPressed: () async {
                     await _auth.signOut();
                      Navigator.pushNamed(context, LoginScreen.id);              },
              child: Text('Sign Out')
              ,
            ),
          ],
        ),
      ),
    );
  }
}


//
//   @override
//   Widget build(BuildContext context) {
//      return SingleChildScrollView(
//          child: Padding(
//            padding: EdgeInsets.only(top: 300),
//            child: Column(
//              children: <Widget>[
//                // FutureBuilder(
//                //     future: _auth.getCurrentUser(),
//                //      builder: (context,snapshot){
//                //       // if (snapshot.connectionState == ConnectionState.done){
//                //       //   return Text("${snapshot.data}");
//                //       // } else {
//                //       //   return CircularProgressIndicator();
//                //       // }
//                //      },
//                // ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 100),
//                  child: FlatButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)),
//                    onPressed: () async {
//                       await _auth.signOut();
//                       Navigator.pushNamed(context, LoginScreen.id);
//                    },
//                    color: Colors.amber,
//                    child: Text(
//                      'Sign Out',
//                      style: TextStyle(color: Colors.black),
//                    ),
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 100),
//                  child: FlatButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)),
//                    onPressed: () async {
//                      await _auth.sendPasswordResetEmail(_email);
//                      Navigator.pushNamed(context, LoginScreen.id);
//                    },
//                    color: Colors.amber,
//                    child: Text(
//                      'Reset Password',
//                      style: TextStyle(color: Colors.black),
//                    ),
//                  ),
//                ),
//                CustomTextField(
//                    controller: emailController,
//                    onClick: (_value){
//                      _value = _email;
//                    },
//                    icon: Icons.email,
//                    hint:'Enter your Email'),
//                SizedBox(height: 15,),
//
//              ],
//            ),
//          ));
//   }
// }
