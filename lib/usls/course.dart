import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:template/pages/category1.dart';
import 'package:template/pages/searchPage.dart';
import 'package:template/pages/buyItem.dart';
import 'package:template/pages/cartdirect.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/pages/home.dart';
import 'package:template/pages/profile.dart';
import 'package:template/usls/video.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursePAge extends StatefulWidget {
  final Color adth;

  CoursePAge({required this.adth});

  @override
  State<CoursePAge> createState() => _CoursePAgeState();
}

bool ok = true;

// class MyItem {
//   final String name;
//   final double value;
//   MyItem(this.name, this.value);
// }

class _CoursePAgeState extends State<CoursePAge> {
  bool sortByName = true;
  bool ascending = true;
  bool process = false;
  bool doit = true;
  int lowhn = 1;

  Future<void> HometoCart(int id) async {
    try {
      final req = await http.post(
        Uri.parse("${BASE_URL}cart/add"),
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
        body: jsonEncode({"VariantId": id, "quantity": 1}),
      );

      if (req.statusCode == 200) {
        print(jsonDecode(req.body)["message"]);
        print("jsdjjhdjdjjdjdjjd  ho gyayyaya");

        // NavigationBar.
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("✅ Added cart successfully!")));
        cartnn++;
        if (!mounted) return;
        setState(() {});
      } else {
        print("not added to cart... abbebebebbhhdshdhhdhnananannanan");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Not added cart, Server Issue!")),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cannot add to cart, Network Issue!")),
      );
      print("jdjdjjdjdjjdjjd");
    }
  }

  _lowhigh() {
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {
      lowhn = (lowhn == 1) ? 0 : 1;
    });
  }

  int alpha = 1;
  _AlphaUD() {
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {
      alpha = (alpha == 1) ? 0 : 1;
    });
  }

  List CourseL = List.from(productData1);

  void sortTopData(
    List<dynamic> list, {
    required bool byName, // true = sort by name, else sort by price
    required bool ascending, // true = low→high or A→Z; false = reverse
  }) {
    list.sort((a, b) {
      int result;
      if (byName) {
        final nameA = a['name'] as String;
        final nameB = b['name'] as String;
        result = nameA.compareTo(nameB); // alphabetical
      } else {
        final priceA = (int.parse(a["variants"][0]["price"]) as num).toDouble();
        final priceB = (int.parse(b['variants'][0]['price']) as num).toDouble();
        result = priceA.compareTo(priceB); // numeric
      }
      return ascending ? result : -result;
    });
  }

  Future<void> _getCatData() async {
    // TopData1 = [];
    // doit = false;
    // int ind = 1;

    print(userToken);

    try {
      final res = await http.get(
        Uri.parse("${BASE_URL}courses"),
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
      );
      // final res2 = await http.get(Uri.parse("https://hindustanapi.mtlapi.socialseller.in/api/subcategories"));

      if (res.statusCode == 200) {
        print("success");
        // dynamic tm = (json.decode(res.body)["data"]);
        // print(tm["Product"]);
        CourseL = json.decode(res.body)['courses'];
        print(json.decode(res.body));
        process = true;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {
          // CourseL = List.from(TopData1);
        });
      } else {
        process = true;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
        print("failure");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _cancelBooking(int bid) async {
    // TopData1 = [];
    // doit = false;
    // int ind = 1;

    try {
      final res = await http.post(
        Uri.parse("${BASE_URL}productBooking/cancel/${bid}"),
      );
      // final res2 = await http.get(Uri.parse("https://hindustanapi.mtlapi.socialseller.in/api/subcategories"));

      if (res.statusCode == 200) {
        print("success");
        print(jsonDecode(res.body));
        // dynamic tm = (json.decode(res.body)["data"]);
        // print(tm["Product"]);
        process = true;
        if (!mounted) return;
        _getCatData(); // prevents calling setState if widget is disposed

        // setState(() {
        //   // TopData1 = json.decode(res.body)["bookings"];
        //   // CourseL = List.from(TopData1);
        // });
        // SnackBar(content: Text("success"));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Booking cancel Successful!")));
      } else {
        print(jsonDecode(res.body));
        process = true;
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
        print("failure");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Booking cancel Failed!")));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Network error!")));
    }
  }

  void initState() {
    super.initState();

    doit = false;
    // CourseL = [];
    _getCatData();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  String load = "Loading";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            // radius: 5,
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined, color: widget.adth),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Courses",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(adth: widget.adth),
                    ),
                  );
                },
                icon: Icon(Icons.search, color: widget.adth),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (CourseL?.length == 0)
                          ? Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(child: Text("No Data Found!")),
                          )
                          : _getme(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomnn(),
    );
  }

  Color b11 = const Color.fromARGB(255, 169, 169, 169);
  Color b2 = const Color.fromARGB(255, 169, 169, 169);
  Color b3 = const Color.fromARGB(255, 169, 169, 169);
  Color b4 = const Color.fromARGB(255, 169, 169, 169);
  Color b5 = const Color.fromARGB(255, 169, 169, 169);

  Color b111 = Colors.grey;

  Widget bottomnn() {
    return BottomAppBar(
      surfaceTintColor: Colors.white,
      color: Colors.white,
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
                    builder: (context) => MyHome(adth: widget.adth, admin: 0),
                  ),
                  (context) => false,
                );
              },
              child: Column(
                children: [
                  Icon(Icons.home_outlined, size: 21, color: b1),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Home'),
                ],
              ),
            ),
          ),
          Container(
            height: 45,
            width: 60,
            child: MaterialButton(
              padding: EdgeInsets.only(bottom: 0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Cart1Page(adth: widget.adth, admin: 0),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.dashboard_outlined, color: widget.adth, size: 21),
                  Text(
                    'Category',
                    style: TextStyle(color: widget.adth, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 45,
            width: 60,
            child: MaterialButton(
              padding: EdgeInsets.only(bottom: 0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => VideoPage(admin: 2, adth: widget.adth),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.ondemand_video, color: b1, size: 21),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Shorts'),
                ],
              ),
            ),
          ),
          Container(
            height: 45,
            width: 60,
            child: MaterialButton(
              padding: EdgeInsets.only(bottom: 0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => CartDirPage(admin: 3, adth: widget.adth),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.shopping_cart_outlined, color: b1, size: 21),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Cart'),
                ],
              ),
            ),
          ),
          Container(
            height: 45,
            width: 60,
            child: MaterialButton(
              padding: EdgeInsets.only(bottom: 0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProfilePage(adth: widget.adth, admin: 0),
                  ),
                );
              },
              child: Column(
                children: [
                  Icon(Icons.person_outline, color: b1, size: 21),
                  Text(style: TextStyle(color: b1, fontSize: 13), 'Profile'),
                ],
              ),
            ),
          ),
        ],
      ),

      //
      // ],
    );
  }

  Widget _getCards({
    required int index,
    required String id,
    required String name,
    // required String quantity,
    // required String price,
    // required String productprice,
    required String image,
    // required String variant,
    String? createdAt,
    // String? status,
  }) {
    // int index = 0;

    return Center(
      child: Card(
        color: Colors.white,
        elevation: 2,
        child: Container(
          height: 160,
          width: MediaQuery.of(context).size.width - 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    (image != "")
                        ? image
                        : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                    // height: 150,
                    width: 80,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "#$id",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.adth,
                            ),
                          ),
                          Text(
                            createdAt!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 220,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Varient",
                              //       style: TextStyle(
                              //         fontSize: 10,
                              //         color: Colors.grey,
                              //       ),
                              //     ),
                              //     SizedBox(width: 5),
                              //     Text(
                              //       variant,
                              //       style: TextStyle(
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Quantity",
                              //       style: TextStyle(
                              //         fontSize: 10,
                              //         color: Colors.grey,
                              //       ),
                              //     ),
                              //     SizedBox(width: 5),
                              //     Text(
                              //       "$quantity",
                              //       style: TextStyle(
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "Booking Date",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "${createdAt ?? ""}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Text(
                              //       "Booking Time",
                              //       style: TextStyle(
                              //         fontSize: 10,
                              //         color: Colors.grey,
                              //       ),
                              //     ),
                              //     SizedBox(width: 5),
                              //     Text(
                              //       "${status ?? ""}",
                              //       style: TextStyle(
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),

                          // Column(
                          //   children: [
                          //     (CourseL[index]['bookingCancellation'])
                          //         ? Padding(
                          //           padding: const EdgeInsets.only(left: 0.0),
                          //           child: Text(
                          //             "Cancelled",
                          //             style: TextStyle(
                          //               fontWeight: FontWeight.bold,
                          //               fontSize: 13,
                          //               color: Colors.red,
                          //             ),
                          //           ),
                          //         )
                          //         : Column(
                          //           children: [
                          //             IconButton(
                          //               padding: EdgeInsets.all(0),
                          //               onPressed: () {
                          //                 _cancelBooking(int.parse(id));
                          //               },
                          //               icon: Card(
                          //                 margin: EdgeInsets.all(2),
                          //                 child: Icon(
                          //                   Icons.cancel_rounded,
                          //                   color: Colors.red,
                          //                 ),
                          //               ),
                          //             ),
                          //             // SizedBox(height: 15),
                          //             IconButton(
                          //               padding: EdgeInsets.all(0),
                          //               onPressed: () {
                          //                 _cancelBooking(int.parse(id));
                          //               },
                          //               icon: Card(
                          //                 margin: EdgeInsets.all(2),
                          //                 child: Icon(
                          //                   Icons.shopping_cart_outlined,
                          //                   color: Colors.green,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //     // Padding(
                          //     //   padding: const EdgeInsets.only(left: 0.0),
                          //     //   child: Text(
                          //     //     "₹ $price",
                          //     //     style: TextStyle(
                          //     //       fontWeight: FontWeight.bold,
                          //     //       fontSize: 14,
                          //     //     ),
                          //     //   ),
                          //     // ),
                          //   ],
                          // ),
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
    );
  }

  _getme() {
    Column a = Column(
      children: [
        for (int i = 0; i < CourseL.length; i++)
          (!(CourseL[i] != null))
              ? Container()
              : GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder:
                  //         (context) => OrderDetailsCard(
                  //           adth: widget.adth,
                  //           orderid: CourseL[i]["id"] ?? 1,
                  //           orderpic:
                  //               CourseL[i]["variant"]["product"]["thumbnail"]["url"] ??
                  //               "",
                  //         ),
                  //   ),
                  // );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder:
                  //         (context) => BuyItem(
                  //           adth: widget.adth,
                  //           buyid: CourseL[i]["productId"],
                  //         ),
                  //   ),
                  // );
                },
                child: _getCards(
                  id: CourseL[i]["id"].toString(),
                  index: i,
                  image:
                      CourseL[i]["thumbnail"] ??
                      "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",

                  // price: CourseL[i]["variant"]["price"].toString(),

                  // productprice: CourseL[i]["variant"]["price"] ?? "2222",
                  name: CourseL[i]?["name"] ?? "Failed name",
                  // quantity: CourseL[i]["productQuantity"].toString(),
                  // variant: CourseL[i]["variant"]["name"] ?? "hfdsd",
                  createdAt: DateFormat(
                    'dd-MMM-yyyy',
                  ).format(DateTime.parse(CourseL[i]["createdAt"]).toLocal()),

                  // status: DateFormat('hh:mm a').format(
                  //   DateTime.parse(CourseL[i]["createdAt"]).toLocal(),
                  // ),
                  // status: DateFormat(
                  //   'dd MMM yyyy, hh:mm a',
                  // ).format(DateTime.parse(CourseL[i]["expireDate"]).toLocal()),
                ),
              ),
      ],
    );
    return a;
  }
}
