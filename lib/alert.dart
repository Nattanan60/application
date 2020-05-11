import 'package:flutter/material.dart';
import 'package:app/main2.dart';
import 'package:app/widget/messaging_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Alert extends StatelessWidget {
  final String appTitle = 'แจ้งเตือน  ';
  @override
  Widget build(BuildContext context) {
  return MaterialApp(
        title: appTitle,
        home: MainPage(appTitle: appTitle),
        theme: ThemeData(
      
      textTheme: GoogleFonts.k2dTextTheme(
      Theme.of(context).textTheme,
    ),
      primarySwatch: Colors.yellow,

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
          var rount = MaterialPageRoute(builder: (BuildContext contex) =>Main()
                  );
                  Navigator.of(context).push(rount);
        },
        ), 
          title: Text(appTitle),
        ),
        body: MessagingWidget(),
      );
}
