import 'package:flutter/material.dart';
import 'package:my_login_task/signin.dart';
import 'package:my_login_task/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const Signup());
}

TextEditingController nametxt = TextEditingController();
TextEditingController emailtxt = TextEditingController();
TextEditingController passwrd = TextEditingController();

/*Future<void> postData() async {
  var data = {
    "name": nametxt.text,
    'contact': emailtxt.text,
    'password': passwrd.text
  };
  http.Response response = await http.post(
      Uri.parse(
          'http://192.168.10.132:8004/insert-record/${nametxt.text}/${emailtxt.text}/${passwrd.text}/'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    // Data posted successfully
    print('Sign UP successfully');
  } else {
    // Error occurred while posting data
    print('Failed..!!');
  }
}

Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print('Could not launch $url');
    // Optionally show a dialog/snackbar to notify the user
  }
}*/

// Function to send request when the button is clicked
/*Future<void> sendData(BuildContext context) async {
  String url =
      "http://192.168.10.132:8004/insert-record/${nametxt}/${emailtxt}/${passwrd}/";

  try {
    // Make a POST request
    final response = await http.get(
      Uri.parse(url),
      //headers: {'Content-Type': 'application/json'},
    );
    print(response);

    if (response.statusCode == 200) {
      // Data successfully posted
      showMessageBox(context, "Success", "Data saved successfully.");
    } else {
      // Server responded with an error
      showMessageBox(context, "Error",
          "Failed to save data. Status code: ${response.statusCode}");
    }
  } catch (e) {
    // Exception caught
    showMessageBox(context, "Exception", "An error occurred: $e");
  }
}*/

Future<void> insertRecord(BuildContext context, name, email, password) async {
  final baseUrl = "http://192.168.10.132:8004/insert-record";
  final url = "$baseUrl/$name/$email/$password/";

  try {
    // Make a GET request to your backend
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Show success message
      showMessage(context, "Record inserted successfully!", true);
    } else {
      // Show failure message
      showMessage(context,
          "Failed to insert record. Status: ${response.statusCode}", false);
    }
  } catch (e) {
    // Show error message if the request fails
    showMessage(context, "Error: $e", false);
  }
}

void showMessageBox(BuildContext context, message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Warning..!!"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

// Function to show message box or snack bar with the status

// Function to show a message box
void showMessage(BuildContext context, message, bool isSuccess) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(isSuccess ? "Success" : "Failed"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

bool? _checkbox = false;
bool _validateName = false;
bool _validateEmail = false;
bool _validatePassword = false;
bool _validateRepeatPassword = false;

// Custom clipper to define the shape
class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 80); // Clip the bottom 40 pixels
    path.quadraticBezierTo(
      size.width / 2, size.height + 70, // Curve point for bottom-center
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

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nametxt = TextEditingController();
  final TextEditingController emailtxt = TextEditingController();
  final TextEditingController passwrd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Stack(children: [
                      ClipPath(
                        clipper: CustomShapeClipper(),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          height: 250,
                          decoration: BoxDecoration(
                              color: Color(0xFF1366F6),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/Untitled design (1).png',
                                ),
                                fit: BoxFit.contain,
                                //alignment: Alignment.center,
                              )),
                        ),
                      ),
                      Positioned(
                          child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyWidget()),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ))
                    ]),
                    SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      'Create Account',
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      child: TextField(
                        controller: nametxt,
                        decoration: InputDecoration(
                          errorText: _validateName ? 'Kindly Enter Name' : null,
                          hintText: "Enter Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xFF1366F6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      child: TextField(
                        controller: emailtxt,
                        decoration: InputDecoration(
                          hintText: "Enter Mailid",
                          errorText:
                              _validateEmail ? 'Kindly Enter Mailid' : null,
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Color(0xFF1366F6),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      child: TextFormField(
                        controller: passwrd,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: "Password",
                          errorText: _validatePassword
                              ? 'Kindly Enter password'
                              : null,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: "Repeat Password",
                          errorText: _validateRepeatPassword
                              ? 'Kindly Enter password'
                              : null,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20.0),
                        child: Row(
                          children: [
                            Checkbox(
                                activeColor: Color(0xFF1366F6),
                                checkColor: Colors.white,
                                tristate: true,
                                value: _checkbox,
                                onChanged: (val) {
                                  setState(() {
                                    _checkbox = val;
                                  });
                                }),
                            Text(
                              'I agree to the ',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            //SizedBox(width: 180,),

                            Text(
                              'Terms and Conditions',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF1366F6),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 60.0,
                    ),
                    TextButton(
                        onPressed: () {
                          _validateName = nametxt.text.isEmpty;
                          _validateEmail = emailtxt.text.isEmpty;
                          _validatePassword = passwrd.text.isEmpty;
                          _validateRepeatPassword = passwrd.text.isEmpty;
                          if (!_validateName &&
                              !_validateEmail &&
                              !_validateRepeatPassword &&
                              !_validatePassword) {
                            // Call the URL launcher function
                            insertRecord(
                              context,
                              nametxt.text,
                              emailtxt.text,
                              passwrd.text,
                            );
                          } else {
                            showMessageBox(
                                context, "Kindly Enter All Details..!!");
                          }
                        },
                        child: Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF1366F6),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 45.0,
                    ),
                    Text(
                      "Already have an account ?",
                      style: TextStyle(
                        fontFamily: 'Cambria',
                        fontSize: 15.0,
                        color: Colors.blueGrey,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signin()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.transparent, // Transparent background
                          shadowColor: Colors.transparent, // Removes the shadow
                          elevation: 0, // Removes the button elevation
                        ),
                        child: Text(
                          'Sign In from here',
                          style: TextStyle(
                            color: Color(0xFF1366F6),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ))),
      ),
    );
  }
}
