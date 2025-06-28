import 'package:Template/Purchase/buyItem.dart';
import 'package:Template/models/categorymodel/cate.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: widget.adth,
                  ),
                  iconSize: 30,
                  color: widget.adth,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: (productData1.length == 0)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            child: Text("No Collection items found"),
                          ),
                        ),
                      ],
                    )
                  : _buildItemsGridDom(-1),
            ),
          ],
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
      child: Wrap(children: [
        for (int i = 0; i < n; i++)
          (!favIds.contains(productData1[i]["id"]))
              ? SizedBox()
              : productCard21(
                  name: (productData1.length > i)
                      ? productData1[i]["name"]
                      : "not found",
                  rating: productData1[i]["rating"],
                  left: productData1[i]["variants"][0]["quantity"],
                  price: productData1[i]["variants"][0]["price"],
                  oldPrice: productData1[i]["variants"][0]["strike_price"],
                  id: productData1[i]["id"],
                  image: (productData1.length > i)
                      ? productData1[i]["thumbnail"]["url"]
                      : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                  ok: false,
                ),
      ]),
    );
  }

  void _getans(int id) {
    // favIds.remove(id);

    // setState(() {});
  }

  productCard21({
    required int id,
    required String name,
    required int rating,
    required int left,
    required String price,
    required String oldPrice,
    required String image,
    required bool ok,
  }) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        elevation: 1,
        child: Container(
          width: 155,

          // color: const Color.fromRGBO(234, 229, 229, 1),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BuyItem(adth: widget.adth, buyid: id)));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: const Color.fromARGB(255, 250, 248, 248),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: image,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.broken_image),

                          // width: double.infinity,
                          // height: 100,
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
                                    (favIds.contains(id)) ? Colors.red : null),
                            onPressed: () {
                              // _getans(id);
                              (favIds.contains(id))
                                  ? {favIds.remove(id)}
                                  : favIds.add(id);
                              setState(() {});
                            },
                          )),
                        ),
                      ],
                    ),
                    // Container(
                    //   child: Image.network(
                    //     '$image',
                    //     // height: 110,
                    //     fit: BoxFit.cover,

                    //     // width: double.infinity,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaler: MediaQuery.textScalerOf(context),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
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
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  Text(
                                    "250k+",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                              Text("₹ $price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            ],
                          ),
                          Icon(
                            Icons.add_circle_rounded,
                            color: widget.adth,
                            size: 35,
                          )
                        ],
                      ),
                    ),
                    (ok == true)
                        ? Container()
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            padding: EdgeInsets.only(bottom: 15),
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
                                Text("+$rating")
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
    );
  }
}
