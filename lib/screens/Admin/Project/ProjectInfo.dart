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
  String name;
  String desc;
  String location;
  String category;

  TextEditingController descInputController;
  TextEditingController nameInputController;
  TextEditingController categoryInputController;
  TextEditingController locationInputController;

  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Projects").getDocuments();
    return qn.documents;
  }

  @override
  void initState() {
    super.initState();
    descInputController =
    new TextEditingController(text: widget.ds.data()["desc"]);
    locationInputController =
    new TextEditingController(text: widget.ds.data()["location"]);
    categoryInputController =
    new TextEditingController(text: widget.ds.data()["category"]);
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
                  leading: const Icon(Icons.architecture, color: Colors.amber),
                  title: new TextFormField(
                    controller: nameInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "Project Name", labelText: "Project Name"),
                  ),
                ),

                new ListTile(
                  leading: const Icon(Icons.list, color: Colors.amber),
                  title: new TextFormField(
                    controller: descInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "Description", labelText: "Description"),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.location_on_rounded, color: Colors.amber),
                  title: new TextFormField(
                    controller: locationInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "Location", labelText: "Location"),
                  ),
                ),
                new ListTile(
                  leading: const Icon(Icons.category, color: Colors.amber),
                  title: new TextFormField(
                    controller: categoryInputController,
                    validator: (value) {
                      if (value.isEmpty) return "Ingresa un nombre";
                    },
                    decoration: new InputDecoration(
                        hintText: "Category", labelText: "Category"),
                  ),
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
