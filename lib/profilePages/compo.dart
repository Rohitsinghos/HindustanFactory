import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/models/categorymodel/cate.dart';

class QrPage extends StatelessWidget {
  const QrPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),

        // Get available height and width of the build area of this widget. Make a choice depending on the size.
      ),
      child: Container(
        // height: height - 400,
        width: width - 0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.cancel,
                          size: 28,
                          color:
                              Colors
                                  .blue, // const Color.fromARGB(255, 111, 110, 110),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Scan this QR to redirect to the website",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    // fontWeight: FontWeight.bold,
                    // color: blackTitle,
                  ),
                ),

                SizedBox(height: 25),

                QrImageView(
                  data: 'jskjdksjkjskjskjksjsjjs',
                  size: 220,
                  version: QrVersions.auto,
                ),

                // Icon(Icons.image),
                SizedBox(height: 35),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          // width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: MaterialButton(
                              color: adth,
                              // padding: EdgeInsets.symmetric(horizontal: 10),
                              onPressed: () {
                                // copyText(
                                //   (Stat == null || Stat["referralLink"] == null)
                                //       ? 'https://bounten.com/lakshit'
                                //       : "${Stat["referralLink"]}",
                                // );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13.0,
                                  horizontal: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.copy, color: Colors.white),
                                    SizedBox(width: 15),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Text(
                                        'Copy Link',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Card(
                      //   borderOnForeground: false,
                      //   child: Container(
                      //     width: 220,

                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12),
                      //       border: Border.all(color: adth),
                      //     ),
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadiusGeometry.circular(12),
                      //       child: MaterialButton(
                      //         color: Colors.white,
                      //         onPressed: () {
                      //           shareImageAndText();
                      //         },
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(Icons.share_outlined, color: adth),
                      //             Padding(
                      //               padding: const EdgeInsets.all(15.0),
                      //               child: Text(
                      //                 'Share',
                      //                 style: TextStyle(color: adth),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
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

class WithdrowPage extends StatefulWidget {
  const WithdrowPage({super.key});

  @override
  State<WithdrowPage> createState() => _WithdrowPageState();
}

class _WithdrowPageState extends State<WithdrowPage> {
  final cac = TextEditingController();
  final cif = TextEditingController();
  final cam = TextEditingController();

  bool logi = false;
  String msg = "";

  Future<void> withdrawSend() async {
    try {
      final rs = await http.post(
        Uri.parse('${BASE_URL}/wallets/withdraw'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
        body: jsonEncode({
          "mode": "bank",
          "account_number": "${cac.text}",
          "ifsc": "${cif.text}",
          "amount": "${cam.text}",

          // "AvatarId": (avarId == -1) ? null : avarId,
        }),
      );
      if (rs.statusCode == 200) {
        print("gttgggg666666success userrrrrrrrrrrrrrrrrrrr");
        print(jsonDecode(rs.body));

        // if (!mounted) {
        //   return;
        // }
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ProfilePage(adth: widget.adth, admin: 0),
        //   ),
        // );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("${jsonDecode(rs.body)}")));

        // newc.dispose();
        // cofc.dispose();
        Navigator.pop(context);
      } else {
        print(jsonDecode(rs.body));
        print("nnnnnnnjjjkkkskksk");
        print(jsonDecode(rs.body));

        // if (!mounted) {
        //   return;
        // }
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => ProfilePage(adth: widget.adth, admin: 0),
        //   ),
        // );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("${jsonDecode(rs.body)}")));

        // newc.dispose();
        // cofc.dispose();
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Withdrawal Request",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Account No.",
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
              ),

              SizedBox(height: 8),
              //  SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                controller: cac,
                decoration: InputDecoration(
                  hintText: "Account No.",
                  hintStyle: TextStyle(color: adth),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: adth),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: adth),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "IFSC Code",
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
              ),

              SizedBox(height: 8),
              //  SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.text,
                controller: cif,
                decoration: InputDecoration(
                  hintText: "IFSC Code",
                  hintStyle: TextStyle(color: adth),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: adth),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: adth),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Amount",
                  style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
                ),
              ),

              SizedBox(height: 8),
              //  SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                controller: cam,
                decoration: InputDecoration(
                  hintText: "Amount",
                  hintStyle: TextStyle(color: adth),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: adth),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: adth),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: Text(
              //     (logi == false) ? msg : '',
              //     style: TextStyle(color: Colors.red, fontSize: 12),
              //   ),
              // ),
              SizedBox(height: 20),

              MaterialButton(
                height: 50,
                // minWidth: 283,
                color: adth,
                onPressed: () {
                  if (cac.text.length <= 5 ||
                      cif.text.length <= 5 ||
                      cac.text.isEmpty) {
                    logi = false;
                    msg =
                        "Account No. should be more than 5 digits and IFSC code should be more than 5 characters and amount can not be empty!";
                    setState(() {});
                    return;
                  }
                  msg = "In process..";
                  logi = true;
                  setState(() {});
                  // _getChangePass();

                  withdrawSend();
                },
                child: Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Submit Request",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Icon(color: Colors.white, Icons.lock_open),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  msg,
                  style: TextStyle(
                    color: (logi == true) ? Colors.green : Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),

              if (logi) LinearProgressIndicator(),

              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color:
                            Colors
                                .blue, // const Color.fromARGB(255, 111, 110, 110),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Are you sure, log out??",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              // QrImageView(
              //   data: '${Stat["referralLink"]}',
              //   size: 200,
              //   version: QrVersions.auto,
              // ),

              // // Icon(Icons.image),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        width: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: MaterialButton(
                            color: adth,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      borderOnForeground: false,
                      child: Container(
                        width: 220,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: adth),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: MaterialButton(
                            color: Colors.white,
                            onPressed: () {
                              // final storage = FlutterSecureStorage();

                              // storage.delete(
                              //   key:
                              //       'bota**@useryubountensaahsjkhnxloggedtoken',
                              // );
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         MyApp(isLoggedIn: false),
                              //   ),
                              //   (context) => false,
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: adth),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExitPage extends StatelessWidget {
  const ExitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color:
                            Colors
                                .blue, // const Color.fromARGB(255, 111, 110, 110),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Are you sure, Exit App??",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              // QrImageView(
              //   data: '${Stat["referralLink"]}',
              //   size: 200,
              //   version: QrVersions.auto,
              // ),

              // // Icon(Icons.image),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        width: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: MaterialButton(
                            color: adth,
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      borderOnForeground: false,
                      child: Container(
                        width: 220,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: adth),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: MaterialButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: adth),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetPicPage extends StatelessWidget {
  const GetPicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color:
                            Colors
                                .blue, // const Color.fromARGB(255, 111, 110, 110),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Select, Image Source?",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              // QrImageView(
              //   data: '${Stat["referralLink"]}',
              //   size: 200,
              //   version: QrVersions.auto,
              // ),

              // // Icon(Icons.image),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        width: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: MaterialButton(
                            color: adth,
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      borderOnForeground: false,
                      child: Container(
                        width: 220,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: adth),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: MaterialButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Galley',
                                    style: TextStyle(color: adth),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
