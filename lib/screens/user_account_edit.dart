import 'dart:io';

import 'package:aduaba_app/model/user.dart';
import 'package:aduaba_app/widgets/profile_formField.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utilities/constants.dart';

class UserAccountEdit extends StatefulWidget {
  UserAccountEdit({Key key}) : super(key: key);

  @override
  _UserAccountEditState createState() => _UserAccountEditState();
}

class _UserAccountEditState extends State<UserAccountEdit> {
  final _formKey = GlobalKey<FormState>();
  User user = User();
  String _firstName;
  String _lastName;
  String _phoneNumber;
  File _image;
  String imagePath;
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      imagePath = image.path;
      _image = image;
      imageAdded = true;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      imagePath = image.path;
      imageAdded = true;
      _image = image;
    });
  }

  bool imageAdded = false;
  removeImage() {
    setState(() {
      imageAdded = false;
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _firstName = new TextEditingController();
    TextEditingController _lastName = new TextEditingController();
    TextEditingController _phoneNumber = new TextEditingController();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xFF424347),
                    size: 35,
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  "Edit Profile",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF819272),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,start
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: _image != null
                                  ? FileImage(
                                      _image,
                                    )
                                  : AssetImage("assets/Profile.png"),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 110,
                            child: InkWell(
                              onTap: () {
                                _showPicker(context);
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    color: Color(0xff979797)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/vector.png",
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      alignment: Alignment.topCenter,
                      width: 40,
                      child: ProfileFormField(
                        hintText: 'First Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                        onChanged: (value) => value.isEmpty
                            ? 'Please first Name '
                            : _firstName = _firstName,
                        onSaved: (val) => _firstName = val,
                        initialValue: '',
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: 40,
                      child: ProfileFormField(
                        hintText: 'Last Name',
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                        onChanged: (value) => value.isEmpty
                            ? 'Please last name'
                            : _lastName = _lastName,
                        onSaved: (val) => _lastName = val,
                        initialValue: '',
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: 40,
                      child: ProfileFormField(
                        textInputType: TextInputType.number,
                        hintText: 'Phone Number',
                        validator: (String value) {
                          if (value.length < 11) {
                            return 'Phone number should be 11 digi';
                          }

                          return null;
                        },
                        onChanged: (value) => value.isEmpty
                            ? 'Enter phone number'
                            : _phoneNumber = _phoneNumber,
                        onSaved: (val) => _phoneNumber = val,
                        initialValue: '',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: double.infinity,
              child: buttonWidget(
                buttonText: "Save changes",
                buttonColor: Color(0xFF3A953C),
                buttonAction: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 150,
          )
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                imageAdded
                    ? new ListTile(
                        leading: new Icon(Icons.cancel),
                        title: new Text('Remove Image'),
                        onTap: () {
                          removeImage();
                          Navigator.of(context).pop();
                        },
                      )
                    : ListTile(),
              ],
            ),
          ),
        );
      },
    );
  }
}
