import 'package:app/main2.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class CheckPark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Future<String> data2() async {
    //   var data1 = (await Firestore.instance
    //           .collection('Parking')
    //           .document('EP9t1HolJbmnHyt6jAsL')
    //           .get())
    //       .data
    //       .toString();
    //   return data1;
    // }
    void getData() async {
      //use a Async-await function to get the data
      final data = await Firestore.instance
          .collection("Parking")
          .document('EP9t1HolJbmnHyt6jAsL')
          .get(); //get the data
      snapshot = data;
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
                  MaterialPageRoute(builder: (BuildContext contex) => Main());
              Navigator.of(context).push(rount);
            },
          ),
          title: Text(
            'เช็คที่จอดรถ',
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
                      title: Text('A1 : ' +
                          snapshot.data['A1'].toString()), //ok no errors.
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
                      title: Text('A2 :  ' +
                          snapshot.data['A2'].toString()), //ok no errors.
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(5.0),
                    height: 50,
                    width: 350,
                    child: ListTile(
                      title: Text('A3 :  ' +
                          snapshot.data['A3'].toString()), //ok no errors.
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(5.0),
                    height: 50,
                    width: 350,
                    child: ListTile(
                      title: Text('A4 :  ' +
                          snapshot.data['A4'].toString()), //ok no errors.
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(5.0),
                    height: 50,
                    width: 350,
                    child: ListTile(
                      title: Text('A5 :  ' +
                          snapshot.data['A5'].toString()), //ok no errors.
                    ),
                  ),
                  // Container(
                  //   decoration:
                  //       BoxDecoration(border: Border.all(color: Colors.black)),
                  //   padding: EdgeInsets.all(10.0),
                  //   margin: EdgeInsets.all(5.0),
                  //   height: 150,
                  //   width: 350,
                  //   child: FutureBuilder(
                  //     future: data2(),
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       print(snapshot.data);

                  //       return Text(
                  //         'ช่องจอดรถ : ' + snapshot.data,
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 15),
                  //       );
                  //     },
                  //   ), //ok no errors.
                  // ),
                  // Container(
                  //   padding: EdgeInsets.all(10.0),
                  //   margin: EdgeInsets.all(1.0),
                  //   height: 350,
                  //   width: 350,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: NetworkImage(
                  //           'https://firebasestorage.googleapis.com/v0/b/testmotorcycle.appspot.com/o/License%20Plate%20Motorcycle%2FParking.png?alt=media&token=57a1959b-9d60-44cb-a84c-b7688cdddbd5'),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
