import 'dart:math';
import 'package:app/alert1.dart';
import 'package:app/main2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Checbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
          child: Center(
        child: CheckBoxWidget(),
      )),
    ));
  }
}

class CheckBoxWidget extends StatefulWidget {
  @override
  CheckboxWidgetClass createState() => new CheckboxWidgetClass();
}

class CheckboxWidgetClass extends State {
  bool isChecked = false;
  String resultHolder = 'Checkbox is UnChecked';
  String license;

  void toggleCheckbox(bool value) {
    if (!isChecked) {
      setState(() {
        isChecked = true;
        resultHolder = 'Checkbox is Checked';
      });
    } else {
      setState(() {
        isChecked = false;
        resultHolder = 'Checkbox is UnChecked';
      });
    }
  }

  Widget messageForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: (String string) {
            license = string.trim();
          },
          decoration: InputDecoration(
              helperText: 'Type Your License Plate',
              labelText: 'License Plate',
              icon: Icon(Icons.message)),
        ));
  }

  Future<void> insertValueToFireStore() async {
    Random random = Random();
    int i = random.nextInt(10000);
    Firestore firestore = Firestore.instance;

    Map<String, dynamic> map = Map();
    map['License'] = license;

    await firestore
        .collection('CheckReport')
        .document()
        .setData(map)
        .then((value) {
      print('Insert Success');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              toggleCheckbox(value);
            },
            activeColor: Colors.green,
            checkColor: Colors.white,
            tristate: false,
          ),
        ),
        Text(
          '$resultHolder',
          style: TextStyle(fontSize: 22),
        ),
        messageForm(),
        RaisedButton(
          onPressed: () {
            print('You Click Upload');
            if (isChecked == false) {
              print('false dont data');
            } else {
              // Upload
              insertValueToFireStore();
              print('push data');
            }
          },
          color: Colors.green,
          child: Text(
            'summit report',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
