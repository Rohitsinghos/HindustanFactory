import 'dart:convert';

import 'package:Template/loginPaages/otppage.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  final Color adth;

  RegisterPage({required this.adth});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool checkValue = true;

  final namc = TextEditingController();
  final emailc = TextEditingController();
  final passc = TextEditingController();
  final mobc = TextEditingController();

// myController.text = "hshshhshs";
//  myController2 = "hshshhshs";
//  myController3 = "hshshhshs";
//  myController4 ="hshhs";
  Color rit = const Color.fromARGB(248, 231, 222, 222);
  int rith = 50;
  bool didsave = false;
  String msg = "";
  bool registered = false;
  bool agreeToTerms = false;
  _runCheck() {
    if (checkValue == true) {
      checkValue = false;
    } else {
      checkValue = true;
    }
    setState(() {});
  }

  bool showRules = false;

  Future<void> getregis() async {
    setState(() {
      msg = "getting registered";
    });
    if (createData != {}) {
      try {
        final getreg = await http.post(Uri.parse("${BASE_URL}store-users"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'name': createData["name"],
              'email': createData["email"],
              'phone': "+91${createData["phone"]}",
              'password': createData["password"],
            }));

        print({
          'name': createData["name"],
          'email': createData["email"],
          'phone': "+91${createData["phone"]}",
          'password': createData["password"],
        });

        if (getreg.statusCode == 200) {
          msg = "user registered successfully.";
          print("registered");
          print(getreg.body);
          // registered = true;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpPage(
                    adth: widget.adth, phoneNumber: createData['phone'])),
          );
        } else if (getreg.statusCode == 400) {
          print(json.decode(getreg.body)['message']);
          msg = "user already registered here!.";
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpPage(
                    adth: widget.adth, phoneNumber: createData['phone'])),
          );
          // registered = true;
        } else {
          print("user not registered getting errors.");
        }
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: widget.adth,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("Register",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Full Name
                  TextField(
                    controller: namc,
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      prefixIcon: Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: widget.adth),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelStyle: TextStyle(color: widget.adth),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Email
                  TextField(
                    controller: emailc,
                    decoration: InputDecoration(
                      labelText: "Email address",
                      prefixIcon: Icon(Icons.email_outlined),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: widget.adth),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelStyle: TextStyle(color: widget.adth),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Password
                  TextField(
                    controller: passc,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock_outline),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: widget.adth),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelStyle: TextStyle(color: widget.adth),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Phone Number
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text("+91"),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          controller: mobc,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: widget.adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelStyle: TextStyle(color: widget.adth),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Terms and conditions
                  Row(
                    children: [
                      Checkbox(
                        value: agreeToTerms,
                        onChanged: (value) {
                          setState(() => agreeToTerms = value!);
                        },
                      ),
                      Expanded(
                        child: Text("I agree to Terms & Conditions."),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Register Button
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MaterialButton(
                      height: 53,
                      minWidth: 295,
                      color: widget.adth,
                      onPressed: () {
                        if (registered) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpPage(
                                    adth: widget.adth,
                                    phoneNumber: createData['phone'])),
                          );
                        } else {
                          if (didsave ||
                              (namc.text.length >= 3 &&
                                  emailc.text.length >= 6 &&
                                  mobc.text.length == 10 &&
                                  passc.text.length >= 5 &&
                                  agreeToTerms)) {
                            showRules = false;

                            if (!didsave) {
                              didsave = true;
                              createData = {
                                "name": namc.text,
                                "email": emailc.text,
                                "phone": mobc.text,
                                "password": passc.text,
                                "role": "user"
                              };
                            }

                            getregis();

                            // } else {
                            // call = Colors.red;
                            // setState(() {});
                            mobc.clear();
                            agreeToTerms = false;
                            namc.clear();
                            emailc.clear();
                            passc.clear();
                            showRules = false;
                            setState(() {});
                          } else {
                            mobc.clear();
                            agreeToTerms = false;
                            namc.clear();
                            emailc.clear();
                            passc.clear();
                            showRules = true;
                            setState(() {});
                          }
                        }
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             MyHome(adth: widget.adth, admin: 0)),
                        //     (route) => false);
                      },
                      child: Center(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                (!registered)
                                    ? "Register"
                                    : "Verify Phonenumber",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  color: Colors.white,
                                  (!registered)
                                      ? Icons.lock_open
                                      : Icons.verified_user,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (showRules)
                          ? "Please fill all the fields as : name must be more than 2 characters, email must be equal/more than 5 characters, phone number must be 10 digits, password must be more than 5-8 characters, and agree to terms and conditions.."
                          : msg,
                      style: TextStyle(color: Colors.red, fontSize: 9),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//   Widget _getIn(String hin, IconData iconi) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 25.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 8),
//             height: 50,
//             color: rit,
//             child: Row(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(
//                     iconi,
//                     size: 25,
//                   ),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: myController2,
//                     decoration: InputDecoration.collapsed(
//                       hintText: '$hin',
//                       hintStyle: TextStyle(fontSize: 14),
//                     ),
//                     keyboardType: TextInputType.text,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
}

// import 'package:Template/pages/home.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';

// class RegisterPage extends StatefulWidget {
//   final Color adth;

//   RegisterPage({required this.adth});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// bool checkValue = true;

// final myController = TextEditingController();
// final myController2 = TextEditingController();
// final myController3 = TextEditingController();
// final myController4 = TextEditingController();

// // myController.text = "hshshhshs";
// //  myController2 = "hshshhshs";
// //  myController3 = "hshshhshs";
// //  myController4 ="hshhs";
// Color rit = const Color.fromARGB(248, 231, 222, 222);
// int rith = 50;

// class _RegisterPageState extends State<RegisterPage> {
//   _runCheck() {
//     if (checkValue == true) {
//       checkValue = false;
//     } else {
//       checkValue = true;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: widget.adth,
//         toolbarHeight: 0,
//       ),
//       body: Container(
//         color: widget.adth,
//         height: BoxConstraints().maxHeight,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Container(
//                   color: Colors.white,
//                   width: 313,
//                   height: 525,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Padding(
//                         padding: const EdgeInsets.all(0.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   "Register",
//                                   style: TextStyle(
//                                       fontSize: 30,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             _getIn(
//                                 "Enter your full name", Icons.person_outline),
//                             _getIn(
//                               "Enter your Email Address",
//                               Icons.email_outlined,
//                             ),
//                             _getIn(
//                                 "Enter your Password", Icons.password_outlined),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Container(
//                                     margin: EdgeInsets.only(right: 10),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: SizedBox(
//                                         child: Container(
//                                           height: 50,
//                                           width: 50,
//                                           color: rit,
//                                           child: Center(
//                                             child: Text(
//                                               '+91',
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         color: rit, // or any background color
//                                         borderRadius: BorderRadius.circular(15),
//                                         // optional border
//                                       ),
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8),
//                                       child: Center(
//                                         child: TextField(
//                                           textAlign: TextAlign.center,
//                                           smartDashesType: null,
//                                           controller: myController4,
//                                           decoration: InputDecoration.collapsed(
//                                             hintText: 'Phone Number',
//                                             hintStyle: TextStyle(fontSize: 14),
//                                           ),
//                                           keyboardType: TextInputType.number,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 20.0),
//                               child: Container(
//                                 height: 30,
//                                 child: Row(
//                                   children: <Widget>[
//                                     Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Checkbox(
//                                             value: checkValue,
//                                             onChanged: (value) {
//                                               checkValue = value!;
//                                             })),
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 10.0),
//                                       child: Text(
//                                         'I agree to terms & conditions.',
//                                         style: TextStyle(fontSize: 12),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 27.0),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(12),
//                                 child: MaterialButton(
//                                   height: 50,
//                                   minWidth: 295,
//                                   color: widget.adth,
//                                   onPressed: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => MyHome(
//                                                 admin: 0, adth: widget.adth)));
//                                   },
//                                   child: Center(
//                                     child: Container(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Center(
//                                               child: Text(
//                                             "Register",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16),
//                                           )),
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 8.0),
//                                             child: Icon(
//                                               color: Colors.white,
//                                               Icons.lock_open,
//                                               size: 22,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _getIn(String hin, IconData iconi) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 25.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(15),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 8),
//             height: 50,
//             color: rit,
//             child: Row(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Icon(
//                     iconi,
//                     size: 25,
//                   ),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     controller: myController2,
//                     decoration: InputDecoration.collapsed(
//                       hintText: '$hin',
//                       hintStyle: TextStyle(fontSize: 14),
//                     ),
//                     keyboardType: TextInputType.text,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
