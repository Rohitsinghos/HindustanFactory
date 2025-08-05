import 'dart:convert';

import 'package:template/deepPage/orderDetails.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/usls/collection.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrdersPage extends StatefulWidget {
  final Color adth;
  final int page;

  OrdersPage({required this.adth, required this.page});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool showPagers = false;
  bool nxpg = false;
  List orderUserdata = [];

  void sortTopData(
    List<dynamic> list, {
    required bool byName, // true = sort by name, else sort by price
    required bool ascending, // true = low→high or A→Z; false = reverse
  }) {
    list.sort((a, b) {
      int result;
      // if (byName) {
      //   final nameA = a['status'] as String;
      //   final nameB = b['status'] as String;
      //   result = nameA.compareTo(nameB); // alphabetical
      // } else {
      final priceA = (a["id"]).toDouble();
      final priceB = (b['id']).toDouble();
      result = priceA.compareTo(priceB); // numeric
      // }
      return ascending ? result : -result;
    });
  }

  Future<void> _getmeuseroderss() async {
    try {
      final res = await http.get(
        Uri.parse(
          '${BASE_URL}order-variants/store-users', //?&&pagination[page]=$curpg&pagination[pageSize]=20',
        ),
        headers: {'Authorization': "Bearer ${userToken}"},
      );

      if (res.statusCode == 200) {
        print("success userrrrrrrrrrrrrrrrrrrr");
        // userData = json.decode(res.body)["data"];
        processing = false;
        // print(json.decode(res.body)["data"]);

        orderUserdata = json.decode(res.body)["data"];
        sortTopData(orderUserdata, byName: false, ascending: false);

        if (orderUserdata.length == 20) {
          nxpg = true;
        }

        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
        // print(userData);
      } else {
        print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getmeuseroderssAs(String sta) async {
    try {
      final res = await http.get(
        Uri.parse(
          '${BASE_URL}order-variants/store-users?status=$sta', //&&pagination[page]=$curpg&pagination[pageSize]=20',
        ),
        headers: {'Authorization': "Bearer ${userToken}"},
      );

      if (res.statusCode == 200) {
        print("success userrrrrrrrrrrrrrrrrrrr");
        // userData = json.decode(res.body)["data"];

        orderUserdata = json.decode(res.body)["data"];
        // print(orderUserdata);
        sortTopData(orderUserdata, byName: false, ascending: false);
        if (!mounted) return; // prevents calling setState if widget is disposed
        processing = false;
        setState(() {});

        // if (!mounted) return; // prevents calling setState if widget is disposed
        // // processing = false;
        // setState(() {});
        // print(userData);
      } else {
        print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      }
    } catch (e) {
      print(e);
    }
  }

  int choosen = 0;

  void initState() {
    super.initState();
    _getmeuseroderss();

    if (!mounted) {}
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  List hed = [
    'All',
    "NEW",
    "ACCEPTED",
    "DECLINED",
    "PROCESSING",
    "INTRANSIT",
    "OUT_FOR_DELIVERY",
    "DELIVERED",
    "CANCELLED",
    "COMPLETED",
    "PAYOUT_DONE",
    "RTO",
    "RETURN_REQUEST",
    "RETURN_ACCEPTED",
    "RETURN_DECLINED",
    "RETURN_RECEIVED",
    "RETURN_PENDING",
  ];

  int curpg = 1;

  bool processing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,

        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text("Orders", style: TextStyle(fontWeight: FontWeight.bold)),
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
                      builder: (context) {
                        return CollectionPage(adth: widget.adth);
                      },
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    child: ListView.builder(
                      itemCount: hed.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              processing = true;
                              orderUserdata = [];

                              _getmeuseroderssAs(hed[index]);

                              choosen = index;
                              curpg = 1;
                              if (!mounted)
                                return; // prevents calling setState if widget is disposed

                              setState(() {});
                            },
                            child: Card(
                              color:
                                  (choosen == index)
                                      ? widget.adth
                                      : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                  vertical: 5,
                                ),
                                child: Text(
                                  hed[index],
                                  style: TextStyle(
                                    color:
                                        (choosen != index)
                                            ? Colors.black
                                            : Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  (orderUserdata.length == 0)
                      ? ((processing)
                          ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: RefreshProgressIndicator(color: adth),
                            ),
                          )
                          : Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 50.0,
                                ),
                                child: Center(child: Text("No Data Found!")),
                              ),
                            ],
                          ))
                      : Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [_getme()],
                        ),
                      ),
                ],
              ),
            ),
            (true || (curpg <= 1 && orderUserdata.length < 20))
                ? Container()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              (curpg >= 2) ? widget.adth : Colors.grey,
                        ),
                        onPressed: () {
                          if (curpg >= 2) {
                            curpg--;
                            if (choosen == 0) {
                              _getmeuseroderss();
                            } else {
                              _getmeuseroderssAs(hed[choosen]);
                            }
                          }
                        },
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return CollectionPage(adth: widget.adth);
                        child: Text(
                          "Previous Page",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Text("${curpg}"),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              (orderUserdata.length < 20)
                                  ? Colors.grey
                                  : widget.adth,
                        ),
                        onPressed: () {
                          if ((orderUserdata.length == 20)) {
                            curpg++;
                            if (choosen == 0) {
                              _getmeuseroderss();
                            } else {
                              _getmeuseroderssAs(hed[choosen]);
                            }
                          }
                        },
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return CollectionPage(adth: widget.adth);
                        child: Text(
                          "Next Page",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }

  Widget _getCards({
    required String id,
    required String name,
    required String quantity,
    required String price,
    required String productprice,
    required String image,
    required String variant,
    String? createdAt,
    String? status,
  }) {
    // int index = 0;

    return Card(
      color: Colors.white,
      elevation: 2,
      child: Container(
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
                  height: 110,
                  width: 80,
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
                            Row(
                              children: [
                                Text(
                                  "Varient",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  variant,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "$quantity",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Status",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${status ?? ""}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            "₹ $price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
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
    );
  }

  _getme() {
    Column a = Column(
      children: [
        for (int i = 0; i < orderUserdata.length; i++)
          (!(orderUserdata[i] != null &&
                  orderUserdata[i]["variant"] != null &&
                  orderUserdata[i]["variant"]["product"] != null &&
                  orderUserdata[i]["variant"]["product"]["thumbnail"] != null &&
                  orderUserdata[i]["variant"]["product"]["thumbnail"]["url"] !=
                      null))
              ? Container()
              : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => OrderDetailsCard(
                            adth: widget.adth,
                            orderid: orderUserdata[i]["id"] ?? 1,
                            orderpic:
                                orderUserdata[i]["variant"]["product"]["thumbnail"]["url"] ??
                                "",
                          ),
                    ),
                  );
                },
                child: _getCards(
                  id: orderUserdata[i]["id"].toString(),
                  image:
                      orderUserdata[i]["variant"]["product"]["thumbnail"]["url"] ??
                      "",
                  price: orderUserdata[i]["price"].toString(),
                  productprice: orderUserdata[i]["variant"]["price"] ?? "2222",
                  name:
                      orderUserdata[i]["variant"]["product"]["name"] ?? "hello",
                  quantity: orderUserdata[i]["quantity"].toString(),
                  variant: orderUserdata[i]["variant"]["name"] ?? "hfdsd",
                  createdAt: DateFormat('dd MMM yyyy, hh:mm a').format(
                    DateTime.parse(orderUserdata[i]["createdAt"]).toLocal(),
                  ),
                  status: orderUserdata[i]["status"],
                ),
              ),
      ],
    );
    return a;
  }
}
