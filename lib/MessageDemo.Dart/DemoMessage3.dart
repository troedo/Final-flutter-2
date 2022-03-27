import 'package:app/alert1.dart';
import 'package:app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMessageReport extends StatefulWidget {
  // FirebaseMessageReport() : super();
  final String title = 'Notification Report';
  @override
  State<StatefulWidget> createState() => FirebaseReportState();
}

class FirebaseReportState extends State<FirebaseMessageReport> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> _message;

  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      print('OnMessage: $message');
      _setMessage(message);
    }, onLaunch: (Map<String, dynamic> message) {
      print('OnLaunch: $message');
      _setMessage(message);
    }, onResume: (Map<String, dynamic> message) {
      print('OnMessage: $message');
      _setMessage(message);
    });
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String nMessage = data['message'];
    setState(() {
      Message m = Message(title, body, nMessage);
      _message.add(m);
    });
  }

  @override
  void initState() {
    super.initState();
    _message = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: null == _message ? 0 : _message.length,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                _message[index].message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
