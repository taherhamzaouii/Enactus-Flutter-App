import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manageus_flutter/Models/Data.dart';
import 'package:manageus_flutter/Models/Project.dart';
import 'package:manageus_flutter/constants.dart';
import 'package:manageus_flutter/screens/Admin/Project/AddProject.dart';


class ProjectsScreen extends StatefulWidget {
  static String id = 'ProjectsScreen';

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, AddProject.id);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),

        ),
        elevation: 5,
        highlightElevation: 10,
      ),

      backgroundColor: Colors.black,
      body: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 1
                ),

                itemBuilder:
                    (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.network(
                          "http://192.168.1.17:3001/" + Data.projects[index].image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .4,
                          child: Container(

                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(Data.projects[index].name),
                                Text(Data.projects[index].location)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                itemCount: Data.projects.length,
      ),
    );
  }


}










