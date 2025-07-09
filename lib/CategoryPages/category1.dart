import 'dart:convert';

import 'package:template/CategoryPages/category2.dart';
import 'package:template/CategoryPages/searchPage.dart';
import 'package:template/CategoryPages/topPage.dart';
import 'package:template/Purchase/cartdirect.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/pages/home.dart';
import 'package:template/pages/profile.dart';
import 'package:template/pages/video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class Cart1Page extends StatefulWidget {
  final Color adth;
  final int admin;

  Cart1Page({required this.adth, required this.admin});
  @override
  State<Cart1Page> createState() => _Cart1PageState();
}

bool ok = true;
List<bool> ctg = List.filled(101, false);

class _Cart1PageState extends State<Cart1Page> {
  bool getban = true;
  bool ctgi = false;

  Future<void> _getBannerData() async {
    getban = false;
    if (categoData.isEmpty) {
      try {
        final responseCategory = await http.get(
          Uri.parse("${BASE_URL}categories"),
        );

        if (responseCategory.statusCode == 200) {
          final jsonBody = json.decode(responseCategory.body);

          final List categories = jsonBody["data"];
          categoData = categories;
          ctg = [];
          int n = categories.length;
          ctg = List.filled(n, false);
          // for (var product in categories) {
          //   categoData.add(product);
          // }
          if (!mounted)
            return; // prevents calling setState if widget is disposed

          setState(() {});
          print("hattt lakallkal");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void initState() {
    super.initState();
    _getBannerData();


    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate network call
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: widget.adth,
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Categories',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
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
                        builder: (context) {
                          return SearchPage(adth: widget.adth);
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.search, color: widget.adth),
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: widget.adth,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,

            // tabAlignment: TabAlignment.fill,
            tabs: [Tab(text: 'Women'), Tab(text: 'Men'), Tab(text: 'Kids')],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TabBarView(
              children: [
                RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        saleTile(),
                        for (int i = 0; i < categoData.length; i++)
                          buildCategoryTile(
                            categoData[i]["name"],
                            categoData[i]['thumbnail']["url"],
                            i,
                            categoData[i]["id"] ?? 0,
                          ),
                        // buildCategoryTile('New', 'assets/jean.jpg'),
                        // buildCategoryTile('Clothes', 'assets/shirt.jpg'),
                        // buildCategoryTile('Shoes', 'assets/jean.jpg'),
                        // buildCategoryTile('Accessories', 'assets/shirt.jpg'),
                      ],
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        saleTile(),
                        for (int i = 0; i < categoData.length; i++)
                          buildCategoryTile(
                            categoData[i]["name"],
                            categoData[i]['thumbnail']["url"],
                            i,
                            categoData[i]["id"] ?? 0,
                          ),
                      ],
                    ),
                  ),
                ),
                RefreshIndicator(
                  onRefresh: _refreshData,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        saleTile(),
                        for (int i = 0; i < categoData.length; i++)
                          buildCategoryTile(
                            categoData[i]["name"],
                            categoData[i]['thumbnail']["url"],
                            i,
                            categoData[i]["id"] ?? 0,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomnn(),
      ),
    );
  }

  Widget buildCategoryTile(String title, String imageUrl, int index, int id) {
    int heigh = 100;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () {
          // _getCatData(index);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      SerchTopPage(searchpro: "", adth: widget.adth, index: id),
            ),
          );
        },
        onTapDown: (_) => setState(() => ctg?[index] = true),
        onTapUp: (_) => setState(() => ctg?[index] = false),
        onTapCancel: () => setState(() => ctg?[index] = false),
        child: AnimatedScale(
          scale: ctg[index] ? 0.95 : 1.0,
          duration: Duration(milliseconds: 950),
          curve: Curves.easeInOut,
          child: Card(
            elevation: 1,
            child: Column(
              children: [
                Container(
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
                            padding: const EdgeInsets.only(
                              top: 24.0,
                              left: 24,
                              bottom: 24,
                            ),
                            child: Container(
                              width: 140,
                              child: Text(
                                '$title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Icon(Icons.image),
                              errorWidget:
                                  (context, url, error) => Icon(Icons.image),

                              // width: 120,
                              width: 120,
                              height: 100,
                              fit: BoxFit.cover,
                            ),

                            // Image.network(
                            //                       '$imageUrl',
                            //                       height: 100,
                            //                       fit: BoxFit.cover,
                            //                     ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget saleTile() {
    return GestureDetector(
      onTap: () {
        TopData1 = productData1;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Cart2Page(adth: widget.adth)),
        );
      },
      onTapDown: (_) => setState(() => ctgi = true),
      onTapUp: (_) => setState(() => ctgi = false),
      onTapCancel: () => setState(() => ctgi = false),
      child: AnimatedScale(
        scale: ctgi ? 0.95 : 1.0,
        duration: Duration(milliseconds: 950),
        curve: Curves.easeInOut,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: widget.adth,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'SUMMER SALES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Up to 50% off',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color b11 = const Color.fromARGB(255, 169, 169, 169);

  Color b111 = const Color.fromARGB(255, 169, 169, 169);

  /*************  ✨ Windsurf Command ⭐  *************/
  /// Returns a BottomAppBar with a row of 5 MaterialButtons.
  ///
  /// The buttons are Home, Category, Shorts, Cart, and Profile.
  ///
  /// The buttons are colored with [widget.adth] and grey.
  ///
  /// The buttons are sized to 45x45.
  ///
  /// When the Home button is pressed, it navigates to the home page.
  ///
  /// When the Category button is pressed, it navigates to the category page.
  ///
  /// When the Shorts button is pressed, it navigates to the shorts page.
  ///
  /// When the Cart button is pressed, it navigates to the cart page.
  ///
  /// When the Profile button is pressed, it navigates to the profile page.
  ///
  /// The buttons are positioned in a row with even spacing.
  ///
  /*******  7143046e-8448-4aff-b932-3972f7bb72e1  *******/
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            Cart1Page(adth: widget.adth, admin: widget.admin),
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
                        (context) =>
                            ProfilePage(adth: widget.adth, admin: widget.admin),
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
