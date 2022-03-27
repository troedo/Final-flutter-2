import 'package:app/alert1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Checkhelp extends StatelessWidget {
  final String appTitle = 'ข้อความขอความช่วยเหลือ  ';
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
        title: appTitle,
        home: MainPage(appTitle: appTitle),
        theme: ThemeData(
      
      textTheme: GoogleFonts.k2dTextTheme(
      Theme.of(context).textTheme,
    ),
      primarySwatch: Colors.blue,

      ),
        
      );
  }
}

class MainPage extends StatelessWidget {
  final String appTitle;

  const MainPage({this.appTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
        icon:Icon(Icons.navigate_before,
        ),
        
       
        onPressed:(){
          var rount = MaterialPageRoute(builder: (BuildContext contex) =>Alert2()
                  );
                  Navigator.of(context).push(rount);
        },
        ), 
          title: Text(appTitle),
        ),
        body: Container(),
      );
}