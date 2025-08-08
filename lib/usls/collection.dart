import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:template/pages/buyItem.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionPage extends StatefulWidget {
  final Color adth;
  const CollectionPage({required this.adth});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,

        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Collection",
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
                  Navigator.pop(context);
                },
                icon: Icon(Icons.favorite_border_outlined, color: widget.adth),
                // iconSize: 30,
                color: widget.adth,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:
              (favIds.length == 0)
                  ? Container(
                    margin: EdgeInsets.symmetric(vertical: 120),
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        Center(
                          child: Container(
                            child: Text(
                              "No items found",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : _buildItemsGridDom(-1),
        ),
      ),
    );
  }

  Widget _buildItemsGridDom(int mxi) {
    int n = productData1.length;

    // if (mxi != -1) {
    //   n = mxi;
    // }

    return Center(
      child: Wrap(
        children: [
          for (int i = 0; i < n; i++)
            (!favIds.contains(productData1[i]["id"]))
                ? SizedBox()
                : productCard21(
                  name:
                      (productData1.length > i)
                          ? productData1[i]["name"]
                          : "not found",
                  rating: "${productData1[i]["rating"] ?? 0}",
                  left: productData1[i]["variants"][0]["quantity"],
                  price: productData1[i]["variants"][0]["price"],
                  oldPrice: productData1[i]["variants"][0]["strike_price"],
                  id: productData1[i]["id"],
                  image:
                      (productData1.length > i)
                          ? productData1[i]["thumbnail"]["url"]
                          : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                  ok: false,
                  category: productData1[i]["category"]["name"],
                ),
        ],
      ),
    );
  }

  void _getans(int id) {
    // favIds.remove(id);

    // if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  productCard21({
    required int id,
    required String name,
    required String rating,
    required int left,
    required String price,
    required String oldPrice,
    required String image,
    required bool ok,
    String? category,
  }) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        elevation: 1,
        child: Container(
          width: (MediaQuery.of(context).size.width) / 2 - 10,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyItem(adth: widget.adth, buyid: id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) => Icon(Icons.image),
                          errorWidget:
                              (context, url, error) => Icon(Icons.image),

                          width: double.infinity,
                          // height: 100,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        // Image.network(
                        //   '$image',
                        //   // height: 110,
                        //   fit: BoxFit.cover,

                        //   // width: double.infinity,
                        // ),
                        Positioned(
                          top: 1,
                          right: 1,
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: IconButton(
                              icon: Icon(
                                (favIds.contains(id))
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color:
                                    (favIds.contains(id)) ? Colors.red : null,
                              ),
                              onPressed: () {
                                // _getans(id);
                                (favIds.contains(id))
                                    ? {favIds.remove(id)}
                                    : favIds.add(id);
                                if (!mounted)
                                  return; // prevents calling setState if widget is disposed

                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        // textScaler: MediaQuery.textScalerOf(context),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        category!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        // textScaler: MediaQuery.textScalerOf(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amberAccent,
                                    size: 15,
                                  ),
                                  Text(
                                    "($rating.0)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "250k+",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "₹ $price",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Processing...")),
                              );
                              HometoCart(id);
                            },
                            icon: Icon(
                              Icons.add_circle_rounded,
                              color: widget.adth,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    (true)
                        ? Container()
                        : Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: CupertinoColors.systemYellow,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.deepPurpleAccent,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                              ),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.brown,
                              ),
                              Text("+0"),
                            ],
                          ),
                        ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildItemsGridDom(int mxi) {
  //   List showitm = [];

  //   if (mxi == 2) {
  //     showitm = productData2i;
  //   } else if (mxi == 4) {
  //     showitm = productData4i;
  //   } else if (mxi == 6) {
  //     showitm = productData6i;
  //   } else {
  //     showitm = productData1;
  //   }

  //   int n = showitm.length;

  //   return (loading && showitm == null)
  //       ? Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
  //             const SizedBox(height: 16),
  //             const Text(
  //               "No Internet Connection",
  //               style: TextStyle(fontSize: 20),
  //             ),
  //             const SizedBox(height: 20),
  //             IconButton(
  //               icon: Icon(Icons.refresh),
  //               onPressed: _checkConnection,
  //             ),
  //           ],
  //         )
  //       : GridView.builder(
  //           shrinkWrap: true,
  //           physics: NeverScrollableScrollPhysics(),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2, childAspectRatio: 0.56),
  //           itemCount: n,
  //           itemBuilder: (context, i) => productCard21(
  //             name: (showitm.length > i) ? showitm[i]["name"] : "not found",
  //             rating: "${showitm[i]["rating"] ?? 0}",
  //             left: showitm[i]["variants"][0]["quantity"],
  //             price: showitm[i]["variants"][0]["price"],
  //             oldPrice: showitm[i]["variants"][0]["strike_price"],
  //             id: showitm[i]["id"],
  //             image: (showitm.length > i)
  //                 ? showitm[i]["thumbnail"]["url"]
  //                 : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
  //             ok: false,
  //             categoryN: showitm[i]["category"]["name"],
  //           ),
  //         );

  //   // Center(
  //   //     child: Wrap(children: [
  //   //       for (int i = 0; i < n; i++)
  //   //         productCard21(
  //   //           name: (showitm.length > i) ? showitm[i]["name"] : "not found",
  //   //           rating: "${showitm[i]["rating"] ?? 0}",
  //   //           left: showitm[i]["variants"][0]["quantity"],
  //   //           price: showitm[i]["variants"][0]["price"],
  //   //           oldPrice: showitm[i]["variants"][0]["strike_price"],
  //   //           id: showitm[i]["id"],
  //   //           image: (showitm.length > i)
  //   //               ? showitm[i]["thumbnail"]["url"]
  //   //               : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
  //   //           ok: false,
  //   //           categoryN: showitm[i]["category"]["name"],
  //   //         ),
  //   //     ]),
  //   // );
  // }
}
