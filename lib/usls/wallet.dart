import 'dart:convert';

import 'package:template/deepPage/PayScrnst.dart';
import 'package:template/profilePages/compo.dart';
import 'package:template/usls/razerpay.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/usls/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WalletPage extends StatefulWidget {
  final Color adth;

  WalletPage({required this.adth});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int balancwe = 0;
  Future<void> _getmeuserwaa() async {
    try {
      final res = await http.get(
        Uri.parse('${BASE_URL}store-users/me'),
        headers: {'Authorization': "Bearer ${userToken}"},
      );

      if (res.statusCode == 200) {
        print("success userrrrrrrrrrrrrrrrrrrr");
        // userData = json.decode(res.body)["data"];

        Map<String, dynamic> auserData = json.decode(res.body)["data"];
        balancwe = auserData["wallet_balance"];

        if (!mounted) {
          return;
        }
        if (!mounted) return; // prevents calling setState if widget is disposed

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
    _getmeuserwaa();

    if (!mounted) {
      return;
    }
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,

        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Your Wallet",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            // radius: 25,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              // iconSize: 30,
              color: widget.adth,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              // radius: 25,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectionPage(adth: widget.adth),
                    ),
                  );
                },
                icon: Icon(Icons.favorite_border_outlined),
                // iconSize: 30,
                color: widget.adth,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text(
              "Total Wallet Balance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Text(
              "₹ ${balancwe}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: widget.adth,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => QrPage(),
                      );

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder:
                      //         (context) =>
                      //             RazerPay(adth: widget.adth, money: 3000),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.adth,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Add Money",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => WithdrowPage(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Widraw Money",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: widget.adth,
                      ),
                    ),
                  ),
                ),

                // ElevatedButton(
                //   style: ButtonStyle(
                //     fixedSize: MaterialStateProperty.all<Size>(
                //       const Size(130, 40),
                //     ),
                //     shape: WidgetStateOutlinedBorder.resolveWith(
                //       (states) => RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //     ),
                //     backgroundColor: MaterialStateProperty.all<Color>(),
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => WalletPage(adth: widget.adth),
                //       ),
                //     );
                //   },
                //   child: Text("Add Fund", style: TextStyle(color: widget.adth)),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
