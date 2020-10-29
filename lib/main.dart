import 'package:flutter/material.dart';
import 'package:manageus_flutter/Provider/AdminMode.dart';
import 'package:manageus_flutter/Provider/ModalHud.dart';
import 'package:manageus_flutter/screens/Admin/MembersScreen.dart';
import 'package:manageus_flutter/screens/Admin/PartnersScreen.dart';
import 'package:manageus_flutter/screens/Admin/ProjectsScreen.dart';
import 'package:manageus_flutter/screens/Admin/TasksScreen.dart';
import 'package:manageus_flutter/screens/login_screen.dart';
import 'package:manageus_flutter/screens/signup_screen.dart';
import 'package:manageus_flutter/screens/Admin/AdminHome.dart';
import 'package:manageus_flutter/screens/User/UserHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }


  class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
    ChangeNotifierProvider<ModalHud>(
    create: (context) => ModalHud(),
    ),
    ChangeNotifierProvider<AdminMode>(
    create: (context) => AdminMode(),
    ),

        ],
      child: MaterialApp(
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          SignupScreen.id: (context) => SignupScreen(),
          AdminHome.id: (context) => AdminHome(),
          UserHome.id: (context) => UserHome(),
          MembersScreen.id: (context) => MembersScreen(),
          PartnerScreen.id: (context) => PartnerScreen(),
          TasksScreen.id: (context) => TasksScreen(),
          ProjectsScreen.id: (context) => ProjectsScreen(),
        },
      ),

    );
  }


}
