import 'package:app/Checkpark.dart';
import 'package:app/MessageDemo.Dart/DemoMessage2.dart';
import 'package:app/Scanqrin.dart';
import 'package:app/Scanqrout.dart';
import 'package:app/imreport.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/help.dart';
import 'package:app/main.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotorCycle Parkking LOT',
      home: HomePage(),
      theme: ThemeData(
        textTheme: GoogleFonts.k2dTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.yellow,
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
          title: Text('ลานจอดรถมอเตอร์ไซค์อัจฉริยะ'),
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
              margin: EdgeInsets.fromLTRB(10, 10, 5, 0),
              child: OutlineButton(
                splashColor: Colors.deepPurple,
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(45, 130, 45, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => ImageReport());
                  Navigator.of(context).push(rount);
                },
                child: Text(
                  "รายงาน",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.deepPurple,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn1.iconfinder.com/data/icons/social-messaging-ui-color-shapes/128/document-circle-blue-512.png',
                        scale: 5)),
              ),
              alignment: Alignment(0, 0),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 5, 10),
              child: OutlineButton(
                splashColor: Colors.deepPurple,
                borderSide: BorderSide(
                  color: Colors.deepPurple,
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(25, 130, 25, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => CheckPark());
                  Navigator.of(context).push(rount);
                },
                child: Text(
                  "เช็คที่จอดรถ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.deepPurple,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://i.ya-webdesign.com/images/scooter-vector-lambretta-6.png',
                        scale: 2)),
              ),
              alignment: Alignment(0, 1),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
              child: OutlineButton(
                splashColor: Colors.blue[50],
                borderSide: BorderSide(
                  color: Colors.blue[300],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(35, 130, 35, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => FirebaseMessageHelp());
                  Navigator.of(context).push(rount);
                },
                child: Text(
                  "แจ้งเตือน",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue[300],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2015/12/16/17/41/bell-1096280_960_720.png',
                        scale: 6)),
              ),
              alignment: Alignment(0, 0),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 5, 10),
              child: OutlineButton(
                splashColor: Colors.blue[50],
                borderSide: BorderSide(
                  color: Colors.blue[300],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(5, 130, 5, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => Help());
                  Navigator.of(context).push(rount);
                },
                child: Text(
                  "ขอความช่วยเหลือ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[300],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn2.iconfinder.com/data/icons/business-and-education-1/512/210_FAQ_Assistance_call_consultation_help-512.png',
                        scale: 5.5)),
              ),
              alignment: Alignment(0, -0.1),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
              child: OutlineButton(
                splashColor: Colors.blue[50],
                borderSide: BorderSide(
                  color: Colors.blue[50],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(10, 130, 10, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => Checkdarable());
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
              margin: EdgeInsets.fromLTRB(0, 5, 5, 10),
              child: OutlineButton(
                splashColor: Colors.blue[50],
                borderSide: BorderSide(
                  color: Colors.blue[50],
                  width: 0,
                ),
                padding: EdgeInsets.fromLTRB(10, 130, 10, 0),
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => Checkout());
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
          ],
        )));
  }
}
