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
      title: 'ขอความช่วยเหลือ',
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
  String message;
  String number;

//Method
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
                  insertValueToFireStore();
                  insertValueToFireStore2();
                  builder:
                  (BuildContext contex) => Main();
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
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => Help());
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
          if (message == null || message.isEmpty) {
            showAlert('กรุณากรอกข้อความ', '');
          } else {
            // Upload
            confirm2();
          }
        },
        textColor: Colors.lightBlueAccent,
        borderSide: BorderSide(
            color: Colors.blue, width: 1.0, style: BorderStyle.solid),
        child: Text(
          'ส่งข้อความ',
        ),
      ),
    );
  }

  Future<void> insertValueToFireStore() async {
    Random random = Random();
    int i = random.nextInt(100000);
    Firestore firestore = Firestore.instance;

    Map<String, dynamic> map = Map();
    map['number'] = number;
    map['message'] = message;
    map['timestamp'] = DateTime.now();

    await firestore
        .collection('Messages')
        .document()
        .setData(map)
        .then((value) {
      print('Insert Success');
    });
  }

  Future<void> insertValueToFireStore2() async {
    Random random = Random();
    int i = random.nextInt(100000);
    Firestore firestore = Firestore.instance;

    Map<String, dynamic> map = Map();
    map['message'] = 'หมายเลขเบอร์โทรศัพท์ : ' + number;
    map['timestamp'] = DateTime.now();

    await firestore
        .collection('Messages')
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
              helperText: 'กรุณากรอกข้อความ',
              labelText: 'ข้อความขอความช่วยเหลือ',
              icon: Icon(Icons.message)),
        ));
  }

  Widget numberForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: (String string) {
            number = string.trim();
          },
          decoration: InputDecoration(
              helperText: 'โปรดระบุหมายเลขเบอร์โทรศัพท์',
              labelText: 'หมายเลขเบอร์โทรศัพท์',
              icon: Icon(Icons.phone)),
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
      child: file == null ? Image.asset('images/help.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[showImage(), messageForm(), numberForm(), submit()],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
          ),
          onPressed: () {
            var rount =
                MaterialPageRoute(builder: (BuildContext contex) => Main());
            Navigator.of(context).push(rount);
          },
        ),
        title: Text('Help'),
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
