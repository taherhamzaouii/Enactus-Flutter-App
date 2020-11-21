import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; //formateo hora
import 'package:firebase_storage/firebase_storage.dart';
import 'package:manageus_flutter/widgets/CustomTextField.dart';

File image;
String filename;

void main() {
  runApp(MaterialApp(
    home: AddP(),
  ));
}

class AddP extends StatelessWidget {
  static String id = 'AddP';

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Add Page',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyAddPage(),
    );
  }
}

class CommonThings {
  static Size size;
}

class MyAddPage extends StatefulWidget {
  @override
  _MyAddPageState createState() => _MyAddPageState();
}

class _MyAddPageState extends State<MyAddPage> {
  TextEditingController projectInputController ;
  TextEditingController nameInputController;
  TextEditingController imageInputController;

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String project;

  pickerCam() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  pickerGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = img;
      setState(() {});
    }
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  void createData() async {
    DateTime now = DateTime.now();
    String nuevoformato = DateFormat('kk:mm:ss:MMMMd').format(now);
    var fullImageName = 'nomfoto-$nuevoformato' + '.jpg';
    var fullImageName2 = 'nomfoto-$nuevoformato' + '.jpg';


    var part1 =
        'https://firebasestorage.googleapis.com/v0/b/enactus-5d1fa.appspot.com/o/';
    var fullPathImage = part1 + fullImageName2;
    print(fullPathImage);

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DocumentReference ref = await db.collection('Partners').add(
          {'name': '$name', 'project': '$project', 'image': '$fullPathImage'});
      setState(() => id = ref.documentID);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonThings.size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        height: 200.0,
                        width: 200.0,
                        padding: new EdgeInsets.all(5.0),
                        child: image == null ? Text('Add') : Image.file(image),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new IconButton(
                          color: Colors.amber,
                          icon: new Icon(Icons.camera_alt), onPressed: pickerCam),
                      Divider(),
                      new IconButton(
                          color: Colors.amber,
                          icon: new Icon(Icons.image), onPressed: pickerGallery),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Partner Name",
                        prefixIcon: Icon(
                          Icons.architecture,
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      onSaved: (value) => name = value,
                    ),

                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter Project Name",
                        prefixIcon: Icon(
                          Icons.account_balance,
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      onSaved: (value) => project = value,
                    ),

                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                onPressed: createData,
                child: Text('Add Partner', style: TextStyle(color: Colors.white)),
              ),
            ],)
        ],
      ),
    );
  }
}
