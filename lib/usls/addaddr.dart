import 'dart:convert';

import 'package:template/models/categorymodel/cate.dart';
import 'package:template/profilePages/addr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditAddrePage extends StatefulWidget {
  final Color adth;
  final int userind;

  // ignore: use_key_in_widget_constructors
  const EditAddrePage({required this.adth, required this.userind});

  @override
  State<EditAddrePage> createState() => _EditAddrePageState();
}

class _EditAddrePageState extends State<EditAddrePage> {
  bool done = false;
  bool checkValue = true;

  final namc = TextEditingController();
  final emailc = TextEditingController();
  final passc = TextEditingController();
  final mobc = TextEditingController();
  final List<TextEditingController> add = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool didsave = false;
  String msg = "";
  bool registered = false;
  bool agreeToTerms = false;
  bool doiyyy = true;

  _runCheck() {
    if (checkValue == true) {
      checkValue = false;
    } else {
      checkValue = true;
    }
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  bool showRules = false;

  _getsingleAdd() async {
    try {
      //     final req = await http.post(
      //   Uri.parse("${BASE_URL}cart/add"),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': "Bearer token", // Replace with actual token
      //   },
      //   body: jsonEncode({
      //     "VariantId": id,
      //     "quantity": qu,
      //   }),
      // );

      if (widget.userind != -1) {
        final req = await http.get(
          Uri.parse("${BASE_URL}address/${widget.userind}"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer ${userToken}",
          },
        );

        if (req.statusCode == 200) {
          add[0].text = jsonDecode(req.body)["data"]["name"];
          add[1].text = jsonDecode(req.body)["data"]["phone"];
          add[2].text = jsonDecode(req.body)["data"]["houseNumber"];
          add[3].text = jsonDecode(req.body)["data"]["addressLine1"];
          add[4].text = jsonDecode(req.body)["data"]["addressLine2"];
          add[5].text = jsonDecode(req.body)["data"]["pincode"];
          add[6].text = jsonDecode(req.body)["data"]["area"];
          add[7].text = jsonDecode(req.body)["data"]["city"];
          add[8].text = jsonDecode(req.body)["data"]["state"];
          add[9].text = jsonDecode(req.body)["data"]["country"];
          print("got adddddaa");
          if (!mounted)
            return; // prevents calling setState if widget is disposed

          setState(() {});
        } else {
          print(" nahi mila sungkle addd");
        }
      }
    } catch (e) {
      msg = "error hai ji interneta lkakaa";
      print(e);
    }
  }

  Future<void> _careateAddtoCart() async {
    try {
      //     final req = await http.post(
      //   Uri.parse("${BASE_URL}cart/add"),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': "Bearer token", // Replace with actual token
      //   },
      //   body: jsonEncode({
      //     "VariantId": id,
      //     "quantity": qu,
      //   }),
      // );

      if (widget.userind == -1) {
        final req = await http.post(
          Uri.parse("${BASE_URL}address"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer ${userToken}",
          },
          body: jsonEncode({
            "houseNumber": (add[2].text != "") ? add[2].text : "420",
            "name": (add[0].text != "") ? add[0].text : "Rohit JIiii",
            "addressLine1":
                (add[3].text != "") ? add[3].text : "Great gggg Road",
            "pincode": (add[5].text != "") ? add[5].text : "122315",
            "city": (add[7].text != "") ? add[7].text : "Rur",
            "state": (add[8].text != "") ? add[8].text : "Chtisgarh",
            "country": (add[9].text != "") ? add[9].text : "Indikooa",
            "addressLine2": (add[4].text != "") ? add[4].text : "Citttvil",
            "area": (add[6].text != "") ? add[6].text : "Civil Lifffffne",
            "phone": (add[1].text != "") ? add[1].text : "9399274490",
            "countryCode": (add[10].text != "") ? add[10].text : "+91",
          }),
        );

        if (req.statusCode == 200) {
          msg = jsonDecode(req.body)["message"];
          print(jsonDecode(req.body)["message"]);
          print("kaibe jiiiiiii yayyaya");
          done = true;

          if (!mounted) return;
          Navigator.pop(context);
        } else {
          msg = 'jjsjsjjsjsj';
          print(jsonDecode(req.body)["message"]);
        }
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {
          msg;
        });
      } else {
        final req = await http.put(
          Uri.parse("${BASE_URL}address/${widget.userind}"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer ${userToken}",
          },
          body: jsonEncode({
            "houseNumber": (add[2].text != "") ? add[2].text : "420",
            "name": (add[0].text != "") ? add[0].text : "Rohit JIiii",
            "addressLine1":
                (add[3].text != "") ? add[3].text : "Great gggg Road",
            "pincode": (add[5].text != "") ? add[5].text : "122315",
            "city": (add[7].text != "") ? add[7].text : "Rur",
            "state": (add[8].text != "") ? add[8].text : "Chtisgarh",
            "country": (add[9].text != "") ? add[9].text : "Indikooa",
            "addressLine2": (add[4].text != "") ? add[4].text : "Citttvil",
            "area": (add[6].text != "") ? add[6].text : "Civil Lifffffne",
            "phone": (add[1].text != "") ? add[1].text : "9399274490",
            "countryCode": (add[10].text != "") ? add[10].text : "+91",
          }),
        );

        if (req.statusCode == 200) {
          msg = jsonDecode(req.body)["message"];
          print(msg);
          print("kaibe jiiiiiii yayyaya");
          done = true;
          if (!mounted) return;
          Navigator.pop(context);
        } else {
          msg = jsonDecode(req.body)["message"];
          print(msg);
        }
      }
      if (!mounted) return;
      _getsingleAdd();
      if (!mounted) return; // prevents calling setState if widget is disposed

      setState(() {
        msg;
      });
    } catch (e) {
      msg = "error hai ji interneta lkakaa";
      print(e);
    }
  }

  // myController.text = "hshshhshs";
  //  myController2 = "hshshhshs";
  //  myController3 = "hshshhshs";
  //  myController4 ="hshhs";
  Color rit = const Color.fromARGB(248, 231, 222, 222);
  int rith = 50;

  @override
  Widget build(BuildContext context) {
    if (doiyyy) {
      doiyyy = false;
      _getsingleAdd();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(15),
          padding: const EdgeInsets.only(top: 56.0, bottom: 80),
          child: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Edit/Add Address",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Full Name
                TextField(
                  controller: add[0],
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    prefixIcon: Icon(Icons.person_outline),
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

                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
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
                        controller: add[1],
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
                TextField(
                  controller: add[2],
                  decoration: InputDecoration(
                    labelText: "House Number",
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
                TextField(
                  controller: add[3],
                  decoration: InputDecoration(
                    labelText: "Address Line 1",
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
                TextField(
                  controller: add[4],
                  decoration: InputDecoration(
                    labelText: "Address Line 2",
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
                TextField(
                  controller: add[5],
                  decoration: InputDecoration(
                    labelText: "Pincode",
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
                TextField(
                  controller: add[6],
                  decoration: InputDecoration(
                    labelText: "Area",
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
                TextField(
                  controller: add[7],
                  decoration: InputDecoration(
                    labelText: "City",
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
                TextField(
                  controller: add[8],
                  decoration: InputDecoration(
                    labelText: "State",
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
                TextField(
                  controller: add[9],
                  decoration: InputDecoration(
                    labelText: "Country",
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
                SizedBox(height: 6),

                // Phone Number

                // Terms and conditions
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (value) {
                        if (!mounted)
                          return; // prevents calling setState if widget is disposed

                        setState(() => agreeToTerms = value!);
                      },
                    ),
                    Expanded(child: Text("I agree to Terms & Conditions.")),
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
                      if (done) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddrPage(adth: widget.adth),
                          ),
                          (context) => false,
                        );
                      }
                      // if (registered) {
                      //   // Navigator.push(
                      //   //   context,
                      //   // MaterialPageRoute(
                      //   //     builder: (context) => OtpPage(
                      //   //         adth: widget.adth,
                      //   //         phoneNumber: createData['phone'])),
                      //   // );
                      // } else {
                      //   if (didsave ||
                      //       (namc.text.length >= 3 &&
                      //           mobc.text.length == 10 &&
                      //           agreeToTerms)) {
                      //     showRules = false;

                      // if (!didsave) {
                      //   didsave = true;
                      //   createData = {
                      //     "name": namc.text,
                      //     "email": emailc.text,
                      //     "phone": mobc.text,
                      //     "password": passc.text,
                      //     "role": "user"
                      //   };
                      // }

                      // getregis();

                      // } else {
                      // call = Colors.red;
                      // if (!mounted) return; // prevents calling setState if widget is disposed

                      setState(() {});

                      if (add[0].text.length >= 3 &&
                          add[1].text.length == 10 &&
                          agreeToTerms &&
                          add[5].text.length == 6) {
                        if (!mounted)
                          return; // prevents calling setState if widget is disposed

                        setState(() {
                          msg = "getting registered..........";
                        });
                        _careateAddtoCart();

                        mobc.clear();
                        agreeToTerms = false;
                        namc.clear();
                        emailc.clear();
                        passc.clear();

                        for (int i = 0; i < 10; i++) add[i].clear();
                        showRules = false;
                      } else {
                        if (!mounted)
                          return; // prevents calling setState if widget is disposed

                        setState(() {
                          msg =
                              "Please Enter Valid Details as name must be more than 3 characters and phone number must be 10 digits and pincode must be 6 digits && agree to terms&conditions";
                        });
                      }

                      // } else {
                      //   mobc.clear();
                      //   agreeToTerms = false;
                      //   namc.clear();
                      //   emailc.clear();
                      //   passc.clear();
                      //   showRules = true;
                      //   if (!mounted) return; // prevents calling setState if widget is disposed

                      setState(() {});
                      // }
                      // }
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
                                (done)
                                    ? "Save Address"
                                    : ((widget.userind == -1)
                                        ? "Add Address"
                                        : "Edit Address"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
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
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
