import 'package:flutter/material.dart';
import 'package:my_login_task/main.dart';
import 'package:my_login_task/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const Signin());
}

bool? _checkbox = false;
TextEditingController nametxt = TextEditingController();

TextEditingController passwrd = TextEditingController();

Future<void> checkLogin(BuildContext context, TextEditingController nametxt,
    TextEditingController passwrd) async {
  // URL to fetch data from
  String url = 'http://192.168.10.132:8004/fetch-records/';

  try {
    // Sending GET request to fetch data
    var response = await http.get(Uri.parse(url));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the JSON response
      var jsonData = json.decode(response.body);

      // Ensure 'data' key exists in the response and is a List
      if (jsonData['data'] != null && jsonData['data'] is List) {
        var data = jsonData['data'];
        print('Fetched Data: $data');

        // Check if data is not empty
        if (data.isNotEmpty) {
          bool isValidUser = false;

          // Loop through the fetched data to check if username and password match
          for (var user in data) {
            print('Checking user: ${user['name']} against ${nametxt.text}');
            print(
                'Checking password: ${user['password']} against ${passwrd.text}');

            // Ensure that 'name' and 'password' are treated as strings, regardless of the original type
            String username = user['name'].toString();
            String password = user['password'].toString();

            // Case-insensitive comparison for username and exact match for password
            if (username.toLowerCase() == nametxt.text.toLowerCase() &&
                password == passwrd.text) {
              isValidUser = true;
              break;
            }
          }

          if (isValidUser) {
            showMessage(context, "Signed In successfully!", true);
          } else {
            showMessage(context, "Invalid username or password!", false);
          }
        } else {
          showMessage(context, "No users found in the data!", false);
        }
      } else {
        showMessage(context, "Invalid data format!", false);
      }
    } else {
      showMessage(context,
          "Failed to fetch data. Status: ${response.statusCode}", false);
    }
  } catch (e) {
    showMessage(context, "Error: $e", false);
  }
}

/*Future<void> checkLogin(BuildContext context, TextEditingController nametxt,
    TextEditingController passwrd) async {
  // Using GET request
  String url =
      'http://192.168.10.132:8004/fetch-records/?name=${nametxt.text}&password=${passwrd.text}';

  try {
    // Send GET request with query parameters
    var response = await http.get(
      Uri.parse(url),
    );

    // Debugging: Print response status and body
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'success') {
        showMessage(context, "Signed In successfully!", true);
      } else {
        showMessage(context, "Invalid username or password!", false);
      }
    } else {
      showMessage(context,
          "Failed to fetch data. Status: ${response.statusCode}", false);
    }
  } catch (e) {
    showMessage(context, "Error: $e", false);
  }
}*/

/*Future<void> checkLogin(
    BuildContext context, String nametxt, String passwrd) async {
  String url = 'http://192.168.10.132:8004/fetch-records/';

  try {
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type":
            "application/json", // Set to application/json for JSON format
        // If your API needs authentication, add the token here
        // "Authorization": "Bearer YOUR_TOKEN_HERE"
      },
      body: json.encode({
        'username': nametxt,
        'password': passwrd,
      }),
    );

    // Debugging: Print the response status and headers
    print("Response Status: ${response.statusCode}");
    print("Response Headers: ${response.headers}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data.isNotEmpty) {
        showMessage(context, "Signed In successfully!", true);
      } else {
        showMessage(context, "Invalid username or password!", false);
      }
    } else {
      showMessage(context,
          "Failed to Fetch Data. Status: ${response.statusCode}", false);
    }
  } catch (e) {
    showMessage(context, "Error: $e", false);
  }
}*/

Future<void> postData() async {
  var data = {"name": nametxt.text, 'password': passwrd.text};
  http.Response response = await http.post(
      Uri.parse('http://192.168.10.132:8004/fetch-records/'),
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
/*Future<void> checkLogin(BuildContext context, name, String password) async {
  String url = 'http://192.168.10.132:8004/fetch-records/';

  try {
    var response = await http.post(
      Uri.parse(url),
      body: {
        'username': nametxt.text,
        'password': passwrd.text,
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      if (data.isNotEmpty) {
        showMessage(context, "Signed In successfully!", true);
      } else {
        //_showMessage('Invalid username or password!', Colors.red);
        showMessage(context, "Invalid username or password!", true);
      }
    } else {
      showMessage(context,
          "Failed to Fetch Data. Status: ${response.statusCode}", false);
    }
  } catch (e) {
    showMessage(context, "Error: $e", false);
  }
}*/

void showMessage(BuildContext context, String message, bool isSuccess) {
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
        size.width / 2, size.height + 70, // Curve to the bottom-center
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
                      height: 100.0,
                    ),
                    Text(
                      'Sign In Now',
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
                      child: TextField(
                        controller: nametxt,
                        decoration: InputDecoration(
                          hintText: "Enter Name",
                          //filled: true,
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
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                      child: TextField(
                        controller: passwrd,
                        style: TextStyle(color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: "Password",
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
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                  'Remember me',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 180,
                            ),
                            TextButton(
                              onPressed: null,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.grey),
                              ),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 130.0,
                    ),
                    TextButton(
                        onPressed: () {
                          checkLogin(context, nametxt, passwrd);
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
                            'SIGN IN',
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
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.transparent, // Transparent background
                          shadowColor: Colors.transparent, // Removes the shadow
                          elevation: 0, // Removes the button elevation
                        ),
                        child: Text(
                          'Sign Up from here',
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
