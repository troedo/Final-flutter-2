import 'package:app/MessageDemo.Dart/DemoMessage.dart';
import 'package:app/MessageDemo.Dart/DemoMessage3.dart';
import 'package:app/guard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Checkture.dart';
import 'package:app/Checkreport.dart';

class Alert2 extends StatelessWidget {
  final String appTitle = 'แจ้งเตือนเจ้าหน้าที่  ';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MainPage(appTitle: appTitle),
      theme: ThemeData(
        textTheme: GoogleFonts.k2dTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.navigate_before,
          ),
          onPressed: () {
            var rount =
                MaterialPageRoute(builder: (BuildContext contex) => Main4());
            Navigator.of(context).push(rount);
          },
        ),
        title: Text(appTitle),
      ),
      body: SafeArea(
          child: Wrap(
        direction: Axis.horizontal,
        spacing: 25,
        runSpacing: 10,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 100, 5, 0),
            child: OutlineButton(
              splashColor: Colors.deepPurple[100],
              borderSide: BorderSide(
                color: Colors.deepPurple[100],
                width: 0,
              ),
              onPressed: () {
                var rount = MaterialPageRoute(
                    builder: (BuildContext contex) => CheckReport());
                Navigator.of(context).push(rount);
              },
              child: Text(
                "เช็คความถูกต้องของรายงาน",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.deepPurple[100],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 100, 5, 5),
            child: OutlineButton(
              splashColor: Colors.deepPurple[100],
              borderSide: BorderSide(
                color: Colors.deepPurple[100],
                width: 0,
              ),
              onPressed: () {
                var rount = MaterialPageRoute(
                    builder: (BuildContext contex) => FirebaseMessage());
                Navigator.of(context).push(rount);
              },
              child: Text(
                "ข้อความขอความช่วยเหลือ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.deepPurple[100],
            ),
          ),
        ],
      )));
}
