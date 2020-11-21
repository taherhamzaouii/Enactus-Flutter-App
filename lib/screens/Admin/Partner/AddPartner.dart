
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:manageus_flutter/Models/Data.dart';
import 'package:manageus_flutter/Models/Project.dart';
import 'package:manageus_flutter/screens/Admin/PartnersScreen.dart';
import 'package:manageus_flutter/screens/Admin/ProjectsScreen.dart';
import 'package:manageus_flutter/services/ApiClient.dart';
import 'package:manageus_flutter/widgets/CustomTextField.dart';
import 'package:image_picker/image_picker.dart';
class AddPartner  extends StatefulWidget {

  static String id = 'AddPartner';

  @override
  _AddPartnerState createState() => _AddPartnerState();
}

class _AddPartnerState extends State<AddPartner> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController categorycontroller = TextEditingController();
  Map<String, dynamic> projects;
  String _name, _description, _location, _category;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  File _image;
  final picker = ImagePicker();
  bool _status = true;
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: new Stack(fit: StackFit.loose, children: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: _image == null ? Image(image: AssetImage(
                          'images/icons/add-image.jpg'),fit: BoxFit.cover,) :  Image.file(_image),

                    ),
                  ],
                ),
                GestureDetector(onTap: onChangeImage,
                  child: Padding(
                      padding: EdgeInsets.only(top: 90.0, right: 100.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 25.0,
                            child: new Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                ),
              ]),
            ),
            CustomTextField(
                controller: namecontroller,
                onClick: (_value){
                  _value = _name;
                },
                icon: Icons.architecture,
                hint:'Project Name'),
            SizedBox(height: 15,),
            CustomTextField(
                controller: desccontroller,
                onClick: (_value){
                  _value = _description;
                },
                icon: Icons.description, hint: 'Project Description'),
            SizedBox(height: 15,),
            CustomTextField(controller: locationcontroller,
                onClick: (_value){
                  _value = _location;
                },
                icon: Icons.location_on_rounded, hint: 'Project Location'),
            SizedBox(height: 15,),
            CustomTextField(controller: categorycontroller,
                onClick: (_value){
                  _value = _category;
                },
                icon: Icons.category, hint: 'Project Category'),
            SizedBox(height: 15,),

            RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              onPressed: () async {
                if(_globalKey.currentState.validate()){
                  _globalKey.currentState.save();
                  ApiClient api = ApiClient();
                  print(namecontroller.text);
                  projects = {
                    "name" : namecontroller.text.toString(),
                    "description" : desccontroller.text.toString(),
                    "location" : locationcontroller.text.toString(),
                    "image":base64Encode(_image.readAsBytesSync()),
                    "filename":_image.path.split('/').last,
                    "category" : categorycontroller.text.toString(),
                  };
                  bool isSaved = await api.addProject(projects);
                  Project pr = Project(233, namecontroller.text, desccontroller.text , locationcontroller.text, categorycontroller.text, "uploads/"+projects["filename"] );
                  Data.projects.add(pr);
                  Navigator.pushNamed(context, PartnersScreen.id);
                }
              },
              child: Text('Add Project')
              ,
            ),
          ],
        ),
      ),
    );
  }

  onChangeImage(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.image),
                    title: new Text('Gallery'),
                    onTap: ()   async {
                      Navigator.of(context).pop();
                      final pickedFile = await picker.getImage(source: ImageSource.gallery);

                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }
                      });

                    }
                ),
                new ListTile(
                  leading: new Icon(Icons.camera_alt),
                  title: new Text('Camera'),
                  onTap: ()  async {
                    Navigator.of(context).pop();
                    final pickedFile = await picker.getImage(source: ImageSource.camera);

                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                      } else {
                        print('No image selected.');
                      }
                    });
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}


