import 'dart:math';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class CheckoutGuard extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutGuard> {
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
        deleteData(qr);
        print('Comple sussage QR');
      }
    } catch (e) {}
  }

  deleteData(qr) {
    Firestore.instance
        .collection('CheckinQR')
        .document(qr)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
