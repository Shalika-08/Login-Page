import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void showEditDialog(BuildContext context, Map<String, dynamic> record) {
  TextEditingController idcontroller = TextEditingController(
      text: record["id"].toString()); // Convert int to String
  TextEditingController nameController =
      TextEditingController(text: record["name"]);
  TextEditingController emailcontroller =
      TextEditingController(text: record["email"]);
  TextEditingController passwordcontroller =
      TextEditingController(text: record["password"]);

  Future<void> updateRecord() async {
    String id = idcontroller.text;
    String name = nameController.text;
    String email = emailcontroller.text;
    String password = passwordcontroller.text;

    String url =
        "http://192.168.10.131:8004/update-record/$id/$name/$email/$password/";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Record updated successfully!")),
        );
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Update()), // Navigate to next screen
        );
        // Close dialog
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update record!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Edit Record"),
        content: SingleChildScrollView(
          // Prevents overflow issues
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              TextField(
                controller: idcontroller,
                decoration: InputDecoration(
                  labelText: "ID",
                  labelStyle: TextStyle(
                      //fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1366F6)), // Style for label
                ),
                enabled: false, // Make ID read-only
              ),
              SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 15),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true, // Hide password
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
            },
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF1366F6), // Button background color
              foregroundColor: Colors.white, // Text color
              padding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              updateRecord();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1366F6), // Button background color
              foregroundColor: Colors.white, // Text color
              padding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
            ),
            child: Text(
              "Save",
            ),
          ),
        ],
      );
    },
  );
}

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  List<Map<String, dynamic>> records = [];
  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when screen loads
  }

  // Function to fetch data from API
  Future<void> fetchData() async {
    final String apiUrl = "http://192.168.10.131:8004/fetch-records/";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        setState(() {
          if (responseData['data'] != null && responseData['data'].isNotEmpty) {
            records = List<Map<String, dynamic>>.from(responseData['data']);
          }
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Records")),
      body: records.isEmpty
          ? Center(child: CircularProgressIndicator()) // Loader while fetching
          : Padding(
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: records.length, // Number of records to display
                itemBuilder: (context, index) {
                  final record = records[index]; // Get record for current index
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID: ${record["id"] ?? "No ID"}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Name: ${record["name"] ?? "No Name"}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Mail: ${record["email"] ?? "No Address"}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Password: ${record["password"] ?? "No Password"}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 5),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Color(0xFF1366F6)), // View Icon
                                  onPressed: () {
                                    showEditDialog(context, record);

                                    //print("View button pressed for ${record["name"]}");
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: Color(0xFF1366F6)), // Delete Icon
                                  onPressed: () {
                                    //print("Delete button pressed for ${record["name"]}");
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
