import 'dart:math';

import 'package:Template/CategoryPages/category1.dart';
import 'package:Template/CategoryPages/searchPage.dart';
import 'package:Template/CategoryPages/topPage.dart';
import 'package:Template/Purchase/cartdirect.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/pages/home.dart';
import 'package:Template/pages/profile.dart';
import 'package:Template/pages/video.dart';
import 'package:flutter/material.dart';

class Cart2Page extends StatefulWidget {
  final Color adth;

  Cart2Page({required this.adth});

  @override
  State<Cart2Page> createState() => _Cart2PageState();
}

class _Cart2PageState extends State<Cart2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Center(
            child: Text(
          'Categories',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
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
                              builder: (context) =>
                                  SearchPage(adth: widget.adth)));
                    },
                    icon: Icon(
                      Icons.search,
                      color: widget.adth,
                    ))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                saleTile(),
                SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Choose Category",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
                Column(
                  children: [
                    Options("Tops"),
                    Options("shirts and blouses"),
                    Options("cardigans & Sweaters"),
                    Options("knitwear"),
                    Options("Blazers"),
                    Options("Outerwear"),
                    Options("Pants"),
                    Options("Jeans"),
                    Options("Shorts"),
                    Options("Skirts"),
                    Options("Dresses"),
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

  Widget Options(String title) {
    return Container(
      height: 50,
      child: MaterialButton(
        height: 50,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SerchTopPage(
                        searchpro: title,
                        adth: widget.adth,
                        index: -1,
                      )));
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
    );
  }

  Widget saleTile() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: widget.adth,
        borderRadius: BorderRadius.circular(12),
      ),
      child: MaterialButton(
        height: 60,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SerchTopPage(
                        searchpro: "",
                        adth: widget.adth,
                        index: -1,
                      )));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'VIEW ALL ITEMS',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
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
                                admin: 0,
                              )));
                },
                child: Column(children: [
                  Icon(
                    Icons.dashboard_outlined,
                    color: widget.adth,
                    size: 21,
                  ),
                  Text(
                    'Category',
                    style: TextStyle(color: widget.adth, fontSize: 13),
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
                                admin: 0,
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
