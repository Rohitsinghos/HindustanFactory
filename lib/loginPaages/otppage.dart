import 'dart:convert';

import 'package:Template/main.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  final String phoneNumber;
  final Color adth;

  OtpPage({required this.phoneNumber, required this.adth});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String msg = "Otp not sent...";
  bool varified = false;

  int stat = 1;
  bool getok = true;
  String phoneNumber = "";
  TextEditingController otpController = TextEditingController();

  _getstat(int a) {
    return msg;
  }

  Future<void> verifyOTP() async {
    getok = false;

    try {
      getok = false;
      final getotp = await http.post(
        Uri.parse('${BASE_URL}store-users/send-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': widget.phoneNumber,
        }),
      );

      print(getotp.body);

      msg = jsonDecode(getotp.body)["message"];

      // if (getotp.statusCode == 200) {
      //   print("otp minsss");
      //   stat = 2;
      // } else {
      //   print("otp not sent");
      //   stat = 1;
      // }

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  _verified() {
    setState(() {
      varified = true;
    });
  }

  Future<void> _otpVarify(String otp) async {
    try {
      final getvar = await http.post(
        Uri.parse('${BASE_URL}store-users/verify-otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': widget.phoneNumber,
          'otp': otp,
        }),
      );
      if (getvar.statusCode == 200) {
        print(getvar.body);
        final jsonBody = json.decode(getvar.body);

        LoginData = jsonBody["data"];
        userToken = LoginData["jwt"];
        setState(() {
          msg = "OTP varified successfully.";
        });

        store.write("bota**@userloggedtoken", userToken);
        print(LoginData);
        // store.write("token", LoginData[0]["token"]);
        // if (createData != {}) {
        //   try {
        //     final getreg = await http.post(Uri.parse("${BASE_URL}store-users"),
        //         headers: <String, String>{
        //           'Content-Type': 'application/json; charset=UTF-8',
        //         },
        //         body: jsonEncode(<String, String>{
        //           'name': createData["name"],
        //           'email': createData["email"],
        //           'phone': "+91${createData["phone"]}",
        //           'password': createData["password"],
        //         }));

        //     print({
        //       'name': createData["name"],
        //       'email': createData["email"],
        //       'phone': createData["phone"],
        //       'password': createData["password"],
        //     });

        //     if (getreg.statusCode == 200) {
        //       msg = "otp varified & user registered successfully.";
        //       print("registered");
        //     } else if (getreg.statusCode == 400) {
        //       print(json.decode(getreg.body)['message']);
        //     } else {
        //       print("not registered");
        //     }
        //   } catch (e) {
        //     print(e);
        //   }
        // }

        _verified();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyHome(adth: widget.adth, admin: 0)),
            (route) => false);

        print("are lallalalal");
        stat = 3;
      } else {
        print("hey naananna");
        print("hey naananna");
        msg = jsonDecode(getvar.body)["error"]["message"];
        setState(() {});
        stat = 4;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    verifyOTP();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    phoneNumber = widget.phoneNumber;
    return Scaffold(
      backgroundColor: widget.adth, // Orange background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Verify OTP',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Check your phone for the OTP and enter below.',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      'OTP Sent to:',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                      // textAlign: TextAlign.left,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "+91 $phoneNumber",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 17),
                    ),
                    SizedBox(width: 0),
                    IconButton(
                      icon: Icon(Icons.edit,
                          size: 20, color: Colors.grey.shade600),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: otpController,
                  onChanged: (value) {},
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Colors.deepOrange,
                    selectedColor: Colors.orange,
                    inactiveColor: Colors.grey.shade300,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF5722),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (varified == false) {
                      if (otpController.text.length == 6) {
                        _otpVarify(otpController.text);
                      } else {
                        otpController.clear();
                      }
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MyHome(adth: widget.adth, admin: 0)),
                          (route) => false);
                    }
                  },
                  icon: Icon((varified) ? Icons.verified : Icons.verified,
                      color: Colors.white),
                  label: Text((varified) ? "Get Started" : 'Verify',
                      style: TextStyle(color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_getstat(stat),
                      style: TextStyle(color: Colors.red, fontSize: 9)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
