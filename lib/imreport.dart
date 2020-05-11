import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageReport extends StatefulWidget {
  @override
  _ImageReportState createState() => _ImageReportState();
}

class _ImageReportState extends State<ImageReport> {
  //File
  File file;
  String license, message, urlPicture;

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
                if (file == null) {
                  showAlert(
                      'Non Choose Picture', 'Please Click Camera or Gallery');
                } else if (license == null ||
                    license.isEmpty ||
                    message == null ||
                    message.isEmpty) {
                  showAlert('Have Space', 'Please Fill Every Blank');
                } else {
                  // Upload
                  uploadPictureToStorage();
                }
              },
              icon: Icon(
                Icons.cloud_upload,
                color: Colors.white,
              ),
              label: Text('ส่งรายงานผู้ที่กระทำความผิด')),
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

    Map<String, dynamic> map = Map();
    map['Messages'] = message;
    map['License'] = license;
    map['Pathimages'] = urlPicture;

    await firestore
        .collection('Motorcycle')
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

  Widget licenseForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          onChanged: (String string) {
            license = string.trim();
          },
          decoration: InputDecoration(
              helperText: 'กรุณากรอกหมายเลขป้ายทะเบียนรถมอเตอร์ไซค์',
              labelText: 'หมายเลขป้ายทะเบียนรถมอเตอร์ไซค์',
              icon: Icon(Icons.motorcycle)),
        ));
  }

  Widget messageForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          onChanged: (String string) {
            message = string.trim();
          },
          decoration: InputDecoration(
              helperText: 'กรุณากรอกข้อความรายงาน',
              labelText: 'ข้อความรายงาน',
              icon: Icon(Icons.message)),
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
          licenseForm(),
          messageForm(),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงาน'),
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
