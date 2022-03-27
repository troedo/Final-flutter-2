import 'package:app/ScanqrinGuard.dart';
import 'package:app/ScanqroutGuard.dart';
import 'package:app/alert1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/main.dart';

import 'Checkreport.dart';
import 'MessageDemo.Dart/DemoMessage.dart';

// void main3() => runApp(Main3());

class Main4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotorCycle Parkking LOT',
      home: HomePage(),
      theme: ThemeData(
        textTheme: GoogleFonts.k2dTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
            ),
            onPressed: () {
              var rount =
                  MaterialPageRoute(builder: (BuildContext contex) => MyApp());
              Navigator.of(context).push(rount);
            },
          ),
          title: Text('เจ้าหน้าที่'),
          actions: <Widget>[
            //  backButton(),
          ],
        ),
        body: SafeArea(
            child: Wrap(
          direction: Axis.horizontal,
          spacing: 25,
          runSpacing: 10,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 80, 5, 10),
              child: OutlineButton(
                splashColor: Colors.blue[50],
                borderSide: BorderSide(
                  color: Colors.blue[50],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(10, 130, 10, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => CheckinGuard());
                  Navigator.of(context).push(rount);
                },
                child: Text(
                  "Check in QR CODE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      backgroundColor: Colors.black38),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[300],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://image.flaticon.com/icons/png/512/579/579359.png',
                        scale: 4)),
              ),
              alignment: Alignment(0, 0),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 80, 5, 10),
              child: OutlineButton(
                splashColor: Colors.blue[50],
                borderSide: BorderSide(
                  color: Colors.blue[50],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(10, 130, 10, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => CheckoutGuard());
                  Navigator.of(context).push(rount);
                },
                child: Text(
                  "Check Out QR CODE",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      backgroundColor: Colors.black38),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey[300],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://image.flaticon.com/icons/png/512/579/579359.png',
                        scale: 4)),
              ),
              alignment: Alignment(0, 0),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 50, 5, 10),
              child: OutlineButton(
                splashColor: Colors.deepPurple[100],
                borderSide: BorderSide(
                  color: Colors.deepPurple[100],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
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
                    fontSize: 16,
                  ),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.deepPurple[100],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn3.iconfinder.com/data/icons/peelicons-vol-1/50/Mail-512.png',
                        scale: 7)),
              ),
              alignment: Alignment(0, 1),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 50, 5, 10),
              child: OutlineButton(
                splashColor: Colors.deepPurple[100],
                borderSide: BorderSide(
                  color: Colors.deepPurple[100],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(10, 100, 10, 0),
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
                    fontSize: 16,
                  ),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.deepPurple[100],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn3.iconfinder.com/data/icons/peelicons-vol-1/50/Mail-512.png',
                        scale: 7)),
              ),
              alignment: Alignment(0, 1),
            ),
          ],
        )));
  }
}
