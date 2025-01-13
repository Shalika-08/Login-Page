import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
      backgroundColor: Color(0xFF3967D7),
      
      body: Padding(padding: EdgeInsets.symmetric(vertical: 50,horizontal: 5.0),
      
     child: Align(
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
         child: Column(
          children: [
           Text('Welcome to Bc Exchange',
           style: TextStyle(
                    fontFamily: 'Cambria',
                    fontSize: 20.0,
                    color: Colors.white,
          ),

          

        ),
        SizedBox(height: 10.0,),
        Text('We are  offering digital asset exchange with maximum security and advance tracking features',
           style: TextStyle(
                    fontFamily: 'Cambria',
                    fontSize: 15.0,
                    color: Colors.white,
          ),
           textAlign: TextAlign.center, // Centers the text
                    softWrap: true,

          

        ),
        
          ],

         )
        
        
        
     ),
    
      )
      
      
      ),
    ),
    );
  }
}
