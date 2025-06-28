import 'dart:convert';

import 'package:Template/loginPaages/otppage.dart';
import 'package:Template/main.dart';
import 'package:Template/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  final Color adth;

  LogIn({required this.adth});

  @override
  State<LogIn> createState() => _LogInState();
}

Color call = Colors.black;
bool checkValue = true;

final myController = TextEditingController();
final myController2 = TextEditingController();
final myController3 = TextEditingController();
final myController4 = TextEditingController();

// myController.text = "hshshhshs";
//  myController2 = "hshshhshs";
//  myController3 = "hshshhshs";
//  myController4 ="hshhs";
Color rit = const Color.fromARGB(248, 231, 222, 222);
double rith = 50;
_runCheck() {
  checkValue = false;
  setState() {}
  ;
}

// String apiUrl = 'https://yourapi.com/data';
//    String token = 'your_token_here';
class _LogInState extends State<LogIn> {
  // Replace with your actual token

  // Future<void> fetchProducts() async {

  //   final response = await http.get(
  //   Uri.parse('https://hindustanapi.mtlapi.socialseller.in/api/store-users/send-otp'),
  //   headers: {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json', // Optional but recommended
  //   },
  // );

  // if (response.statusCode == 200)  {
  //   final data = jsonDecode(response.body);
  //   print('Success: $data');
  // } else {
  //   print('Error ${response.statusCode}: ${response.body}');
  // }
//
  // }

  TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.adth,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "Welcome back !! Let's get you back to\nearning & shopping.",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Phone Number Input Row
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Phone Number",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text("+91"),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: controller1,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(color: widget.adth),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: widget.adth),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: widget.adth),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),

                // Login Button
                MaterialButton(
                  height: 50,
                  minWidth: 283,
                  color: widget.adth,
                  onPressed: () {
                    if (controller1.text.length == 10) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OtpPage(
                                adth: widget.adth,
                                phoneNumber: controller1.text)),
                      );
                      // } else {
                      // call = Colors.red;
                      // setState(() {});
                    } else {
                      controller1.clear();
                    }
                  },
                  child: Center(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: Center(
                                child: Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )),
                          ),
                          Icon(
                            color: Colors.white,
                            Icons.lock_open,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
