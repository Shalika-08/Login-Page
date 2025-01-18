
import 'package:flutter/material.dart';
import 'package:my_login_task/signup.dart';

void main() {
  runApp(const Signin());
}
 bool? _checkbox=false;
// Custom clipper to define the shape
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 130); // Clip the bottom 40 pixels
    path.quadraticBezierTo(
      size.width / 2, size.height, // Curve point for bottom-center
      size.width, size.height - 130, // Clip the bottom 40 pixels
    );
    path.lineTo(size.width, 0); // End the shape at the top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
        child: Align(
                  alignment: Alignment.topCenter,
                 child:     Column(
          children: [
             ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
             
              height: 250,
             color: Color(0xFF3967D7),
            ),
          ),
            SizedBox(
                        height: 100.0,
                      ),
        Text('Sign In Now',
        style: TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 20.0,
                          
                           color: Color(0xFF3967D7),
                           fontWeight: FontWeight.bold,
        ),
        ),
                   SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                      child :TextFormField(
                        
  
  decoration: InputDecoration(
    hintText: "John Jones",
    prefixIcon: Icon(Icons.person,color:Color(0xFF3967D7) ,),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
    ),
    
    
  ),
  
),



),

                      Container(
                         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      child :TextFormField(
                        style: TextStyle(color: Colors.grey),
                        
  
  decoration: InputDecoration(
    hintText: "Password",

    
    prefixIcon: Icon(Icons.lock,color:Colors.grey ,),
    suffixIcon: Icon(Icons.remove_red_eye,color:Colors.grey ,),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
    ),
    
    
  ),
  
),



),
Container(
  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
  child: Row(
    
    children: [
        Checkbox(
    activeColor: Color(0xFF3967D7),
    checkColor:Colors.white,
    tristate: true,

    value: _checkbox, onChanged: (val){
    setState(() {
      _checkbox=val;
    });

  }),
  Text('Remember me',
  style: TextStyle(fontSize: 15.0,color: Colors.grey
  

  ),),
  SizedBox(width: 180,),
   
  TextButton(onPressed: null, child: Text('Forgot Password?',
  style: TextStyle(fontSize: 15.0,color: Colors.grey
  

  ),),)

    ],
  )

),


  SizedBox(
                       height: 130.0,
                      ),
                      TextButton(onPressed: null, child: 
                      Container(
                        
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF3967D7),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                 alignment: Alignment.center,
                        child: Text('SIGN IN',
                        style: TextStyle(
                          color:Colors.white ,
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
                        "Don't you have an account ?",
                        style: TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 15.0,
                          
                           color: Colors.blueGrey,
                            
                        ),
                      ),
                       SizedBox(
                        height: 5.0,
                      ),
                      ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                      
                    },
                     style: ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Transparent background
    shadowColor: Colors.transparent,    // Removes the shadow
    elevation: 0,                       // Removes the button elevation
  ),
                    
                      child: Text('Sign Up from here',
                      style: TextStyle(
                        color: Color(0xFF3967D7),
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      )

                     )


                      
          ],
        )
        )
        ),
     
        
          
        
      ),
    );
  }
}