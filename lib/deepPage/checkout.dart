import 'dart:convert';

import 'package:template/usls/razerpay.dart';
import 'package:template/usls/addaddr.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/deepPage/Orders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckOutPage extends StatefulWidget {
  final Color adth;

  const CheckOutPage({super.key, required this.adth});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int proc = 0;
  int checked = -1;

  bool cod = true;
  bool isprem = false;

  int totalAmount11 = 3000;

  bool cash = false;

  String name2 = "Raj Patej";
  String email2 = "rajtilak.socialsellers@gmail.com";
  String phone2 = "1234567890";

  final namc = TextEditingController();
  final emailc = TextEditingController();
  final phonec = TextEditingController();
  // final passc = TextEditingController();
  bool okk = false;
  Future<void> _getorderuser() async {
    try {
      List cartItems = [];

      final req = await http.get(
        Uri.parse("${BASE_URL}cart/me"),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
      );

      if (req.statusCode == 200) {
        print(jsonDecode(req.body)["data"]);
        usercartData = jsonDecode(req.body)["data"];

        // usercartData = jsonDecode(req.body)["data"];

        print(usercartData['Variants']);
        print(usercartData['totalPrice']);
        totalAmount11 = usercartData['totalPrice'];

        for (var x in usercartData['Variants']) {
          cartItems.add({
            "VariantId": x["CartVariant"]["VariantId"],
            "quantity": x["CartVariant"]["quantity"],
          });
          removeItCart(x["id"]);
        }
      }

      for (var x in cartItems) {
        final res = await http.post(
          Uri.parse("${BASE_URL}orders/checkout/razorpay"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer ${userToken}",
          },
          body: jsonEncode({
            // {"variants":[{"VariantId":27,"quantity":1}],"consumer":{"name":"Rahul",
            // "phone":"9770775021","email":"rahul@hmsms.in","isResellerOrder":false},
            // "StoreUserID":24,"AddressId":47,"payment_mode":"COD"}

            // ;
            "payment_mode": (cash) ? "COD" : "PREPAID",
            "variants": [
              {"VariantId": x["VariantId"], "quantity": x["quantity"]},
            ],
            "consumer": {
              "name": (namc.text != "") ? namc.text : name2,
              "email": (emailc.text != "") ? emailc.text : email2,
              "phone": (phonec.text != "") ? phonec.text : phone2,
              "isResellerOrder": (namc.text != ""),
            },
            // "UserID": 1,
            // "StoreUserID":2,
            "AddressId": addid,
            // "StoreUserID": 24,
            // "coupon_code": "SAVE20"
          }),
        );

        if (res.statusCode == 200) {
          print("success userrrrrrrrrrrrrrrrrrrr");

          if (cartItems[cartItems.length - 1] == x) {
            if (cash == false) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          RazerPay(adth: widget.adth, money: totalAmount11),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrdersPage(adth: widget.adth, page: 0),
                ),
              );
            }
          }
        } else {
          print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Try again!")));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeItCart(int id) async {
    try {
      final req = await http.delete(
        Uri.parse("${BASE_URL}cart/remove/$id"),
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer ${userToken}",
          // 'Params': id.toString(),
        },
      );

      if (req.statusCode == 200) {
        print(jsonDecode(req.body)["message"]);
      } else {
        print(jsonDecode(req.body)["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getmeuser() async {
    try {
      final res = await http.get(
        Uri.parse('${BASE_URL}store-users/me'),
        headers: {'Authorization': "Bearer ${userToken}"},
      );

      if (res.statusCode == 200) {
        print("success userrrrrrrrrrrrrrrrrrrr");
        // userData = json.decode(res.body)["data"];

        userData = json.decode(res.body)["data"];

        name2 = userData["name"];
        email2 = userData["email"];
        phone2 = userData["phone"];
        isprem = userData["isPremium"] == true;

        okk = true;

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

  Future<void> _getdatatoCart() async {
    usercartData = {};
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
        Uri.parse("${BASE_URL}cart/me"),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
      );

      if (req.statusCode == 200) {
        usercartData = jsonDecode(req.body)["data"];

        for (var x in usercartData["variants"]) {
          cartvariant.add({
            "VariantId": x["VariantId"],
            "quantity": x["quantity"],
          });
        }

        if (!mounted) return;

        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
      } else {
        print(
          "not cart nahi millallalal to cart... abbebebebbhhdshdhhdhnananannanan",
        );
        if (!mounted) return;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {
          usercartData = {};
        });
      }
    } catch (e) {
      print(e);
    }
  }

  List<Map<String, String>> cartvariant = [];

  void initState() {
    super.initState();
    _getmeuser();
    _getdatatoCart();

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
            "Checkout",
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
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.favorite_border_outlined, color: widget.adth),
                iconSize: 30,
                color: widget.adth,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Consumer Info",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: widget.adth,
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Leave this blank if you are ordering for yourself, If you are ordering for someone else please give their contact info so we can deliver important updates.",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: namc,
                  decoration: InputDecoration(
                    label: Text("Name"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: phonec,
                  decoration: InputDecoration(
                    label: Text("Phone Number"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailc,
                  decoration: InputDecoration(
                    label: Text("Email"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      cash = false;
                      if (!mounted)
                        return; // prevents calling setState if widget is disposed

                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: widget.adth),
                        borderRadius: BorderRadius.circular(10),
                        color: (!cash) ? widget.adth : Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Text(
                              "Online Payment",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: (cash) ? widget.adth : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (isprem) cash = true;
                      if (!mounted)
                        return; // prevents calling setState if widget is disposed

                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: widget.adth),
                        borderRadius: BorderRadius.circular(10),
                        color: (cash) ? widget.adth : Colors.white,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          children: [
                            Text(
                              "Cash on delivery",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: (!cash) ? widget.adth : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Address
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Address",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: widget.adth,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: widget.adth,
                    radius: 15,
                    child: IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EditAddrePage(
                                  adth: widget.adth,
                                  userind: -1,
                                ),
                          ),
                        );
                      },
                      icon: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),

              _getme(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        height: 80,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: widget.adth),
          // color: widget.adth,
          onPressed: () {
            if (addid != -1) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Processing...")));

              _getorderuser();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please select an address or add address!"),
                ),
              );
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Continue to Payment",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  _getCards({
    required int index,
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
    required String countryCode,
  }) {
    // int index =0 0;

    if (index == chaddr) {
      addid = id;
    }
    return GestureDetector(
      onTap: () {
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {
          checked = index;
          addid = id;
        });
      },
      child: Card(
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    (checked != index)
                        ? Container()
                        : Icon(Icons.check, color: Colors.green, size: 25),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _getme() {
    if (chaddr >= addressdata.length) {
      chaddr = 0;
    }
    return Column(
      children: [
        for (int i = 0; i < addressdata.length; i++)
          _getCards(
            id: addressdata[i]["id"] ?? 9,
            index: i,
            houseNumber: 420,
            name: addressdata[i]["name"] ?? "John Michael",
            addressLine1: addressdata[i]["addressLine1"] ?? "Great Eatern Road",
            pincode: addressdata[i]["pincode"] ?? "12345",
            city: addressdata[i]["city"] ?? "Raipur",
            state: addressdata[i]["state"] ?? "Chhattisgarh",
            country: addressdata[i]["country"] ?? "India",
            addressLine2: addressdata[i]["addressLine2"] ?? "Civil",
            area: addressdata[i]["area"] ?? "Civil Line",
            phone: addressdata[i]["phone"] ?? "9999999999",
            countryCode: addressdata[i]["countryCode"] ?? "+91",
          ),
      ],
    );
  }
}
