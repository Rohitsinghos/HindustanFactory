import 'dart:convert';

import 'package:Template/extra/addaddr.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddrPage extends StatefulWidget {
  final Color adth;
  AddrPage({required this.adth});

  @override
  State<AddrPage> createState() => _AddrPageState();
}

String msg = "";

class _AddrPageState extends State<AddrPage> {
  bool didit = true;
  Future<void> _getdatatoAddr(int id, int qu) async {
    setState(() {
      addressdata = [];
    });

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

      final req = await http.get(
        Uri.parse("${BASE_URL}address"),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
      );

      if (req.statusCode == 200) {
        print(jsonDecode(req.body)["data"]);
        setState(() {
          addressdata = jsonDecode(req.body)["data"];
        });
        // usercartData = jsonDecode(req.body)["data"];

        print(addressdata);

        print("jsdjjhdjdjjdjdjjd cart millll gayaya  ho gyayyaya");

        // setState(() {});
      } else {
        print(
            "not cart nahi millallalal to cart... abbebebebbhhdshdhhdhnananannanan");
        setState(() {});
      }
    } catch (e) {
      print(e);
      print("error  haiiaiia biroroo jdjdjjdjdjjdjjd");
    }
  }

  _deletedatatoAddr(int id) async {
    try {
      final req = await http.delete(Uri.parse("${BASE_URL}address/$id"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer ${userToken}",
          },
          body: jsonEncode({
            "houseNumber": "420",
            "name": "Rohit JIIIII",
          }));

      if (req.statusCode == 200) {
        msg = jsonDecode(req.body)["message"];
        print(msg);
        print("kaibe jiiiiiii yayyaya");
      } else {
        msg = jsonDecode(req.body)["message"];
        print(msg);
      }
      _getdatatoAddr(id, 1);
    } catch (e) {
      msg = "error hai ji interneta lkakaa";
      print(e);
    }
  }

  int n = 5;
  int numbbb = 1;

  @override
  Widget build(BuildContext context) {
    if (didit) {
      _getdatatoAddr(1, 1);
      didit = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Location Preference",
            style: TextStyle(fontWeight: FontWeight.bold),
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
                    setState(() {
                      didit = true;
                    });
                  },
                  icon: Icon(
                    Icons.refresh,
                  ),
                  iconSize: 30,
                  color: widget.adth,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        _getme(),
      ])),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditAddrePage(
                      adth: widget.adth,
                      userind: -1,
                    )),
          );
          setState(() {
            didit = true;
          });
        },
        child: BottomAppBar(
          // onPressed: () {},
          color: widget.adth,
          height: 70,
          child: Center(
              child: Text(
            "Add New Address",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
          )),
        ),
      ),
    );
  }

  _getCards(
      {required int index,
      required int id,
      required int houseNumber,
      required String name,
      required String addressLine1,
      required String pincode,
      required String city,
      required String state,
      required String country,
      required String addressLine2,
      required String area,
      required String phone,
      required String countryCode}) {
    // int index = 0;
    int ProInd = 0;

    return GestureDetector(
      onTap: () {
        chaddr = index;
        Navigator.pop(context);
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: $name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Phone: $phone",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Wrap(
                children: [
                  Text(
                    "House Number : $houseNumber, " +
                        " address Line1 : $addressLine1, country code : $countryCode, pincode : $pincode, " +
                        "area : $area, " +
                        "addressLine : $addressLine2, " +
                        "city : $city, " +
                        "state : $state, " +
                        "country : $country, ",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 19,
                    child: IconButton(
                      onPressed: () {
                        // if (cartn > 0) {
                        //   cartn = cartn - 1;
                        //   cartIds.removeAt(index);
                        //   cartCnts.removeAt(index);
                        // }
                        // // cartIds.removeAt(index);
                        // // cartCnts.removeAt(index);
                        // // restart();
                        // didit = true;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditAddrePage(
                                      adth: widget.adth,
                                      userind: id,
                                    )));

                        setState(() {
                          didit = true;
                        });
                      },
                      icon: Icon(Icons.edit_outlined),
                      iconSize: 19,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CircleAvatar(
                      radius: 19,
                      child: IconButton(
                        onPressed: () {
                          // if (cartn > 0) {
                          //   cartn = cartn - 1;
                          //   cartIds.removeAt(index);
                          //   cartCnts.removeAt(index);
                          // }
                          // // cartIds.removeAt(index);
                          // // cartCnts.removeAt(index);
                          // // restart();
                          // n--;

                          _deletedatatoAddr(id);

                          setState(() {
                            didit = true;
                          });
                        },
                        icon: Icon(Icons.delete),
                        iconSize: 19,
                      ),
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 19,
                  //   child: IconButton(
                  //     onPressed: () {
                  //       // if (cartn > 0) {
                  //       //   cartn = cartn - 1;
                  //       //   cartIds.removeAt(index);
                  //       //   cartCnts.removeAt(index);
                  //       // }
                  //       // // cartIds.removeAt(index);
                  //       // // cartCnts.removeAt(index);
                  //       // // restart();
                  //       numbbb = index;

                  //       setState(() {});
                  //     },
                  //     icon: (numbbb == index)
                  //         ? Icon(Icons.verified)
                  //         : Icon(Icons.hdr_on_select),
                  //     iconSize: 19,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getme() {
    Wrap a = Wrap(
      children: [
        for (int i = 0; i < addressdata.length; i++)
          _getCards(
              id: addressdata[i]["id"] ?? 9,
              index: i,
              houseNumber: 420,
              name: addressdata[i]["name"] ?? "John Michael",
              addressLine1:
                  addressdata[i]["addressLine1"] ?? "Great Eatern Road",
              pincode: addressdata[i]["pincode"] ?? "12345",
              city: addressdata[i]["city"] ?? "Raipur",
              state: addressdata[i]["state"] ?? "Chhattisgarh",
              country: addressdata[i]["country"] ?? "India",
              addressLine2: addressdata[i]["addressLine2"] ?? "Civil",
              area: addressdata[i]["area"] ?? "Civil Line",
              phone: addressdata[i]["phone"] ?? "9999999999",
              countryCode: addressdata[i]["countryCode"] ?? "+91"),
      ],
    );
    return a;
  }
}
