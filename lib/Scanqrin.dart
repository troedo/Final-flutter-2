import 'dart:math';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

DocumentSnapshot snapshot;

class Checkdarable extends StatefulWidget {
  @override
  _CheckdarableState createState() => _CheckdarableState();
}

class _CheckdarableState extends State<Checkdarable> {
  final firestoreInstance = Firestore.instance;
  DateTime timedate;
  String qr;
  Map data;

  @override
  void initState() {
    super.initState();
    timedate = DateTime.now();
  }

  Future<Null> qrCode() async {
    try {
      var result = await BarcodeScanner.scan();
      qr = result.rawContent;
      print('result ======> $qr');
      if (qr == null || qr.isEmpty) {
        print('not data QR');
      } else {
        _onPressed2();
      }
    } catch (e) {}
  }

  void _onPressed2() {
    int a = 0;
    firestoreInstance
        .collection("camera")
        .where("License", isEqualTo: qr)
        .getDocuments()
        .then((value) {
      value.documents.forEach((result) {
        a += 2;
        print(result.data);
        print('no have data camera1');
      });
      if (a == 0) {
        insertValueToFireStore2();
        cond2();
      } else if (a == 2) {
        print('ok');
        firestoreInstance
            .collection("CheckinQR")
            .where("License", isEqualTo: qr)
            .getDocuments()
            .then((value) {
          value.documents.forEach((result) {
            a += 2;
            print(result.data);
            print('no data');
            print(a);
          });
          if (a == 0) {
            insertValueToFireStore();
          } else if (a == 2) {
            cond();
          }
        });
      }
    });
  }

  Future<void> insertValueToFireStore2() async {
    // int i;
    // Random random = Random();
    // i = random.nextInt(10000);
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> map = Map();

    map['message'] =
        'ไม่หมายเลขทะเบียนรถมอเตอร์ไซค์ :' + qr + ' ไม่ได้เข้าใช้งานลานจอดรถ';
    map['timestamp'] = DateTime.now();

    await firestore
        .collection('Messages')
        .document('EE')
        .setData(map)
        .then((value) {
      print('Insert Success Messages');
    });
  }

  Future<void> insertValueToFireStore() async {
    // int i;
    // Random random = Random();
    // i = random.nextInt(10000);
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> map = Map();

    map['License'] = qr;
    map['id'] = '3';
    map['timestamp'] = DateTime.now();

    await firestore
        .collection('CheckinQR')
        .document('3')
        .setData(map)
        .then((value) {
      print('Insert Success CheckinQR');
    });
    await firestore
        .collection('Checkin')
        .document('3')
        .setData(map)
        .then((value) {
      print('Insert Success Checknin');
    });
  }

  Future<Null> cond() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
            'หมายเลขทะเบียนรถมอเตอร์ไซค์นี้ได้ถูกผู้ใช้งานทำการสแกนเรียบร้อยแล้ว'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  builder:
                  (BuildContext contex) => Checkdarable();
                  Navigator.pop(context);
                },
                child: Text('รับทราบ'),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> cond2() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(
            'หมายเลขทะเบียนรถมอเตอร์ไซค์นี้ยังไม่ได้เข้าสู่ลานจอดรถมหาวิทยาลัยพะเยา'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  builder:
                  (BuildContext contex) => Checkdarable();
                  Navigator.pop(context);
                },
                child: Text('รับทราบ'),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สแกนคิวอาร์โค้ด เข้าใช้บริการลานจอดรถ')),
      body: Container(
        child: Column(
          children: <Widget>[
            //ok no errors.
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        onPressed: () {
          qrCode();
        },
        label: Text('Scan'),
      ),
    );
  }
}
