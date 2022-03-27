import 'package:app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Checbox2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
          child: Center(
        child: CheckBoxWidget(),
      )),
    ));
  }
}

class CheckBoxWidget extends StatefulWidget {
  @override
  CheckboxWidgetClass createState() => new CheckboxWidgetClass();
}

class CheckboxWidgetClass extends State {
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
        print('license = ${snapshot.data['license']}');
        print('timestamp = ${snapshot.data['timestamp']}');
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

  Widget showImage(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(models[index].im),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          showParking(index),
          // showParking2(index),
        ],
      ),
    );
  }

  Widget showModels(int index) {
    return Row(
      children: <Widget>[
        showImage(index),
      ],
    );
    // return Center(
    //   child: Form(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.max,
    //       children: <Widget>[
    //         showImage(index),
    //         showText(index),
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: models.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return showModels(index);
          }),
    );
  }
}
