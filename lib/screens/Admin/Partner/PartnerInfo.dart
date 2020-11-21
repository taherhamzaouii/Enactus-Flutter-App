import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyInfoPage extends StatefulWidget {
  static String id = 'UpdatePartner';
  final DocumentSnapshot ds;
  MyInfoPage({this.ds});
  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  String productImage;
  String id;
  String name;
  String project;

  TextEditingController nameInputController;
  TextEditingController projectInputController;

  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Partners").getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    projectInputController =
    new TextEditingController(text: widget.ds.data()["project"]);
    nameInputController =
    new TextEditingController(text: widget.ds.data()["name"]);
    productImage = widget.ds.data()["image"];
    print(productImage);
  }



  @override
  Widget build(BuildContext context) {
    getPost();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      height: 300.0,
                      width: 300.0,
                      padding: new EdgeInsets.all(5.0),
                      child: productImage == ''
                          ? Text('Edit')
                          : Image.network(productImage + '?alt=media'),
                    ),
                  ],
                ),
                new IniciarIcon(),
                new ListTile(
                  leading: const Icon(Icons.person, color: Colors.amber),
                  title: new TextFormField(
                    controller: nameInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "Partner Name", labelText: "Partner Name"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                new ListTile(
                  leading: const Icon(Icons.list, color: Colors.amber),
                  title: new TextFormField(
                    controller: projectInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "Project", labelText: "Project"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


class IniciarIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[

        ],
      ),

    );
  }
}

class IconoMenu extends StatelessWidget {
  IconoMenu({this.icon, this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Column(
        children: <Widget>[
          new Icon(
            icon,
            size: 50.0,
            color: Colors.blue,
          ),
          new Text(
            label,
            style: new TextStyle(fontSize: 12.0, color: Colors.blue),
          )
        ],
      ),
    );
  }
}
