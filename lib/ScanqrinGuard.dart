import 'dart:math';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class CheckinGuard extends StatefulWidget {
  @override
  _CheckdarableState createState() => _CheckdarableState();
}

class _CheckdarableState extends State<CheckinGuard> {
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
        title: Text('สแกนคิวอาร์โค้ด เข้าใช้บริการลานจอดรถ'),
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
        insertValueToFireStore();
        print('Comple sussage QR');
      }
    } catch (e) {}
  }

  Future<void> insertValueToFireStore() async {
    int i;
    Random random = Random();
    i = random.nextInt(10000);
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> map = Map();

    map['License'] = qr;
    map['id'] = '$i';
    map['timestamp'] = DateTime.now();

    await firestore
        .collection('CheckinQR')
        .document(qr)
        .setData(map)
        .then((value) {
      print('Insert Success');
      print('$i');
    });
  }
}
