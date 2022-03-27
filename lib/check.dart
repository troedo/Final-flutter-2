import 'package:google_fonts/google_fonts.dart';
import 'package:app/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/main2.dart';

class Main3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Help',
      home: Check(),
      theme: ThemeData(
        textTheme: GoogleFonts.k2dTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.yellow,
      ),
    );
  }
}

class Check extends StatefulWidget {
  @override
  _CheckState createState() {
    return _CheckState();
  }
}

class _CheckState extends State<Check> {
  List<Model> models = List();

  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference =
        firestore.collection('ImageParking');
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        print('A1 = ${snapshot.data['A1']}');
        print('A2 = ${snapshot.data['A2']}');
        print('A3 = ${snapshot.data['A3']}');
        print('A4 = ${snapshot.data['A4']}');
        print('A5 = ${snapshot.data['A5']}');
        print('im = ${snapshot.data['im']}');

        Model model = Model.fromMap(snapshot.data);
        setState(() {
          models.add(model);
        });
      }
    });
  }

  Widget showParking(int index) {
    return Text(
      models[index].a1,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showParking2(int index) {
    return Text(
      models[index].a2,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showParking3(int index) {
    return Text(
      models[index].a3,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showParking4(int index) {
    return Text(
      models[index].a4,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showParking5(int index) {
    return Text(
      models[index].a5,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 1.0,
      height: MediaQuery.of(context).size.width * 1.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          image: DecorationImage(
            image: NetworkImage(models[index].im),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          showParking(index),
          showParking2(index),
          showParking3(index),
          showParking4(index),
          showParking5(index),
        ],
      ),
    );
  }

  Widget showModels(int index) {
    return Center(
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // return Row(
            //   children: <Widget>[
            showImage(index),
            showText(index),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เช็คที่จอดรถ'),
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
      ),
      body: Container(
        child: ListView.builder(
            itemCount: models.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return showModels(index);
            }),
      ),
    );
  }
}

//   body: SafeArea(
//   child: Stack(
//     children: <Widget>[
//       content()

//     ],
//   ),
// ),
