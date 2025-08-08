import 'dart:convert';

import 'package:template/pages/buyItem.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:template/pages/category1.dart';
import 'package:template/pages/topPage.dart';
import 'package:template/pages/cartdirect.dart';
import 'package:template/pages/home.dart';
import 'package:template/pages/profile.dart';
import 'package:template/usls/video.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final Color adth;
  const SearchPage({required this.adth});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

List itemsTop = List.from(productData1);

// TopData1 = productData1;
class _SearchPageState extends State<SearchPage> {
  // itemsTop = List.from(productData1);
  final cntrol = TextEditingController();

  String load = "Loading";

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

  Future<void> _getCatData(String ser) async {
    // TopData1 = [];
    // doit = false;
    // int ind = widget.index;
    try {
      final res = await http.get(
        Uri.parse("${BASE_URL}search/products?qs=$ser"),
      );
      // final res2 = await http.get(Uri.parse("https://hindustanapi.mtlapi.socialseller.in/api/subcategories"));

      if (res.statusCode == 200) {
        print("success sssssssssssssseeeeee");
        // print(json.decode(res.body)["data"]);
        itemsTop = json.decode(res.body)["data"];
        load = "No data found!";
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
      } else {
        itemsTop = [];
        print("failure");
      }
    } catch (e) {
      itemsTop = [];
      print(e);
    }
  }

  bool process = false;
  bool doit = true;
  int lowhn = 1;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      builder: (context) {
                        return SerchTopPage(
                          searchpro: "",
                          adth: widget.adth,
                          index: -1,
                        );
                      },
                    ),
                  );
                },
                icon: Icon(Icons.search, color: widget.adth),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 3.0,
                  left: 10,
                  right: 10,
                ),
                child: saleTile(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _AlphaUD();

                      if (alpha == 1) {
                        setState(
                          () => sortTopData(
                            itemsTop,
                            byName: true,
                            ascending: false,
                          ),
                        );
                      } else {
                        setState(
                          () => sortTopData(
                            itemsTop,
                            byName: true,
                            ascending: true,
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Alpha: " +
                                  "${(alpha != 1) ? "Asending" : "Desending"}",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(8),
                  //   margin: EdgeInsets.only(left: 8),
                  //   child: DropdownButton<String>(
                  //     style: TextStyle(color: Colors.blueGrey, fontSize: 13),
                  //     icon: Icon(Icons.filter_list),
                  //     value: _selectedSort,
                  //     items: _sortOptions.map((opt) {
                  //       return DropdownMenuItem(value: opt, child: Text(opt));
                  //     }).toList(),
                  //     onChanged: (value) {
                  //       if (value != null) {
                  //         _sortList(value);
                  //       }
                  //     },
                  //   ),
                  // ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: _filteredList.length,
                  //     itemBuilder: (context, i) {
                  //       final item = _filteredList[i];
                  //       return ListTile(
                  //         title: Text(item.name),
                  //         subtitle: Text(item.value.toString()),
                  //       );
                  //     },
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      _lowhigh();

                      if (lowhn != 1) {
                        setState(
                          () => sortTopData(
                            itemsTop,
                            byName: false,
                            ascending: false,
                          ),
                        );
                      } else {
                        setState(
                          () => sortTopData(
                            itemsTop,
                            byName: false,
                            ascending: true,
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                          (lowhn == 1)
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (lowhn == 1)
                                ? "Price: lowest to high"
                                : "Price: highest to low",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                SizedBox(height: 5),
                Column(
                  children: [
                    _buildItemsGridDom(),
                    // if(itemsTop.length == 0)
                    // Text("No data found!"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomnn(),
    );
  }

  productCard2({
    required int id2,
    required String name,
    required int rating,
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
          width: 155,

          // color: const Color.fromRGBO(234, 229, 229, 1),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BuyItem(adth: widget.adth, buyid: id2),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                color: const Color.fromARGB(255, 250, 248, 248),
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
                                (favIds.contains(id2))
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color:
                                    (favIds.contains(id2))
                                        ? Colors.red
                                        : Colors.grey,
                              ),
                              onPressed: () {
                                // _getans(id);
                                (favIds.contains(id2))
                                    ? {favIds.remove(id2)}
                                    : favIds.add(id2);
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
                              Row(
                                children: [
                                  Text(
                                    "₹ $price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "₹ ${oldPrice}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              HometoCart(id2);
                            },
                            icon: Icon(
                              Icons.add_circle_rounded,
                              color: widget.adth,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // (ok == true)
                    //     ? Container()
                    //     : Container(
                    //       margin: EdgeInsets.symmetric(horizontal: 15),
                    //       padding: EdgeInsets.symmetric(vertical: 5),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           CircleAvatar(
                    //             radius: 10,
                    //             backgroundColor: CupertinoColors.systemYellow,
                    //           ),
                    //           CircleAvatar(
                    //             radius: 10,
                    //             backgroundColor: Colors.deepPurpleAccent,
                    //           ),
                    //           CircleAvatar(
                    //             radius: 10,
                    //             backgroundColor: Colors.red,
                    //           ),
                    //           CircleAvatar(
                    //             radius: 10,
                    //             backgroundColor: Colors.brown,
                    //           ),
                    //           Text("+0"),
                    //         ],
                    //       ),
                    //     ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemsGridDom() {
    int n = itemsTop.length;

    // if (mxi != -1) {
    //   n = mxi;
    // }

    return (n == 0)
        ? Container(
          height: 300,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Text(
                  (load == "Loading") ? "" : load,
                  style: TextStyle(
                    fontSize: 16,
                    color: (load == "Loading") ? Colors.green : Colors.red,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (!mounted) return;
                    load = "Loading";

                    // _getmeuser();
                    // _getProfileData();
                    _getCatData(cntrol.text);
                    // cntrol.text = "";
                    setState(() {});
                  },
                  icon:
                      (load == "Loading")
                          ? RefreshProgressIndicator()
                          : Icon(Icons.refresh, color: Colors.blue),
                ),
              ],
            ),
          ),
        )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.53,
            ),
            itemCount: n,
            itemBuilder:
                (context, i) =>
                //  Center(
                //     child: Wrap(children: [
                // for (int i = 0; i < itemsTop.length; i++)
                productCard2(
                  name: itemsTop[i]["name"],
                  rating: 0,
                  left: itemsTop[i]["variants"][0]["quantity"],
                  price: itemsTop[i]["variants"][0]["price"],
                  oldPrice: itemsTop[i]["variants"][0]["strike_price"],
                  id2: itemsTop[i]["id"],
                  image:
                      itemsTop[i]["thumbnail"]["url"] ??
                      "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                  ok: false,
                  category: itemsTop[i]["category"]["name"],
                ),
            // ]),
          ),
        );
  }

  Widget Options(String title) {
    return Container(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(.5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: MaterialButton(
            height: 49,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SerchTopPage(
                        searchpro: "",
                        adth: widget.adth,
                        index: -1,
                      ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(4),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCategoryTile(String title, String imageUrl) {
    int heigh = 100;
    return Container(
      height: 100,
      // padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  '$title',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Image.asset('$imageUrl', height: 100, fit: BoxFit.cover),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget saleTile() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: widget.adth),
      ),
      child: TextField(
        controller: cntrol,
        // onTap: () {
        //   _getCatData(cntrol.text);
        // },
        onChanged: (ValueKey) {
          _getCatData(ValueKey);
        },
        // enabled: true,
        // enableInteractiveSelection: true,
        decoration: InputDecoration(
          labelText: 'Search for "Summer"',
          // labelText: "Search",
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.adth),
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: Icon(Icons.search_sharp, size: 28),
          filled: true,
          // fillColor: const Color.fromARGB(255, 237, 232, 232),
          // hintTextDirection: ,
        ),
      ),
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
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
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
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
                Navigator.pushReplacement(
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
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
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

          Stack(
            children: [
              if (cartnn != 0)
                Positioned(
                  top: 0,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: adth,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 3),

                    child: Text(
                      "${cartnn}",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              Container(
                height: 45,
                width: 60,
                child: GestureDetector(
                  // padding: EdgeInsets.only(bottom: 0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                CartDirPage(admin: 3, adth: widget.adth),
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
            ],
          ),
          Container(
            height: 45,
            width: 60,
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
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
}
