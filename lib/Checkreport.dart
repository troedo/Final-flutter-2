import 'package:app/alert1.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'guard.dart';

DocumentSnapshot snapshot;
var data = 'eiei';

class CheckReport extends StatelessWidget {
  void getData() async {
    //use a Async-await function to get the data
    final data = await Firestore.instance
        .collection("Messages")
        .document('report')
        .get(); //get the data
    snapshot = data;
  }

  Future<void> insertValueToFireStore() async {
    int i;
    Random random = Random();
    i = random.nextInt(10000);
    Firestore firestore = Firestore.instance;
    Map<String, dynamic> map = Map();

    map['message'] = 'ผู้ใช้ได้โดนรายงานการกระทำความผิด ' +
        'หมายเลขทะเบียนรถ:' +
        snapshot.data['License'].toString();
    ;
    map['timestamp'] = DateTime.now();

    await firestore
        .collection('Messages')
        .document('$i')
        .setData(map)
        .then((value) {
      print('Insert Success');
    });
  }

  deleteData() {
    Firestore.instance
        .collection('Messages')
        .document('report')
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    Future<Null> confirm() async {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('คุณต้องการส่งรายงานนี้ใช่หรือไม่'),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    insertValueToFireStore();
                    deleteData();
                    var rount = MaterialPageRoute(
                        builder: (BuildContext contex) => Alert2());
                    Navigator.pop(context);
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

    Future<Null> confirm2() async {
      showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('คุณต้องการยกเลิกการส่งรายงานนี้ใช่หรือไม่'),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    deleteData();
                    var rount = MaterialPageRoute(
                        builder: (BuildContext contex) => Main4());
                    Navigator.pop(context);
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
            confirm();
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

    Widget submit2() {
      return Container(
        child: OutlineButton(
          onPressed: () {
            confirm2();
          },
          textColor: Colors.lightBlueAccent,
          borderSide: BorderSide(
              color: Colors.blue, width: 1.0, style: BorderStyle.solid),
          child: Text(
            'ยกเลิกการส่งรายงาน',
          ),
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
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
          title: Text(
            'เช็คการรายงาน',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(5.0),
                    height: 50,
                    width: 350,
                    child: ListTile(
                      title: Text('License Plate : ' +
                          snapshot.data['License'].toString()), //ok no errors.
                    ),
                  ), //ok no errors.
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(5.0),
                    height: 50,
                    width: 350,
                    child: ListTile(
                      title: Text('Message :  ' +
                          snapshot.data['message'].toString()), //ok no errors.
                    ),
                  ), //ok no errors.
                  // Container(
                  //   decoration:
                  //       BoxDecoration(border: Border.all(color: Colors.black)),
                  //   padding: EdgeInsets.all(10.0),
                  //   margin: EdgeInsets.all(5.0),
                  //   height: 50,
                  //   width: 350,
                  //   child: ListTile(
                  //     title: Text(snapshot.data['timestamp']
                  //         .toString()), //ok no errors.
                  //   ),
                  // ), //ok no errors.
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(1.0),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            snapshot.data['Pathimages'].toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              submit(),
              submit2(),
            ],
          ),
        ),
      ),
    );
  }
}
