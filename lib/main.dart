import 'package:flutter/material.dart';
import 'package:my_login_task/signin.dart';

void main() {
  runApp(const MyWidget());



}


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MyApp()
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Color(0xFF3967D7),
          body: Stack(
            children: [
              Container(
                
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 5.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                   children: [
                     // CircleAvatar(
                        //radius: 50,
                       // backgroundColor: Colors.white,
                        //child: Icon(
                          //Icons.currency_exchange,
                         // size: 60,
                          ///color: Color(0xFF3967D7),
                        //),
                      //),
                      //SizedBox(height: 20.0),
                      Text(
                        'Welcome to Bc Exchange',
                        style: TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'We are  offering digital asset exchange with maximum security and advance tracking features',
                        style: TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center, // Centers t̥he text
                        softWrap: true,
                      ),
                      SizedBox(
                        height: 150.0,
                      ),
                      ClipOval(
                        child:Image.asset(
      'assets/bit.jpg',  // Your image path
      fit: BoxFit.cover,    
      width: 300,
      height: 300,   // You can adjust the fit as needed
    ), 
                      ),
                       SizedBox(
                        height: 150.0,
                      ),
                      TextButton(onPressed: null, child: 
                      Container(
                        
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                 alignment: Alignment.center,
                        child: Text('SIGN UP',
                        style: TextStyle(
                          color: Color(0xFF3967D7),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,

                        ),
                          
                        ),
                        
                      )
                      ),
                       SizedBox(
                        height: 45.0,
                      ),
                     Text(
                        'Already a member ?',
                        style: TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 15.0,
                          
                           color: Color.fromARGB(255, 56, 169, 231),
                            
                        ),
                      ),
                       SizedBox(
                        height: 5.0,
                      ),
                      ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
                      
                    },
                     style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Transparent background
    shadowColor: Colors.transparent,    // Removes the shadow
    elevation: 0,                       // Removes the button elevation
  ),
                    
                      child: Text('Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      )

                     )
                       /*Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 18.0,
                         color: Colors.white,
                        ),
                      ),*/


                       
                   ],
                  ),
                ),
              ),
            ],
          )
    );
  }
}
