import 'dart:io';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/main2.dart';
class Help extends StatefulWidget {
  @override
  _HelpState createState() {
  return _HelpState();
}
}
class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help',
      home: NeedHelp(),
       theme: ThemeData(
      
      textTheme: GoogleFonts.k2dTextTheme(
      Theme.of(context).textTheme,
    ),
      primarySwatch: Colors.yellow,

      ),
    );
    
  }
}

class NeedHelp extends StatefulWidget {
  @override
  _NeedHelpState createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {
  //File
  File file;
  String  message;

//Method
  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
              color: Colors.lightBlueAccent,
              onPressed: () {
                print('You Click Upload');
               if (
                    message == null ||
                    message.isEmpty) {
                  showAlert('Have Space', 'Please Fill Every Blank');
                } else {
                  // Upload
                     insertValueToFireStore();
                }
              },
              icon: Icon(
                Icons.cloud_upload,
                color: Colors.white,
              ),
              label: Text('Upload Help Message Data')),
        ),
      ],
    );
  }

  
  Future<void> insertValueToFireStore() async {
    Random random = Random();
    int i = random.nextInt(100000);
    Firestore firestore = Firestore.instance;
    
    Map<String, dynamic> map = Map();
    map['HelpMe'] = message;

    await firestore
        .collection('NeedHelp')
        .document()
        .setData(map)
        .then((value) {
          print('Insert Success');
        });
  }

  Future<void> showAlert(String title, String messages) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(messages),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Widget messageForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: (String string) {
            message = string.trim();
          },
          decoration: InputDecoration(
              helperText: 'Type Your Help Message',
              labelText: 'Help Message',
              icon: Icon(Icons.message)),
        ));
  }


  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }


  Widget showImage() {
    return Container(
      // color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? 
      Image.asset('images/help.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          messageForm(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon:Icon(Icons.navigate_before,
        ),
        
       
        onPressed:(){
          var rount = MaterialPageRoute(builder: (BuildContext contex) =>Main()
                  );
                  Navigator.of(context).push(rount);
        },
        ), 
        
        title: Text('Help'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Stack(
          children: <Widget>[showContent(), uploadButton()],
        ),
      ),
    );
  }
}
