import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageAdd2 extends StatefulWidget {
  @override
  _ImageAddState createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd2> {
  //File
  File file;
  String license, message, urlPicture;
  bool n;
  int _counter = 0;
  final databaseReference = Firestore.instance;

 Future<void> getData() async {
  Firestore.instance.collection("Parking").getDocuments().then(
    (doc) {
          

      Firestore.instance.collection("Parking").document(
        doc.documents[0].documentID).updateData({'A1': doc.documents[0].data['A1']-1});
});
              
  }

  


  void _increaseCounter(){
    setState(() {
      _counter = _counter +1 ;
    });
  }

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
                // _increaseCounter();
                print('You Click Upload');
                if (file == null) {
                } else {
                  // Upload
                  uploadPictureToStorage();
                  getData();
                  // insertValueToFireStore2();
                  
                }
              },
              icon: Icon(
                Icons.cloud_upload,
                color: Colors.white,
              ),
              label: Text('รถผ่านกล้องตัวที่ 3')),
        ),
      ],
    );
  }
  
  Future<void> uploadPictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('License/license$i.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);

    urlPicture =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('urlPicture = $urlPicture');
    insertValueToFireStore();

  }

  Future<void> insertValueToFireStore() async {
    Firestore firestore = Firestore.instance;
    // Timee<String, dynamic> time = Timee();
    // time['timestamp'] = DateTime.now();
   
    Map<String, dynamic> map = Map();
    map['timestamp'] = DateTime.now();
    map['im'] = urlPicture;
    map['license'] = message;
    await firestore
        .collection('ImageParking')
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
              helperText: 'กรอกหมายเลขป้ายทะเบียน',
              labelText: 'หมายเลขป้ายทะเบียน',
              icon: Icon(Icons.motorcycle)),
        ));
  }

  
  Widget cameraButton() {
    return IconButton(
        icon:
            Icon(Icons.add_a_photo, size: 40.0, color: Colors.lightBlueAccent),
        onPressed: () {
          chooseImage(ImageSource.camera);
        });
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

  Widget galleryButton() {
    return IconButton(
        icon: Icon(
          Icons.add_photo_alternate,
          size: 40.0,
          color: Colors.lightBlueAccent,
        ),
        onPressed: () {
          chooseImage(ImageSource.gallery);
        });
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      // color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/pick.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showButton(),
          messageForm()
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('กล้องตัวที่ 3'),
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
