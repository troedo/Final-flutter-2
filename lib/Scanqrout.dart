import 'dart:math';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

DocumentSnapshot snapshot;

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final firestoreInstance = Firestore.instance;
  DateTime timedate;
  String qr;

  @override
  void initState() {
    super.initState();
    timedate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สแกนคิวอาร์โค้ด ออกลานจอดรถ'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

  Future<Null> qrCode() async {
    try {
      var result = await BarcodeScanner.scan();
      qr = result.rawContent;
      print('result ======> $qr');
      if (qr == null || qr.isEmpty) {
        print('not data QR');
      } else {
        // Upload
        // getData();
        _onPressed2();
        print('Comple sussage QR');
      }
    } catch (e) {}
  }

  void _onPressed2() {
    int a = 0;
    firestoreInstance
        .collection("CheckinQR")
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
          } else if (a == 4) {
            print('เข้านะ');
            // deleteData(qr);
          }
        });
      }
    });
  }

  Future<void> insertValueToFireStore2() async {
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> map = Map();
    map['message'] =
        'ไม่หมายเลขทะเบียนรถมอเตอร์ไซค์ :' + qr + ' ไม่มีข้อมูลในกล้อง Camera4';
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
                  (BuildContext contex) => Checkout();
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
        title: Text('หมายเลขทะเบียนรถมอเตอร์ไซค์นี้ไม่มีข้อมูลในกล้องทางออก'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  builder:
                  (BuildContext contex) => Checkout();
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

  deleteData() {
    Firestore.instance
        .collection('CheckinQR')
        .document()
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
