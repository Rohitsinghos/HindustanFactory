import 'dart:convert';
import 'dart:ffi';

import 'package:Template/deepPage/razerpay.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/profilePages/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PremiumPage extends StatefulWidget {
  final Color adth;

  PremiumPage({required this.adth});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  bool prrr = false;
  String naamm = "";
  Future<void> _getmeuserwaaPlans() async {
    try {
      final res =
          await http.get(Uri.parse('${BASE_URL}store-users/me'), headers: {
        'Authorization': "Bearer ${userToken}",
      });

      if (res.statusCode == 200) {
        print("success userrrrrrrrrrrrrrrrrrrr");
        // userData = json.decode(res.body)["data"];

        Map auserData = json.decode(res.body)["data"];
        prrr = (auserData["isPremium"] == true);
        print(auserData["isPremium"]);
        naamm = auserData["name"];

        if (!mounted) {
          return;
        }
        setState(() {});
        print(userData);
      } else {
        print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getmeuserwaaPlans();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Premium Plans",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        // toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined),
                iconSize: 30,
                color: widget.adth,
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CollectionPage(adth: widget.adth)));
                  },
                  icon: Icon(
                    Icons.favorite_border_outlined,
                  ),
                  iconSize: 30,
                  color: widget.adth,
                )),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                (!prrr)
                    ? "Hey $naamm, You are not a Premium user."
                    : "Hey $naamm, You are already a Premium user.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 5,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text("Free Users",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: widget.adth)),
                      SizedBox(
                        height: 20,
                      ),
                      Text("No Cash on delivery orders",
                          style: TextStyle(fontSize: 17)),
                      Text("No Prepaid orders", style: TextStyle(fontSize: 17)),
                      Text("No Premium Pricing",
                          style: TextStyle(fontSize: 17)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.adth),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RazerPay(
                                    adth: widget.adth,
                                    money: 3000,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Super seller"),
                          Text("₹ 3000"),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: widget.adth),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RazerPay(
                                    adth: widget.adth,
                                    money: 3000,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Pro User"),
                          Text("₹ 3000"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
