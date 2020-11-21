import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:manageus_flutter/screens/Admin/AdminHome.dart';
import 'package:manageus_flutter/screens/Admin/MembersScreen.dart';
import 'package:manageus_flutter/screens/Admin/PartnersScreen.dart';
import 'package:manageus_flutter/screens/Admin/ProjectsScreen.dart';
import 'package:manageus_flutter/screens/Admin/TasksScreen.dart';
import 'package:manageus_flutter/screens/User/PartnersView.dart';
import 'package:manageus_flutter/screens/User/ProjectsView.dart';
import 'package:manageus_flutter/screens/User/TasksView.dart';
import 'package:manageus_flutter/services/auth.dart';

import '../UserProfile.dart';

class UserHome extends StatefulWidget {
  static String id='UserHome';

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final _auth = Auth();
  User _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ProjectsView.id);
                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        color: Colors.amber,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     offset: Offset(0, 2),
                        //     blurRadius: 6.0,
                        //   ),
                        // ],
                        image: DecorationImage(
                          image: AssetImage(
                            'images/icons/projects.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PartnersView.id);
                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        color: Colors.amber,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     offset: Offset(0, 2),
                        //     blurRadius: 6.0,
                        //   ),
                        // ],
                        image: DecorationImage(
                            image: AssetImage(
                              'images/icons/Group.png',
                            ),
                            fit: BoxFit.contain
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, TasksView.id);
                    },
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.rectangle,
                        color: Colors.amber,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey,
                        //     offset: Offset(0, 2),
                        //     blurRadius: 6.0,
                        //   ),
                        // ],
                        image: DecorationImage(
                          image: AssetImage(
                            'images/icons/taks.png',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:CurvedNavigationBar(
          color: Colors.amber,
          backgroundColor: Colors.black ,
          buttonBackgroundColor: Colors.white ,
          height: 50,
          items: <Widget>[
            Icon(Icons.home, size:40 , color:Colors.amber),
            Icon(Icons.account_circle, size:40 , color:Colors.amber),
            // Icon(Icons.exit_to_app, size:40 , color:Colors.amber),
          ],
          onTap: (index){
            if(index == 0){
              Navigator.pushNamed(context, UserHome.id);
            } else if (index == 1) {
              Navigator.pushNamed(context, UserProfile.id);
            }
            // } else {
            //     Navigator.pushNamed(context, LoginScreen.id);
            // }
          }
      ),
    );
  }
}


