import 'package:app/alert1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/check.dart';
import 'package:app/main.dart';

// void main3() => runApp(Main3());

class Main4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'MotorCycle Parkking LOT',
      home: HomePage(),
      theme: ThemeData(
      
      textTheme: GoogleFonts.k2dTextTheme(
      Theme.of(context).textTheme,
    ),
      primarySwatch: Colors.blue,

      ),
    );
  }
}
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar( 
      leading: IconButton(
        icon:Icon(Icons.navigate_before,
        ),
        onPressed:(){
          var rount = MaterialPageRoute(builder: (BuildContext contex) =>MyApp()
                  );
                  Navigator.of(context).push(rount);
        },
        ), 
        title: Text('เจ้าหน้าที่') ,
         actions: <Widget>[
          //  backButton(),
         ],   
      ),

    body:
     SafeArea(
        child: Wrap( 
          direction: Axis.horizontal ,
          spacing: 25,
          runSpacing: 10,
          children: <Widget>[
            Container(
              
              margin: EdgeInsets.fromLTRB(10, 100, 5, 0),
              child: OutlineButton(
                splashColor: Colors.deepPurple[100],
                borderSide: BorderSide(color: Colors.deepPurple[100], width: 0, ),
                padding: EdgeInsets.fromLTRB(50, 150, 50, 0),
                onPressed: (){
                 var rount = MaterialPageRoute(builder: (BuildContext contex) =>Alert2()
                  );
                  Navigator.of(context).push(rount);
                  
                },
              child: Text("แจ้งเตือน",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700 ,  fontSize: 20, ),
              ),
                ),
              height:180,
              width: 180,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color:Colors.deepPurple[100],
              image: DecorationImage(
                image: NetworkImage('https://cdn3.iconfinder.com/data/icons/peelicons-vol-1/50/Mail-512.png',scale: 4)
                
                ),
              ),
              
              alignment: Alignment(0, 1),
              
              
            ), 
            Container(

              margin: EdgeInsets.fromLTRB(0, 100, 5, 5),
              child: OutlineButton(
                splashColor: Colors.deepPurple[100],
                borderSide: BorderSide(color: Colors.deepPurple[100], width:0, ),
                padding: EdgeInsets.fromLTRB(30, 150, 30, 0),
                onPressed: (){
                 var rount = MaterialPageRoute(builder: (BuildContext contex) =>Check()
                  );
                  Navigator.of(context).push(rount);
                  
                },
              child: Text("ยืนยันผู้ใช้",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700 ,  fontSize: 20, ),
              ),
                ),
              height:180,
              width: 180,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color:Colors.deepPurple[100],
              image: DecorationImage(
                image: NetworkImage('https://cdn4.iconfinder.com/data/icons/eldorado-user/40/user-512.png',scale: 4)
                
                ),
              ),
              alignment: Alignment(0, 1),
              
            ),        
            ],
        
        )
      )
    );
  }
}