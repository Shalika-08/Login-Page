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
      
      body: Padding(padding: EdgeInsets.all(10.0),
      child: 
      Text('Welcome to Bc Exchange',
      
      style: TextStyle(
        fontFamily: 'Cambria',fontSize: 15.0,color: Colors.white,
        ),
        )
      )
      
      
      ),
    );
  }
}
