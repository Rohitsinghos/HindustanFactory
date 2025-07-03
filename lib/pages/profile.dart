import 'dart:convert';

import 'package:Template/CategoryPages/category1.dart';
import 'package:Template/Purchase/cartdirect.dart';
import 'package:Template/deepPage/Orderpage.dart';
import 'package:Template/deepPage/orderDetails.dart';
import 'package:Template/deepPage/premium.dart';
import 'package:Template/deepPage/razerpay.dart';
import 'package:Template/deepPage/wallet.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/models/model1.dart';
import 'package:Template/pages/home.dart';
import 'package:Template/pages/video.dart';
import 'package:Template/profilePages/Orders.dart';
import 'package:Template/profilePages/addr.dart';
import 'package:Template/profilePages/collection.dart';
import 'package:Template/profilePages/course.dart';
import 'package:Template/profilePages/help.dart';
import 'package:Template/profilePages/services.dart';
import 'package:Template/profilePages/setting.dart';
import 'package:Template/profilePages/support.dart';
import 'package:flutter/material.dart';
import 'package:Template/main.dart';
import 'package:Template/profilePages/account.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final Color adth;
  final int admin;

  ProfilePage({required this.adth, required this.admin});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

Color b11 = const Color.fromARGB(255, 169, 169, 169);
Color b2 = const Color.fromARGB(255, 169, 169, 169);
Color b3 = const Color.fromARGB(255, 169, 169, 169);
Color b4 = const Color.fromARGB(255, 169, 169, 169);
Color b5 = const Color.fromARGB(255, 169, 169, 169);

List<Color> b = [b1, b2, b3, b4, b5];

class _ProfilePageState extends State<ProfilePage> {
  void logoutUser() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll();
    print("✅ Secure storage cleared. User logged out.");
  }

  int wallet = 0;
  final txcont = TextEditingController();
  bool isPressed = false;
  bool isPressed1 = false;

  bool ispremi = false;
  int userid = -1;

  _logOut() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Log Out"),
              content: Text("Are you sure to log out!"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        userToken = "";
                        // final store = GetStorage();
                        // store.write("loggedIn", false);
                        logoutUser();

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp(
                                      isLoggedIn: false,
                                    )),
                            (context) => false);
                      },
                      child: Text("Yes"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                  ],
                )
              ],
            ));
  }

  _photoLong() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Profile Picture"),
              actions: [
                Container(
                  child: CircleAvatar(
                    radius: 130,
                    backgroundImage: NetworkImage((userData != null &&
                            userData["avatar"] != null &&
                            userData["avatar"]["url"] != null)
                        ? userData["avatar"]["url"]
                        : 'https://img.freepik.com/free-vector/smiling-young-account_box_outlined-illustration_1308-174669.jpg'),
                  ),
                ),
              ],
            ));
  }

  bool gotuser = false;

  Future<void> _getmeuser() async {
    try {
      if (userData.length == 0) {
        final res =
            await http.get(Uri.parse('${BASE_URL}store-users/me'), headers: {
          'Authorization': "Bearer ${userToken}",
        });

        if (res.statusCode == 200) {
          print("success userrrrrrrrrrrrrrrrrrrr");
          // userData = json.decode(res.body)["data"];

          userData = json.decode(res.body)["data"];
          ispremi = (userData["isPremium"] == true);
          print(userData["isPremium"]);
          adrss = userData["addresses"].length;
          wallet = userData["wallet_balance"];
          userid = userData["id"];

          if (!mounted) {
            return;
          }
          if (!mounted)
            return; // prevents calling setState if widget is disposed

          setState(() {});
          print(userData);
        } else {
          print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
        }
      } else {
        print("kkskksksk");
      }
    } catch (e) {
      print(e);
    }
  }

  _photoClick() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Profile Picture"),
              // content: Text("Are you sure to log out!"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);

                        if (userid != -1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AccPage(
                                      adth: widget.adth, userid: userid)));
                        }
                      },
                      child: Text("Change"),
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Delete"),
                    ),
                  ],
                )
              ],
            ));
  }

  List<String> tmop = ["All", "Today", "Yesterday", "Weekly", "Monthly"];
  int tmopn = 4;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getmeuser();
    if (!mounted) {
      return;
    }
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  _takeOp(int index) {
    tmopn = index;
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  int orderss = 0;
  int colls = favIds.length;
  int adrss = (userData != null && userData["addresses"] != null)
      ? userData["addresses"].length
      : 0;

  Future<void> _refreshData() async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network call
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {
      _getmeuser();
    });
  }

  @override
  Widget build(BuildContext context) {
    tmop = ["All", "Today", "Yesterday", "Weekly", "Monthly"];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                          builder: (context) => CartDirPage(
                                adth: widget.adth,
                                admin: 0,
                              )),
                    );
                  },
                  icon: Icon(Icons.shopping_cart_outlined),
                  // iconSize: 30,
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
              // AppBar(
              //   leading: Container(),
              //   title: Column(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(top: 20.0),
              //         child: Row(
              //           children: [
              //             MaterialButton(
              //               onPressed: () {
              //                 _photoClick();
              //               },
              //               onLongPress: () {
              //                 _photoLong();
              //               },
              //               child: CircleAvatar(
              //                 radius: 55,
              //                 backgroundImage: NetworkImage(
              //                     'https://img.freepik.com/free-vector/smiling-young-account_box_outlined-illustration_1308-174669.jpg'),
              //               ),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(20.0),
              //               child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text(
              //                       "Guest",
              //                       style: TextStyle(
              //                         color: Colors.white,
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.bold,
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.only(top: 30.0),
              //                       child: Text(
              //                         "377373773",
              //                         style: TextStyle(
              //                             color: Colors.white, fontSize: 13),
              //                       ),
              //                     ),
              //                   ]),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(16.0),
              //         child: Row(children: [
              //           Padding(
              //             padding: const EdgeInsets.only(right: 12.0),
              //             child: Container(
              //               height: 67,
              //               width: 90,
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(10),
              //                 child: Container(
              //                   height: 67,
              //                   width: 90,
              //                   color: const Color.fromARGB(44, 122, 120, 122),
              //                   child: MaterialButton(
              //                     height: 80,
              //                     minWidth: 90,
              //                     onPressed: () {
              //                       Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                               builder: (context) =>
              //                                   TransPage(adth: widget.adth)));
              //                     },
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(0.0),
              //                       child: Column(
              //                         mainAxisAlignment: MainAxisAlignment.center,
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             '₹ 0.0',
              //                             style: TextStyle(
              //                                 fontSize: 18,
              //                                 color: Colors.green,
              //                                 fontWeight: FontWeight.bold),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(1.0),
              //                             child: Text(
              //                               'Wallet',
              //                               style: TextStyle(
              //                                   fontSize: 13, color: Colors.white),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(0.0),
              //             child: Container(
              //               height: 67,
              //               width: 90,
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.circular(10),
              //                 child: Container(
              //                   color: const Color.fromARGB(44, 122, 120, 122),
              //                   child: MaterialButton(
              //                     onPressed: () {
              //                       Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                               builder: (context) =>
              //                                   OrdersPage(adth: widget.adth)));
              //                     },
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(0.0),
              //                       child: Column(
              //                         mainAxisAlignment: MainAxisAlignment.center,
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             '20',
              //                             style: TextStyle(
              //                               fontSize: 18,
              //                               color: Colors.green,
              //                               fontWeight: FontWeight.bold,
              //                             ),
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.only(top: 1.0),
              //                             child: Text(
              //                               'Orders',
              //                               style: TextStyle(
              //                                   fontSize: 13, color: Colors.white),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ]),
              //       ),
              //     ],
              //   ),
              //   backgroundColor: widget.adth,
              //   toolbarHeight: 260,
              // ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (userid != -1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccPage(
                                            adth: widget.adth,
                                            userid: userid,
                                          )));
                            }
                          },
                          child: GestureDetector(
                            onTap: () {
                              if (userid != -1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AccPage(
                                              adth: widget.adth,
                                              userid: userid,
                                            )));
                              }
                            },
                            onTapDown: (_) => setState(() => isPressed = true),
                            onTapUp: (_) => setState(() => isPressed = false),
                            onTapCancel: () =>
                                setState(() => isPressed = false),
                            child: AnimatedScale(
                              scale: isPressed ? 0.95 : 1.0,
                              duration: Duration(milliseconds: 950),
                              curve: Curves.easeInOut,
                              child: Container(
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 253, 247, 246),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0, vertical: 15),
                                        child: GestureDetector(
                                          onLongPress: _photoLong,
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage(
                                                (userData != null &&
                                                        userData["avatar"] !=
                                                            null &&
                                                        userData["avatar"]
                                                                ["url"] !=
                                                            null)
                                                    ? userData["avatar"]["url"]
                                                    : 'https://img.freepik.com/free-vector/smiling-young-account_box_outlined-illustration_1308-174669.jpg'),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (userData != null &&
                                                      userData != null &&
                                                      userData["name"] != null)
                                                  ? userData["name"]
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              (userData != null &&
                                                      userData != null &&
                                                      userData["email"] != null)
                                                  ? userData["email"]
                                                  : "null",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                            // Text(userToken),
                                            Text(
                                              (userData != null &&
                                                      userData != null &&
                                                      userData["phone"] != null)
                                                  ? "${userData["country_code"]} ${userData["phone"]}"
                                                  : "",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Display preference",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(160, 40),
                                  ),
                                  shape: WidgetStateOutlinedBorder.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          (ispremi == false)
                                              ? widget.adth
                                              : Colors.white70),
                                ),
                                // height: 40,
                                // minWidth: 160,
                                // color: (ispremi == false)
                                //     ? widget.adth
                                //     : Colors.white70,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PremiumPage(
                                                adth: widget.adth,
                                              )));
                                },
                                child: Text(
                                  "Basic Plan",
                                  style: TextStyle(
                                      color: (ispremi != false)
                                          ? widget.adth
                                          : Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(160, 40),
                                  ),
                                  shape: WidgetStateOutlinedBorder.resolveWith(
                                      (states) => RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          (ispremi == true)
                                              ? widget.adth
                                              : Colors.white70),
                                ),
                                // height: 40,
                                // minWidth: 160,
                                // color: (ispremi == false)
                                //     ? widget.adth
                                //     : Colors.white70,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PremiumPage(
                                                adth: widget.adth,
                                              )));
                                },
                                child: Text(
                                  "Premium Plan",
                                  style: TextStyle(
                                      color: (ispremi == true)
                                          ? Colors.white
                                          : widget.adth),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTapDown: (_) => setState(() => isPressed1 = true),
                            onTapUp: (_) => setState(() => isPressed1 = false),
                            onTapCancel: () =>
                                setState(() => isPressed1 = false),
                            child: AnimatedScale(
                              scale: isPressed1 ? 0.95 : 1.0,
                              duration: Duration(milliseconds: 950),
                              curve: Curves.easeInOut,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                // elevation: 2,
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 253, 247, 246),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Card(
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                for (int i = 0;
                                                    i < tmop.length;
                                                    i++)
                                                  GestureDetector(
                                                    onTap: () {
                                                      _takeOp(i);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child: Container(
                                                        color: (tmopn == i)
                                                            ? widget.adth
                                                            : Colors.white,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 5,
                                                                horizontal: 2),
                                                        child: Center(
                                                          child: Text(
                                                            tmop[i],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: (tmopn ==
                                                                        i)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "$wallet",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              "Total Sales",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey),
                                            ),
                                            Text("+0.0% ^",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: const Color.fromARGB(
                                                        255, 235, 237, 236))),
                                            Container(
                                              margin: EdgeInsets.all(20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Total oders : $orderss",
                                                  ),
                                                  Text(
                                                      "Unpaid orders : $orderss"),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all<Size>(
                                                        const Size(130, 40),
                                                      ),
                                                      shape: WidgetStateOutlinedBorder
                                                          .resolveWith((states) =>
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .white70),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      WalletPage(
                                                                        adth: widget
                                                                            .adth,
                                                                      )));
                                                    },
                                                    child: Text(
                                                      "Add Fund",
                                                      style: TextStyle(
                                                          color: widget.adth),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all<Size>(
                                                        const Size(150, 40),
                                                      ),
                                                      shape: WidgetStateOutlinedBorder
                                                          .resolveWith((states) =>
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  widget.adth),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      WalletPage(
                                                                        adth: widget
                                                                            .adth,
                                                                      )));
                                                    },
                                                    child: Text(
                                                      "Withdraw Fund",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 10),
                        Card(
                          color: Colors.white,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OrdersPage(
                                          adth: widget.adth,
                                          page: 0,
                                        ),
                                      ),
                                    );
                                  },
                                  child: getRow2(
                                      "Orders",
                                      Icon(
                                          Icons.collections_bookmark_outlined)),
                                ),
                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CollectionPage(
                                          adth: widget.adth,
                                        ),
                                      ),
                                    );
                                  },
                                  child: getRow(
                                      "Collection",
                                      "Already placed $colls orders",
                                      Icon(Icons.favorite_border_outlined)),
                                ),

                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ServicesPage(
                                          adth: widget.adth,
                                        ),
                                      ),
                                    );
                                  },
                                  child: getRow2(
                                      "Service", Icon(Icons.document_scanner)),
                                ),

                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CoursePAge(
                                          adth: widget.adth,
                                        ),
                                      ),
                                    );
                                  },
                                  child: getRow2(
                                      "Courses", Icon(Icons.read_more_sharp)),
                                ),

                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SettingsPage(
                                                  adth: widget.adth,
                                                )),
                                      );
                                    },
                                    child: getRow2(
                                        "Settings", Icon(Icons.settings))),

                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddrPage(
                                            adth: widget.adth,
                                          ),
                                        ));
                                  },
                                  child: getRow(
                                      "Location Preference",
                                      "saved total $adrss addresses",
                                      Icon(Icons.location_city_outlined)),
                                ),
                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => WalletPage(
                                                    adth: widget.adth,
                                                  )));
                                    },
                                    child:
                                        getRow2("Wallet", Icon(Icons.wallet))),
                                // getRow(),

                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                    onTap: () {
                                      _logOut();
                                    },
                                    child:
                                        getRow2("Logout", Icon(Icons.logout))),
                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RazerPay(
                                                    adth: widget.adth,
                                                    money: 3000,
                                                  )));
                                    },
                                    child: getRow2("Help Center",
                                        Icon(Icons.help_center))),
                                Divider(
                                  height: 1,
                                ),

                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SupportPage(
                                                    adth: widget.adth,
                                                  )));
                                    },
                                    child:
                                        getRow2("Support", Icon(Icons.email)))
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                    Text(
                      'Category',
                      style: TextStyle(color: b1, fontSize: 13),
                    ),
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
                    Icon(Icons.shopping_cart_outlined, color: b1, size: 21),
                    Text(style: TextStyle(color: b1, fontSize: 13), 'Cart'),
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
                    Icon(Icons.person_outline, color: widget.adth, size: 21),
                    Text(
                        style: TextStyle(color: widget.adth, fontSize: 13),
                        'Profile'),
                  ]),
                )),
          ],
        ),

        //
        // ],
      ),
    );
  }

  Widget getRow(String title, String subtitle, Icon iconio) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                iconio.icon,
                size: 23,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3.0),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.navigate_next_outlined),
            ),
            Divider(height: 1),
          ],
        ),
      ),
    );
  }

  Widget getRow2(String title, Icon iconio) {
    return Container(
      color: Colors.white,
      height: 65,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              iconio.icon,
              size: 23,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$title",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.navigate_next_outlined),
          ),
        ],
      ),
    );
  }

  Widget itemsPro(String title, Icon iconio) {
    return Container(
      height: 47,
      width: BoxConstraints().maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 13),
                child: Icon(
                  iconio.icon,
                  size: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_right_alt),
          )
        ],
      ),
    );
  }
}
