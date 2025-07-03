import 'dart:convert';

import 'package:Template/CategoryPages/category1.dart';
import 'package:Template/Purchase/buyItem.dart';
import 'package:Template/api/get.dart';
import 'package:Template/deepPage/checkout.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/models/model1.dart';
import 'package:Template/pages/home.dart';
import 'package:Template/pages/profile.dart';
import 'package:Template/pages/video.dart';
import 'package:Template/profilePages/addr.dart';
import 'package:Template/profilePages/collection.dart';
import 'package:Template/profilePages/paymethod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartDirPage extends StatefulWidget {
  final Color adth;
  final int admin;
  const CartDirPage({super.key, required this.adth, required this.admin});

  @override
  State<CartDirPage> createState() => _CartDirPageState();
}

Color b11 = const Color.fromARGB(255, 169, 169, 169);
Color b2 = const Color.fromARGB(255, 169, 169, 169);
Color b3 = const Color.fromARGB(255, 169, 169, 169);
Color b4 = const Color.fromARGB(255, 169, 169, 169);
Color b5 = const Color.fromARGB(255, 169, 169, 169);

List<Color> b = [b1, b2, b3, b4, b5];
int prepaid = 1;
int page = 3;

double subtot = 0;
double totalitem = 0;

double subb = 0;
double totgst = 0;
double totcup = 0;
double totalAmount = 0;
double totdis = 0;
double shipingCharge = 0;

int doit = 1;

class _CartDirPageState extends State<CartDirPage> {
  bool showw = false;
  int cartnn = 0;
  bool addcheck = false, paycheck = false;

  void _ADDRES() {
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {
      addcheck = !addcheck;
    });
  }

  void _PaymentcHH() {
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {
      paycheck = !paycheck;
    });
  }

  int getcart = 1;
  bool didit = true;
  Future<void> _getdatatoAddr(int id, int qu) async {
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
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {
          addressdata = jsonDecode(req.body)["data"];
        });
        // usercartData = jsonDecode(req.body)["data"];

        print("jsdjjhdjdjjdjdjjd cart millll gayaya  ho gyayyaya");
        if (!mounted) return;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
      } else {
        print(
            "not cart nahi millallalal to cart... abbebebebbhhdshdhhdhnananannanan");
        if (!mounted) return;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
      }
    } catch (e) {
      print(e);
      print("error  haiiaiia biroroo jdjdjjdjdjjdjjd");
    }
  }

  Future<void> _addtoCart(int id, int qu) async {
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

      final req = await http.post(Uri.parse("${BASE_URL}cart/add"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer ${userToken}",
          },
          body: jsonEncode({"VariantId": id, "quantity": qu}));

      if (req.statusCode == 200) {
        print(jsonDecode(req.body)["message"]);
        print("jsdjjhdjdjjdjdjjd  ho gyayyaya");

        _getdatatoCart(id, 1);
      } else {
        print("not added to cart... abbebebebbhhdshdhhdhnananannanan");
      }
    } catch (e) {
      print(e);
      print("jdjdjjdjdjjdjjd");
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
        print("jsdjjhdjdjjdjdjjd  ho gyayyaya");

        _getdatatoCart(id, 1);
      } else {
        print(jsonDecode(req.body)["message"]);
        print("not removvvvvvingggggggg to cart... ");
      }
    } catch (e) {
      print(e);
      print("eroroororoo re,,,,,,,moooove     ");
    }
  }

  Future<void> removeOneCart(int id, int qua) async {
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
        print("jsdjjhdjdjjdjdjjd  ho gyayyaya");

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

          final req = await http.post(Uri.parse("${BASE_URL}cart/add"),
              headers: {
                'Content-type': 'application/json',
                'Authorization': "Bearer ${userToken}",
              },
              body: jsonEncode({"VariantId": id, "quantity": qua}));

          if (req.statusCode == 200) {
            print(jsonDecode(req.body)["message"]);
            print("jsdjjhdjdjjdjdjjd  ho gyayyaya");
          } else {
            print("not added to cart... abbebebebbhhdshdhhdhnananannanan");
          }
        } catch (e) {
          print(e);
          print("jdjdjjdjdjjdjjd");
        }

        _getdatatoCart(id, 1);
      } else {
        print(jsonDecode(req.body)["message"]);
        print("not removvvvvvingggggggg to cart... ");
      }
    } catch (e) {
      print(e);
      print("eroroororoo re,,,,,,,moooove     ");
    }
  }

  Future<void> _getdatatoCart(int id, int qu) async {
    usercartData = {};
    getcart = 0;
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
        print(jsonDecode(req.body)["data"]);
        usercartData = jsonDecode(req.body)["data"];

        totalAmount =
            (usercartData == null) ? 0.00 : usercartData['totalPrice'] * 1.00;
        subb =
            (usercartData == null) ? 0.00 : usercartData['totalPrice'] * 1.00;
        print("jsdjjhdjdjjdjdjjd cart millll gayaya  ho gyayyaya");

        if (!mounted) return;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
      } else {
        print(
            "not cart nahi millallalal to cart... abbebebebbhhdshdhhdhnananannanan");

        if (!mounted) return;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {
          usercartData = {};
        });
      }
    } catch (e) {
      print(e);
      print("error  haiiaiia biroroo jdjdjjdjdjjdjjd");
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network call
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {
      _getdatatoCart(1, 1);
    });
  }

  int getaddrrr = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getdatatoCart(1, 1);
    getdatatoAddr(1, 1);
  }

  @override
  Widget build(BuildContext context) {
    // if (getaddrrr == 1) {
    //   getaddrrr = 0;
    //   getdatatoAddr(1, 1);
    // }
    // if (getcart == 1) {
    //   _getdatatoCart(1, 1);
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Cart",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        // toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
              // radius: 5,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: widget.adth,
                ),
              )),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CollectionPage(
                                  adth: widget.adth,
                                )));
                  },
                  icon: Icon(Icons.favorite_border_outlined),
                  color: widget.adth,
                )),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        _getme(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, top: 30),
                          child: Row(
                            children: [
                              Text(
                                "Order Info",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  "₹$subb",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Charge",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  "₹$totcup",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                                Text(
                                  "₹ $totalAmount",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddrPage(
                                      adth: widget.adth,
                                    )));
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Icon(Icons.arrow_forward_ios, size: 14)
                              ],
                            ),
                            Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset("assets/loca.jpg",
                                              height: 42),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Container(
                                            width: 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${(addressdata != null && addressdata.length > chaddr) ? addressdata[chaddr]["name"] : ""}, ${(addressdata != null && addressdata.length > 0) ? addressdata[0]["phone"] : "no."}," +
                                                      ", ${(addressdata != null && addressdata.length > chaddr) ? addressdata[chaddr]["addressLine1"] : ""}," +
                                                      ", ${(addressdata != null && addressdata.length > chaddr) ? addressdata[chaddr]["addressLine2"] : ""}," +
                                                      ", ${(addressdata != null && addressdata.length > chaddr) ? addressdata[chaddr]["city"] : ""}, " +
                                                      "${(addressdata != null && addressdata.length > chaddr) ? addressdata[chaddr]["pincode"] : ""}, " +
                                                      "${(addressdata != null && addressdata.length > chaddr) ? addressdata[chaddr]["state"] : ""}, " +
                                                      "${(addressdata != null && addressdata.length > chaddr) ? addressdata[chaddr]["country"] : ""}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _ADDRES();
                                      },
                                      child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: (!addcheck)
                                              ? const Color.fromARGB(
                                                  255, 251, 246, 246)
                                              : Colors.green,
                                          child: Icon(Icons.check,
                                              color: (!addcheck)
                                                  ? const Color.fromARGB(
                                                      255, 248, 244, 244)
                                                  : Colors.white)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PayMethodPage(
                                    adth: widget.adth,
                                  )));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Payment Method",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                              ),
                            ],
                          ),
                          Card(
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/visa.jpg",
                                          height: 42),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "No Card Added",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                            Text(
                                              "**** **** **** 1234",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // _PaymentcHH();
                                    },
                                    child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: (!paycheck)
                                            ? const Color.fromARGB(
                                                255, 223, 223, 223)
                                            : Colors.green,
                                        child: Icon(Icons.check,
                                            color: (!paycheck)
                                                ? const Color.fromARGB(
                                                    255, 228, 227, 227)
                                                : Colors.white)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            MaterialButton(
              color: widget.adth,
              height: 70,
              onPressed: () {
                // for (int i = 0; i < cartIds.length; i++) {
                //   orderData.add({"id": cartIds[i], "quantity": cartCnts[i]});
                // }

                // cartn = 0;
                // cartIds.clear();
                // cartCnts.clear();
                if (usercartData.isNotEmpty && usercartData['totalPrice'] > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckOutPage(
                              adth: widget.adth,
                            )),
                  );
                } else {
                  if (showw == false) {
                    if (!mounted)
                      return; // prevents calling setState if widget is disposed

                    setState(() {
                      showw = true;
                    });
                  }
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Center(
                      child: Text(
                        "Checkout",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (!showw)
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "please add product to cart first",
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                  ),
          ],
        )),
      ),

      bottomNavigationBar: bottomnn(),

      // bottomNavigationBar:
    );
  }

  _getCards(
      {required int index,
      required int id,
      required String name,
      required int rating,
      required int left,
      required String price,
      required int qua,
      required String image,
      required bool ok}) {
    // int index = 0;
    int ProInd = 0;
    if (productData1 != null) {
      for (int i = 0; i < productData1.length; i++) {
        if (productData1[i]["id"] == id) {
          ProInd = i;
          break;
        }
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BuyItem(
            adth: widget.adth,
            buyid: id,
          );
        }));
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: (productData1 != null)
                        ? productData1[ProInd]['thumbnail']['url']
                        : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        Icon(Icons.broken_image),

                    // width: double.infinity,
                    height: 120,
                    width: 95,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${productData1[ProInd]['name']} $name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Text(
                            (productData1 != null) ? "Rs ${price}" : "Rs 100",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          Text(
                            "(+4.00 Tax)",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 16,
                                  child: IconButton(
                                    onPressed: () {
                                      removeOneCart(id, qua - 1);
                                      print("kskskks");
                                      if (!mounted)
                                        return; // prevents calling setState if widget is disposed

                                      setState(() {});
                                    },
                                    icon: Icon(Icons.arrow_downward_outlined),
                                    iconSize: 15,
                                    // size: 20,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Text("$qua"),
                              ),
                              CircleAvatar(
                                radius: 16,
                                child: IconButton(
                                  onPressed: () {
                                    // if (cartCnts.length > index)
                                    //   cartCnts[index]++;
                                    // if (!mounted) return; // prevents calling setState if widget is disposed

                                    setState(() {});

                                    _addtoCart(id, 1);

                                    if (!mounted)
                                      return; // prevents calling setState if widget is disposed

                                    setState(() {
                                      // qua++;
                                    });
                                  },
                                  icon: Icon(Icons.arrow_upward_outlined),
                                  iconSize: 15,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 16,
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

                                removeItCart(id);

                                if (!mounted)
                                  return; // prevents calling setState if widget is disposed

                                setState(() {});
                              },
                              icon: Icon(Icons.delete),
                              iconSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getme() {
    Wrap a = (usercartData == null ||
            usercartData["id"] == null ||
            usercartData["Variants"] == null)
        ? Wrap(children: [CircularProgressIndicator()])
        : Wrap(
            children: [
              for (int i = 0; i < usercartData['Variants'].length; i++)
                _getCards(
                  id: usercartData["Variants"][i]['id'],
                  index: 0,
                  image: "",
                  price: usercartData['Variants'][i]['price'],
                  qua: usercartData['Variants'][i]['CartVariant']['quantity'],
                  name: usercartData['Variants'][i]['name'],
                  rating: 2,
                  left: 2,
                  ok: true,
                ),
            ],
          );
    return a;
  }

  Widget bottomnn() {
    return BottomAppBar(
      color: bottomback,
      height: 68,
      // currentIndex: 0,
      // selectedItemColor: widget.adth,
      // unselectedItemColor: Colors.grey,
      // showSelectedLabels: true,
      // showUnselectedLabels: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHome(adth: widget.adth, admin: 0)),
                      (context) => false);
                },
                child: Column(children: [
                  Icon(
                    Icons.home_outlined,
                    size: 21,
                    color: b1,
                  ),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Home'),
                ]),
              )),
          Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Cart1Page(
                                adth: widget.adth,
                                admin: widget.admin,
                              )));
                },
                child: Column(children: [
                  Icon(
                    Icons.dashboard_outlined,
                    color: b1,
                    size: 21,
                  ),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Category'),
                ]),
              )),
          Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPage(
                                admin: 2,
                                adth: widget.adth,
                              )));
                },
                child: Column(children: [
                  Icon(Icons.ondemand_video, color: b1, size: 21),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Shorts'),
                ]),
              )),
          Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartDirPage(
                                admin: 3,
                                adth: widget.adth,
                              )));
                },
                child: Column(children: [
                  Icon(Icons.shopping_cart_outlined,
                      color: widget.adth, size: 21),
                  Text(
                      style: TextStyle(color: widget.adth, fontSize: 13),
                      'Cart'),
                ]),
              )),
          Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(
                                adth: widget.adth,
                                admin: widget.admin,
                              )));
                },
                child: Column(children: [
                  Icon(Icons.person_outline, color: b1, size: 21),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Profile'),
                ]),
              )),
        ],
      ),

      //
      // ],
    );
  }
}

// int prepaid = 1;

// class _CartDirPageState extends State<CartDirPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           // padding: const EdgeInsets.only(left: 0.0),
//           child: Text(
//             "Cart",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//         backgroundColor: widget.adth,
//         toolbarHeight: 60,
//         leading: Container(),
//         actions: [Text('              ')],
//       ),
//       body: SingleChildScrollView(
//           child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Your Selected Items",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//             ),
//           ),
//           Container(
//               height: 300,
//               child: ListView.builder(
//                   itemCount: cartn,
//                   itemBuilder: (context, index) {
//                     // int idc = cartIds[0]['id'] ?? 0;
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 4.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     "${Items[cartIds[index]]['image']}",
//                                     height: 60,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                         "${Items[cartIds[index]]['title']}"),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                         "₹ ${ItemsInt[cartIds[index]]['price'] ?? 1 * cartCnts[index]} llpl, ${cartCnts[index]}"),
//                                   ),
//                                   Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: MaterialButton(
//                                         minWidth: 10,
//                                         onPressed: () {
//                                           if (cartn > 0) {
//                                             cartn = cartn - 1;
//                                             cartIds.remove(index);
//                                             cartCnts.removeAt(index);
//                                           }
//                                           if (!mounted) return; // prevents calling setState if widget is disposed

      // setState(() {});
//                                         },
//                                         child: Icon(Icons.delete),
//                                       ))
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Divider(),
//                       ],
//                     );
//                   })),
//           Container(
//             margin: EdgeInsets.all(15),
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Payment Method",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     MaterialButton(
//                       minWidth: 160,
//                       color: (prepaid == 1) ? widget.adth : Colors.grey,
//                       onPressed: () {
//                         prepaid = 1;
//                         if (!mounted) return; // prevents calling setState if widget is disposed

      // setState(() {});
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.atm),
//                           Text(
//                             "Prepaid",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: 160,
//                       color: (prepaid == 0) ? widget.adth : Colors.grey,
//                       onPressed: () {
//                         prepaid = 0;
//                         if (!mounted) return; // prevents calling setState if widget is disposed

      // setState(() {});
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.fire_truck),
//                           Text("Cod", style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Sub Total :"),
//                         Text("₹ 899"),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Applied Cupons :"),
//                         Text("-₹ 45"),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Total Discount :"),
//                         Text("-₹ 100"),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Gst Amount :"),
//                         Text("₹ 80"),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Shipping charges :"),
//                         Text("₹ 10"),
//                       ],
//                     ),
//                     Divider(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Total Amount",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 17),
//                         ),
//                         Text(
//                           "₹ 8099",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 17),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       )),
//       bottomNavigationBar: MaterialButton(
//         color: (cartn == 0) ? Colors.black : widget.adth,
//         height: 60,
//         onPressed: () {},
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Text(
//             "Proceed to buy",
//             style: TextStyle(fontSize: 15, color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
