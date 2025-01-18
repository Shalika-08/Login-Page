
import 'package:flutter/material.dart';
import 'package:my_login_task/main.dart';
import 'package:my_login_task/signup.dart';

void main() {
  runApp(const Signin());
}
 bool? _checkbox=false;

 class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFF1366F6)
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height - 80) // Adjust height for curve start
      ..quadraticBezierTo(
        size.width / 2, size.height+70, // Curve to the bottom-center
        size.width, size.height - 80, // Curve to the bottom-right
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint
  }
}
// Custom clipper to define the shape
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 80); // Clip the bottom 40 pixels
    path.quadraticBezierTo(
      size.width / 2, size.height+70, // Curve point for bottom-center
      size.width, size.height - 80, // Clip the bottom 40 pixels
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
        body: 
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
        child: Align(
                  alignment: Alignment.topCenter,
                 child:     Column(
          children: [
           Stack(
            children: [
                ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0),
             
              height: 250,
              
              
             
             decoration: BoxDecoration(
                  color: Color(0xFF1366F6),
                  image: DecorationImage(image: AssetImage('assets/Untitled design (1).png',
                  
                  ),
                  fit: BoxFit.contain,
                  //alignment: Alignment.center,
                  
                  )
             ),
                                 
    
            ),
            
          )
          ,
          Positioned(child: IconButton(onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyWidget()),
    );
  }, icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),))
            ]
           

           )

            ,
            SizedBox(
                        height: 100.0,
                      ),
        Text('Sign In Now',
        style: TextStyle(
                          fontFamily: 'Cambria',
                          fontSize: 20.0,
                          
                           color: Color(0xFF1366F6),
                           fontWeight: FontWeight.bold,
        ),
        ),
                   SizedBox(
                        height: 30.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                      child :TextField(
                        
  
  decoration: InputDecoration(
    hintText: "Shalika Manoharan",
    //filled: true,
    prefixIcon: Icon(Icons.person,color:Color(0xFF1366F6) ,),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(color: Colors.grey, width: 2.0),
    ),
    
    
  ),
  
),



),

                      Padding(
                         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      child :TextField(
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
Padding(
  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
  child: Row(
    
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
             Checkbox(
    activeColor: Color(0xFF1366F6),
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
  
        ],
      ),
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
                          color:Color(0xFF1366F6),
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
                        color: Color(0xFF1366F6),
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