import 'dart:io';
import 'package:app/main.dart';
import 'package:app/main2.dart';
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
  String uniqueCode = 'report';

//Method

  Future<void> uploadPictureToStorage() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('License/license$uniqueCode.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    print(storageReference);
    urlPicture =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('urlPicture = $urlPicture');
    insertValueToFireStore();
  }

  Future<void> insertValueToFireStore() async {
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> map = Map();
    map['message'] = message;
    map['License'] = license;
    map['Pathimages'] = urlPicture;
    map['timestamp'] = DateTime.now();

    await firestore
        .collection('Messages')
        .document('report')
        .setData(map)
        .then((value) {
      print('Insert Success');
    });
    await firestore
        .collection('Report')
        .document('report')
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
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: (String string) {
            license = string.trim();
          },
          decoration: InputDecoration(
              helperText: 'โปรดระบุเลขทะเบียนรถมอเตอร์ไซค์ที่ต้องการรายงาน',
              labelText: 'เลขทะเบียนรถมอเตอร์ไซค์',
              icon: Icon(Icons.motorcycle)),
        ));
  }

  Widget messageForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: (String string) {
            message = string.trim();
          },
          decoration: InputDecoration(
              helperText: 'โปรดระบุข้อความการรายงานผู้ใช้',
              labelText: 'ข้อความการรายงานผู้ใช้',
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

  Future<Null> cond() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการส่งรายงานใช่หรือไม่'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => ImageReport());
                  Navigator.pop(context);
                },
                child: Text('ส่งรายงานสำเร็จ'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> confirm2() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการส่งรายงานใช่หรือไม่'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  uploadPictureToStorage();

                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => ImageReport());
                  Navigator.pop(context);
                  cond();
                },
                child: Text('ใช่'),
              ),
              OutlineButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ไม่'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget submit() {
    return Container(
      child: OutlineButton(
        onPressed: () {
          print('You Click Upload');
          if (file == null) {
            showAlert('กรุณาใส่รูปภาพ', 'ถ่ายรูป หรือ อัพโหลดรูปภาพ');
          } else if (license == null ||
              license.isEmpty ||
              message == null ||
              message.isEmpty) {
            showAlert('กรุณากรอกข้อมูลให้ครบ', '');
          } else if (file != null ||
              license != null ||
              license.isEmpty ||
              message != null ||
              message.isEmpty) {
            confirm2();
            // uploadPictureToStorage();
          }
          // else {
          //   // Upload

          //   // insertValueToFireStore2();
          // }
        },
        textColor: Colors.lightBlueAccent,
        borderSide: BorderSide(
            color: Colors.blue, width: 1.0, style: BorderStyle.solid),
        child: Text(
          'ส่งรายงาน',
        ),
      ),
    );
  }

  // Widget galleryButton() {
  //   return IconButton(
  //       icon: Icon(
  //         Icons.add_photo_alternate,
  //         size: 40.0,
  //         color: Colors.lightBlueAccent,
  //       ),
  //       onPressed: () {
  //         chooseImage(ImageSource.gallery);
  //       });
  // }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        // galleryButton(),
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
          submit()
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานผู้ใช้'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Stack(
          children: <Widget>[
            showContent(),
          ],
        ),
      ),
    );
  }
}
