import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; //formateo hora

File image;
String filename;

class MyUpdatePage extends StatefulWidget {
  static String id = 'UpdateProject';
  final DocumentSnapshot ds;
  MyUpdatePage({this.ds});
  @override
  _MyUpdatePageState createState() => _MyUpdatePageState();
}

class _MyUpdatePageState extends State<MyUpdatePage> {
  String productImage;
  TextEditingController descInputController;
  TextEditingController nameInputController;
  TextEditingController categoryInputController;
  TextEditingController locationInputController;
  TextEditingController imageInputController;

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String desc;
  String location;
  String category;

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
    productImage = widget.ds.data()["image"]; //nuevo
    print(productImage); //nuevo
  }

  /*
  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('colrecipes')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      // print(e);
    });
  }
  */

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection("Projects").getDocuments();
    // print();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    getPosts();
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
                      Padding(
                        padding: const EdgeInsets.only(left: 2.2),
                        child: new Container(
                          height: 0.0,
                          width: 0.0,
                          padding: new EdgeInsets.all(5.0),
                          child: productImage == ''
                              ? Text('Edit')
                              : Image.network(productImage + '?alt=media'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Divider(),
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
                      controller: nameInputController,
                      decoration: InputDecoration(
                        hintText: "Enter Project Name",
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
                      controller: descInputController,
                      decoration: InputDecoration(
                        hintText: "Enter Project Description",
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
                          return 'Please enter project desc';
                        }
                      },
                      onSaved: (value) => desc = value,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: TextFormField(
                      controller: locationInputController,
                      decoration: InputDecoration(
                        hintText: "Enter Project Location",
                        prefixIcon: Icon(
                          Icons.location_on_rounded,
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
                          return 'Please enter project location';
                        }
                      },
                      onSaved: (value) => location = value,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    child: TextFormField(
                      controller: categoryInputController,
                      decoration: InputDecoration(
                        hintText: "Enter Project Category",
                        prefixIcon: Icon(
                          Icons.category,
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
                          return 'Please enter project category';
                        }
                      },
                      onSaved: (value) => category = value,
                    ),
                  )

                ],
              ),
            ),
          ),
          SizedBox(height: 15,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text('Update'),
                onPressed: () {
                  DateTime now = DateTime.now();
                  String nuevoformato =
                  DateFormat('kk:mm:ss:MMMMd').format(now);
                  var fullImageName = 'nomfoto-$nuevoformato' + '.jpg';
                  var fullImageName2 = 'nomfoto-$nuevoformato' + '.jpg';

                  // final StorageReference ref =
                  // FirebaseStorage.instance.ref().child(fullImageName);
                  // final StorageUploadTask task = ref.putFile(image);

                  var part1 =
                      'https://firebasestorage.googleapis.com/v0/b/enactus-5d1fa.appspot.com/o/'; //esto cambia segun su firestore

                  var fullPathImage = part1 + fullImageName2;
                  print(fullPathImage);
                  Firestore.instance
                      .collection('Projects')
                      .document(widget.ds.documentID)
                      .updateData({
                    'name': nameInputController.text,
                    'desc': descInputController.text,
                    'location': locationInputController.text,
                    'category': categoryInputController.text,
                    'image': '$fullPathImage'
                  });
                  Navigator.of(context).pop(); //regrese a la pantalla anterior
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
