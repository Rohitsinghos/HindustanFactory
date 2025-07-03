import 'package:Template/CategoryPages/category1.dart';
import 'package:Template/CategoryPages/searchPage.dart';
import 'package:Template/CategoryPages/topPage.dart';
import 'package:Template/Purchase/buyItem.dart';
import 'package:Template/Purchase/cartdirect.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/models/model1.dart';
import 'package:Template/pages/notification.dart';
import 'package:Template/pages/profile.dart';
import 'package:Template/pages/video.dart';
import 'package:Template/profilePages/collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class MyHome extends StatefulWidget {
  final Color adth;
  final int admin;

  MyHome({required this.adth, required this.admin});
  @override
  State<MyHome> createState() => _MyHomeState();
}

int n = 5;

Color b2 = const Color.fromARGB(255, 169, 169, 169);
Color b3 = const Color.fromARGB(255, 169, 169, 169);
Color b4 = const Color.fromARGB(255, 169, 169, 169);
Color b5 = const Color.fromARGB(255, 169, 169, 169);

int i = 0;
int activeIndex = 0;
bool ok = true;

class _MyHomeState extends State<MyHome> {
  late ScrollController _scrollController;

  final txcont = TextEditingController();

  @override
  // void initState() {
  //   super.initState();
  // }
  bool _imgLoading = false;
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _openCamera() async {
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() => _imgLoading = true);

    try {
      final XFile? file = await picker.pickImage(source: ImageSource.camera);

      if (!mounted) return; // prevents calling setState if widget is disposed

      if (!mounted) return; // prevents calling setState if widget is disposed

      setState(() {
        _imgLoading = false;
        if (file != null) {
          _imageFile = File(file.path);
        } else {
          // User denied or canceled camera
          print("📷 Camera access cancelled or denied.");
        }
      });
    } catch (e) {
      if (!mounted) return;
      if (!mounted) return; // prevents calling setState if widget is disposed

      setState(() => _imgLoading = false);
      print("❌ Camera error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Camera permission denied or not available.")),
      );
    }
  }

  Future<void> fetchProducts() async {
    try {
      if (productData1.length == 0) {
        try {
          final responseBanner1 = await http.get(
            Uri.parse(
              BASE_URL + "products",
            ),
          );

          if (responseBanner1.statusCode == 200) {
            final jsonBody = json.decode(responseBanner1.body);

            productData1 = jsonBody["data"];
            TopData1 = productData1;
          } else {
            print("Failed to load banner data");
          }
        } catch (e) {
          print(e);
        }
      }

      ok = false;

      if (bannerData.length == 0) {
        final responseBanner = await http.get(
          Uri.parse(
            "https://hindustanapi.mtlapi.socialseller.in/api/store-banners",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${"token"}',
          },
        );
        // imageUrls.clear();
        if (responseBanner.statusCode == 200) {
          final jsonBody = json.decode(responseBanner.body);

          final List banners = jsonBody["data"];

          bannerData = banners;
          // for (var product in banners) {
          //   bannerData.add(product);
          // }

          // print(bannerData);

          if (!mounted) return;
          if (!mounted)
            return; // prevents calling setState if widget is disposed

          setState(() {});
        } else {
          print("Failed to load banner data");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    fetchProducts();
    _checkConnection();
    _getrand4();
    _scrollController = ScrollController();

    if (!mounted) {
      return;
    }
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  _getrand4() async {
    try {
      if (productData4i.length == 0) {
        final rs = await http.get(
          Uri.parse(
            BASE_URL + "products/4/random",
          ),
        );

        if (rs.statusCode == 200) {
          productData4i = json.decode(rs.body)["data"];
          print("success to get random products");
        } else {
          print("failed to get random products");
        }
      }
    } catch (e) {
      print(e);
    }
    try {
      if (productData2i.length == 0) {
        final rs = await http.get(
          Uri.parse(
            BASE_URL + "products/2/random",
          ),
        );

        if (rs.statusCode == 200) {
          productData2i = json.decode(rs.body)["data"];
          print("success to get random products");
        } else {
          print("failed to get random products");
        }
      }
    } catch (e) {
      print(e);
    }
    try {
      if (productData13i.length == 0) {
        final rs = await http.get(
          Uri.parse(
            BASE_URL + "products/12/random",
          ),
        );

        if (rs.statusCode == 200) {
          productData13i = json.decode(rs.body)["data"];
          print("success to get random products");
        } else {
          print("failed to get random products");
        }
      }
    } catch (e) {
      print(e);
    }
    try {
      if (productData6i.length == 0) {
        final rs = await http.get(
          Uri.parse(
            BASE_URL + "products/6/random",
          ),
        );

        if (rs.statusCode == 200) {
          productData6i = json.decode(rs.body)["data"];
          print("success to get random products");
        } else {
          print("failed to get random products");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (!mounted) return;

    // Simulate network call
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  Future<void> _checkConnection() async {
    final result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      loading = true;
    } else {
      loading = false;
      fetchProducts();
      _checkConnection();
      _getrand4();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (productData1.isEmpty && ok) {
      fetchProducts();
    }

    int nfp = productData13i.length;

    int nfpp = nfp ~/ 2;

    if (nfp != nfpp * 2) {
      nfpp = nfpp + 1;
    }

    // final store = GetStorage();

    // store.write("adth", widget.adth);

    // Navigator.popUntil(context, (route) => route.isFirst);

    return WillPopScope(
        onWillPop: () async {
          // Show the confirmation dialog
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Do you want to exit the Hindustan Factory app?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          );
          // If the user confirmed, exit the app
          return shouldExit ?? false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: CachedNetworkImage(
                imageUrl:
                    'https://mtt-s3.s3.ap-south-1.amazonaws.com/1744179549972Adobe%20Express%20-%20file.WEBP',
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.broken_image),

                // width: double.infinity,
                // height: 100,
                height: 30,
                // fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.qr_code, color: Colors.white),
                onPressed: () {
                  _openCamera();
                  // open the QR scanner
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: .0),
                child: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CollectionPage(adth: widget.adth)));
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NotificationPage(adth: widget.adth)));
                  },
                  icon: Icon(Icons.notifications, color: Colors.white)),
              SizedBox(width: 10),
            ],
            elevation: 3,
            backgroundColor: widget.adth,
            toolbarHeight: 35,
          ),
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                color: Colors.white,
                child: Column(children: [
                  Column(
                    children: [
                      // Search bar
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchPage(adth: widget.adth)));
                        },
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 50,
                              color: const Color.fromARGB(255, 245, 243, 243),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.search_sharp,
                                      size: 28,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Search for "Summer"',
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Horizontal Category List

                      // ListView.builder(
                      //     controller: cntr,
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 3,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       Image.network(
                      //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjJXDfQzJr29BNZBb0fHK2JwpJC7MBEi-3KQ&s');
                      //     }),

                      // Container(
                      //   height: 80,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: categories.length,
                      //     itemBuilder: (BuildContext context, index) {
                      //       return Container(
                      //         height: 67,

                      //         child: MaterialButton(
                      //           onPressed: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         CategoryPage(adth: widget.adth)));
                      //           },
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(5),
                      //             child:
                      //                 Image.asset("${categories[index]['image']}"),
                      //           ),
                      //         ), // Replace with Image.asset
                      //       );
                      //     },
                      //   ),
                      // ),

                      // // Banner
                      // Padding(
                      //   padding: const EdgeInsets.all(12.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.amber.shade100,
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     padding: EdgeInsets.all(16),
                      //     child: Row(
                      //       children: [
                      //         Expanded(
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text("SPECIAL DAY",
                      //                   style: TextStyle(fontWeight: FontWeight.bold)),
                      //               SizedBox(height: 5),
                      //               Text("OPENING STORE",
                      //                   style: TextStyle(
                      //                       fontSize: 18, fontWeight: FontWeight.bold)),
                      //               SizedBox(height: 5),
                      //               Text("Get discount All Item up to 45% OFF"),
                      //               SizedBox(height: 10),
                      //               ElevatedButton(
                      //                 onPressed: () {},
                      //                 child: Text("SHOP NOW"),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         SizedBox(width: 10),
                      //         Icon(Icons.shopping_bag,
                      //             size: 80), // Replace with banner image
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.stretch,
                      //   children: [
                      //     Center(
                      //         child: Text(
                      //       "View All Categories",
                      //       style: TextStyle(
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //           color: const Color.fromARGB(209, 128, 127, 127)),
                      //     )),
                      //   ],
                      // ),
                      _categoryBanner(4),

                      // Top Picks / New Arrivals
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text("Top Picks",
                      //           style: TextStyle(
                      //               fontSize: 16, fontWeight: FontWeight.bold)),
                      //       Text("New Arrivals",
                      //           style: TextStyle(
                      //               fontSize: 16, fontWeight: FontWeight.bold)),
                      //     ],
                      //   ),
                      // ),

                      // SizedBox(height: 20),

                      // Sort & Filter
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.sort),
                      //       SizedBox(width: 5),
                      //       Text("Sort By"),
                      //       Spacer(),
                      //       Icon(Icons.filter_list),
                      //       SizedBox(width: 5),
                      //       Text("Filter"),
                      //     ],
                      //   ),
                      // ),

                      // _buildCategoryTabs(),

                      // _buildSortFilterRow(),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Features Brand",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SerchTopPage(
                                                    searchpro: "",
                                                    adth: widget.adth,
                                                    index: -1,
                                                  )));
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SerchTopPage(
                                                      searchpro: "",
                                                      adth: widget.adth,
                                                      index: -1,
                                                    )));
                                      },
                                      child: Text("view more",
                                          style: TextStyle(color: Colors.grey)),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),

                      (loading)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.wifi_off,
                                    size: 80, color: Colors.grey),
                                const SizedBox(height: 16),
                                const Text(
                                  "No Internet Connection",
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 20),
                                IconButton(
                                  icon: Icon(Icons.refresh),
                                  onPressed: _checkConnection,
                                ),
                              ],
                            )
                          : Container(),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            for (int i = 0; i < 4; i++)
                              GestureDetector(
                                onTap: () {
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
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",

                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.broken_image),

                                        // width: double.infinity,
                                        // height: 100,
                                        width: 78,
                                        fit: BoxFit.cover,
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Hindustan Factory",
                                        style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 5, top: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Features Products",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SerchTopPage(
                                                    searchpro: "",
                                                    adth: widget.adth,
                                                    index: -1,
                                                  )));
                                    },
                                    child: Text("view more",
                                        style: TextStyle(color: Colors.grey)))
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, bottom: 5),
                        child: (loading && productData13i == null)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.wifi_off,
                                      size: 80, color: Colors.grey),
                                  const SizedBox(height: 16),
                                  const Text(
                                    "No Internet Connection",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 20),
                                  IconButton(
                                    icon: Icon(Icons.refresh),
                                    onPressed: _checkConnection,
                                  ),
                                ],
                              )
                            : Container(
                                height: 270,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: nfpp,
                                    itemBuilder: (context, index) {
                                      int xx = index * 2;
                                      int yy = (index * 2) + 1;
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BuyItem(
                                                            adth: widget.adth,
                                                            buyid: (productData13i
                                                                        .length >
                                                                    xx)
                                                                ? productData13i[
                                                                    xx]["id"]
                                                                : -1,
                                                          )));
                                            },
                                            child: Container(
                                              width: 80,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 4.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: (productData13i
                                                                      .length >
                                                                  xx)
                                                              ? productData13i[
                                                                          xx][
                                                                      "thumbnail"]
                                                                  ["url"]
                                                              : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",

                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(Icons
                                                                  .broken_image),

                                                          // width: double.infinity,
                                                          // height: 100,
                                                          height: 90,
                                                          fit: BoxFit.cover,
                                                          // fit: BoxFit.cover,
                                                        ),
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      (productData13i.length >
                                                              xx)
                                                          ? productData13i[xx]
                                                              ["name"]
                                                          : "Laptop & pc ausdhsjj s sjs j ajaj aa ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 9),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          (productData13i.length <= yy)
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    BuyItem(
                                                                      adth: widget
                                                                          .adth,
                                                                      buyid: (productData13i.length >
                                                                              yy)
                                                                          ? productData13i[yy]
                                                                              [
                                                                              "id"]
                                                                          : -1,
                                                                    )));
                                                  },
                                                  child: Container(
                                                    width: 80,
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 4.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: (productData13i
                                                                            .length >
                                                                        yy)
                                                                    ? productData13i[yy]
                                                                            [
                                                                            "thumbnail"]
                                                                        ["url"]
                                                                    : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Center(
                                                                        child:
                                                                            CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Icon(Icons
                                                                        .broken_image),

                                                                // width: double.infinity,
                                                                // height: 100,
                                                                height: 90,
                                                                fit: BoxFit
                                                                    .cover,
                                                                // fit: BoxFit.cover,
                                                              ),
                                                            )),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            (productData13i
                                                                        .length >
                                                                    yy)
                                                                ? productData13i[
                                                                    yy]["name"]
                                                                : "Laptop & pc ausdhsjj s sjs j ajaj aa ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 9),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                        ],
                                      );
                                    }),
                              ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Domenstic Shipping",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      _buildItemsGridDom(2),

                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SerchTopPage(
                                          searchpro: "",
                                          adth: widget.adth,
                                          index: -1,
                                        )));
                          },
                          child: Center(
                              child: Text(
                            "View More",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      Container(
                        color: const Color.fromARGB(255, 249, 246, 223),
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Trending Products",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 15),
                              child: (loading && productData6i == null)
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.wifi_off,
                                            size: 80, color: Colors.grey),
                                        const SizedBox(height: 16),
                                        const Text(
                                          "No Internet Connection",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 20),
                                        IconButton(
                                          icon: Icon(Icons.refresh),
                                          onPressed: _checkConnection,
                                        ),
                                      ],
                                    )
                                  : Container(
                                      height: 350,
                                      child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            for (int i = 0;
                                                i < productData6i.length;
                                                i++)
                                              productCard2(
                                                name: (productData6i.length > i)
                                                    ? productData6i[i]["name"]
                                                    : "not found",
                                                rating:
                                                    "${productData6i[i]["rating"] ?? "0"}",
                                                left: productData6i[i]
                                                    ["variants"][0]["quantity"],
                                                price: productData6i[i]
                                                    ["variants"][0]["price"],
                                                oldPrice: productData6i[i]
                                                        ["variants"][0]
                                                    ["strike_price"],
                                                id: productData6i[i]["id"],
                                                image: (productData6i.length >
                                                        i)
                                                    ? productData6i[i]
                                                        ["thumbnail"]["url"]
                                                    : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                                                categoryN: productData6i[i]
                                                    ["category"]["name"],
                                              ), // ok: false,
                                          ]),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Deals for you",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),

                      _buildItemsGridDom(4),

                      _categoryBanner(-1),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildItemsGridDom(-1),
                      ),

                      // ListView(
                      //   children: Items.map((item) {
                      //     return ListTile(
                      //       title: productCard(
                      //         name: 'jj', //'${item['name']}',
                      //         rating: 2,
                      //         left: 3,
                      //         price: 200,
                      //         oldPrice: 5000,
                      //         // image: '${item['image']}',
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      // _GridAlsoLike(),

                      // SizedBox(
                      //   width: 200,
                      //   child: ListView.builder(
                      //     itemCount: 10,
                      //     itemBuilder: (context, index) => Text("hh $index"),
                      //   ),
                      // ),

                      // Container(
                      //   margin: EdgeInsets.all(5),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: Container(
                      //         color: widget.adth,
                      //         child: Wrap(children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               "You may also like this",
                      //               style: TextStyle(
                      //                   fontSize: 23,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.white),
                      //             ),
                      //           ),
                      //           _GridAlsoLike(),
                      //         ])),
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: 20,
                      // ),

                      // _categoryBanner("assets/sale.png"),
                      // // GridView.count(
                      // //   crossAxisCount: 2,
                      // //   childAspectRatio: 0.7,
                      // //   children: [
                      // //     productCard(
                      // //       name: 'Lamar Weaver',
                      // //       rating: 5,
                      // //       left: 755,
                      // //       price: 652,
                      // //       oldPrice: 746,
                      // //     ),
                      // //     productCard(
                      // //       name: 'Product 1',
                      // //       rating: 1,
                      // //       left: 123,
                      // //       price: 160,
                      // //       oldPrice: 180,
                      // //     ),
                      // //   ],
                      // // ),

                      // Container(
                      //     child: Wrap(children: [
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: 20.0, left: 15),
                      //     child: Text(
                      //       "Top selling products",
                      //       style: TextStyle(
                      //         fontSize: 23,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      //   _buildItemsGrid(),
                      // ])),
                    ],
                  ),
                ]),
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
                    height: 55,
                    width: 60,
                    child: MaterialButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      child: Column(children: [
                        Icon(
                          Icons.home_outlined,
                          size: 21,
                          color: widget.adth,
                        ),
                        Text(
                            style: TextStyle(color: widget.adth, fontSize: 13),
                            'Home'),
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
                        Text(
                            style: TextStyle(color: b1, fontSize: 13),
                            'Shorts'),
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
                        Icon(Icons.person_outline, color: b1, size: 21),
                        Text(
                            style: TextStyle(color: b1, fontSize: 13),
                            'Profile'),
                      ]),
                    )),
              ],
            ),

            //
            // ],
          ),
        ));
  }

  // productCard({
  //   required int id,
  //   required String name,
  //   required int rating,
  //   required int left,
  //   required double price,
  //   required double oldPrice,
  //   String? image,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Card(
  //       elevation: 2,
  //       child: Container(
  //         width: 160,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(12),
  //           border: Border.all(color: Colors.grey),
  //         ),
  //         // color: Colors.white,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(12),
  //           child: Container(
  //             width: 160,
  //             padding: EdgeInsets.all(0),
  //             margin: EdgeInsets.all(0),
  //             color: Colors.white,,
  //             child: MaterialButton(
  //               minWidth: 160,
  //               onPressed: () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                   return BuyItem(
  //                     adth: widget.adth,
  //                     buyid: id,
  //                   );
  //                 }));
  //               },
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     child: Image.asset(
  //                       (image != null) ? image : 'assets/im.jpeg',
  //                       height: 210,
  //                       width: 160,
  //                       fit: BoxFit.cover,

  //                       // width: double.infinity,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 6.0),
  //                     child: Text(
  //                       name,
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                       textScaler: MediaQuery.textScalerOf(context),
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: Row(
  //                       children: List.generate(5, (index) {
  //                         return Icon(
  //                           Icons.star,
  //                           size: 16,
  //                           color: index < rating ? Colors.amber : Colors.grey,
  //                         );
  //                       }),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: Text('$left Left',
  //                         style: TextStyle(color: Colors.grey)),
  //                   ),
  //                   Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Text(
  //                             '₹$price',
  //                             style: TextStyle(fontWeight: FontWeight.bold),
  //                           ),
  //                           Text(
  //                             '₹$oldPrice',
  //                             style: TextStyle(
  //                                 decoration: TextDecoration.lineThrough,
  //                                 color: Colors.grey,
  //                                 fontSize: 16),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.all(5.0),
  //                             child: Container(
  //                               height: 30,
  //                               width: 20,
  //                               child: MaterialButton(
  //                                 onPressed: () {
  //                                   // cartn++;
  //                                   // cartIds.add({'id': id, 'count': 1});
  //                                 },
  //                                 child: Icon(
  //                                   Icons.add_shopping_cart,
  //                                   size: 21,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  productCard2({
    required int id,
    required String name,
    required String rating,
    required int left,
    required String price,
    required String oldPrice,
    required String image,
    String? categoryN,
  }) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Card(
        elevation: 1,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BuyItem(
                adth: widget.adth,
                buyid: id,
              );
            }));
          },
          child: Container(
            width: 164,
            // height: 250,

            // color: Colors.white,
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
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.broken_image),

                          // width: double.infinity,
                          // height: 100,
                          height: 220,
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
                              if (!mounted)
                                return; // prevents calling setState if widget is disposed

                              setState(() {});
                            },
                          )),
                        ),
                        Positioned(
                          top: 1,
                          left: 1,
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                              padding: EdgeInsets.only(top: 10, left: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  // height: 30,

                                  color: Colors.black,
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(" NEW ",
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaler: MediaQuery.textScalerOf(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        categoryN!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                        textScaler: MediaQuery.textScalerOf(context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 5),
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
                                    "($rating)",
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
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      // padding: EdgeInsets.only(bottom: 5),
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
                          Text("+0")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // productCard2({
  //   required String name,
  //   required int rating,
  //   required int left,
  //   required double price,
  //   required double oldPrice,
  // }) {
  //   return Container(
  //     color: Colors.white,
  //     width: 130,
  //     margin: EdgeInsets.all(10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           color: Colors.white,
  //           width: 140,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(10),
  //             child: Image.asset(
  //               'assets/im.jpeg',
  //               fit: BoxFit.cover,
  //               width: double.infinity,
  //             ),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 6.0),
  //           child: Text(
  //             name,
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //             textScaler: MediaQuery.textScalerOf(context),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: Row(
  //             children: List.generate(5, (index) {
  //               return Icon(
  //                 Icons.star,
  //                 size: 16,
  //                 color: index < rating ? Colors.amber : Colors.grey,
  //               );
  //             }),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: Text('$left Left', style: TextStyle(color: Colors.grey)),
  //         ),
  //         Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Text(
  //                   '₹$price',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //                 Text(
  //                   '₹$oldPrice',
  //                   style: TextStyle(
  //                       decoration: TextDecoration.lineThrough,
  //                       color: Colors.grey,
  //                       fontSize: 16),
  //                 ),
  //                 Icon(
  //                   Icons.add_shopping_cart,
  //                   size: 21,
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // _buildPromoBanner() {
  //   return Container(
  //       color: Colors.amberAccent,
  //       child: ListView.builder(
  //         addRepaintBoundaries: true,
  //         controller: cntr,
  //         itemCount: 3,
  //         itemBuilder: (BuildContext context, int index) => Row(
  //           children: [
  //             productCard(
  //               name: 'Lamar Weaver',
  //               rating: 5,
  //               left: 755,
  //               price: 652,
  //               oldPrice: 746,
  //               id: 1,
  //             ),
  //             productCard(
  //               name: 'Lamar Weaver',
  //               rating: 5,
  //               left: 755,
  //               price: 652,
  //               oldPrice: 746,
  //               id: 1,
  //             ),
  //             productCard(
  //               name: 'Lamar Weaver',
  //               rating: 5,
  //               left: 755,
  //               price: 652,
  //               oldPrice: 746,
  //               id: 1,
  //             ),
  //             productCard(
  //               name: 'Lamar Weaver',
  //               rating: 5,
  //               left: 755,
  //               price: 652,
  //               oldPrice: 746,
  //               id: 1,
  //             ),
  //           ],
  //         ),
  //       ));
  // }

  _categoryBanner(int leng) {
    int ind = 0;
    int n = 4;

    if (leng == -1) {
      n = 2;
      ind = bannerData.length - 1;
    }
    return (loading && bannerData == null)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _checkConnection,
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              CarouselSlider.builder(
                // carouselController: v,
                // carouselController: _carouselController,
                itemCount: n,
                itemBuilder: (context, index, realIndex) {
                  int minn = 0;
                  if (leng == -1) {
                    minn = index + index;
                  }
                  String url = (bannerData.length > index)
                      ? bannerData[index + ind - minn]['desktop_thumbnail']
                          ['url']
                      : 'https://mtt-s3.s3.ap-south-1.amazonaws.com/1723189954707banner1-phone.webp';
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.broken_image),

                      width: double.infinity,
                      // height: 100,
                      fit: BoxFit.cover,
                    ),

                    //  Image.network(
                    //   url,
                    //   fit: BoxFit.cover,
                    //   width: double.infinity,
                    // ),
                  );
                },
                options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.9,
                  onPageChanged: (index, reason) =>
                      // prevents calling setState if widget is disposed

                      setState(() => activeIndex = index),
                ),
              ),
              const SizedBox(height: 16),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: n,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.orange,
                ),
                onDotClicked: (index) {
                  // xxx.animateToPage(index);
                },
              ),
              const SizedBox(height: 16),
            ],
          );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 48,
              width: 160,
              color: const Color.fromARGB(255, 200, 199, 194),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.star),
                  ),
                  Text("Top Picks")
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 48,
              width: 160,
              color: const Color.fromARGB(255, 200, 199, 194),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.trending_up),
                  ),
                  Text("New Arrivals"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSortFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIconWithText(Icons.swap_vert, "SORT BY"),
          _buildIconWithText(Icons.filter_list, "FILTER"),
        ],
      ),
    );
  }

  // Widget callcards() {
  //   // while (i != n) {
  //   //   callcards();
  //   // }
  //   if (i < n) {
  //     i++;
  //     return productCard(
  //       id: 1,
  //       name: 'Lamar Weaver',
  //       rating: 5,
  //       left: 755,
  //       price: 652,
  //       oldPrice: 746,
  //     );
  //   }
  //   return Container();
  // }

  // Widget _buildItemsGrid() {
  //   return Container(

  //       // width: BoxConstraints().maxWidth,
  //       child: Wrap(children: [
  //     callcards(),
  //     productCard2(
  //       name: 'Lamar Weaver',
  //       rating: 5,
  //       left: 755,
  //       price: 652,
  //       oldPrice: 746,
  //       id: 0,
  //     ),
  //     productCard2(
  //       name: 'Lamar Weaver',
  //       rating: 5,
  //       left: 755,
  //       price: 652,
  //       oldPrice: 746,
  //       id: 1,
  //     ),
  //     productCard2(
  //       name: 'Lamar Weaver',
  //       rating: 5,
  //       left: 755,
  //       price: 652,
  //       oldPrice: 746,
  //       id: 2,
  //     ),
  //     productCard2(
  //       name: 'Lamar Weaver',
  //       rating: 5,
  //       left: 755,
  //       price: 652,
  //       oldPrice: 746,
  //       id: 3,
  //     ),
  //   ]));
  // }

  productCard21({
    required int id,
    required String name,
    required String rating,
    required int left,
    required String price,
    required String oldPrice,
    required String image,
    required bool ok,
    String? categoryN,
  }) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        elevation: 1,
        child: Container(
          width: 164,
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
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 220,
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
                              if (!mounted)
                                return; // prevents calling setState if widget is disposed

                              setState(() {});
                            },
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          // textScaler: MediaQuery.textScalerOf(context),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        categoryN!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
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
                                Text("+0")
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

  Widget _buildItemsGridDom(int mxi) {
    List showitm = [];

    if (mxi == 2) {
      showitm = productData2i;
    } else if (mxi == 4) {
      showitm = productData4i;
    } else if (mxi == 6) {
      showitm = productData6i;
    } else {
      showitm = productData1;
    }

    int n = showitm.length;

    return (loading && showitm == null)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _checkConnection,
              ),
            ],
          )
        : Center(
            child: Wrap(children: [
              for (int i = 0; i < n; i++)
                productCard21(
                  name: (showitm.length > i) ? showitm[i]["name"] : "not found",
                  rating: "${showitm[i]["rating"] ?? 0}",
                  left: showitm[i]["variants"][0]["quantity"],
                  price: showitm[i]["variants"][0]["price"],
                  oldPrice: showitm[i]["variants"][0]["strike_price"],
                  id: showitm[i]["id"],
                  image: (showitm.length > i)
                      ? showitm[i]["thumbnail"]["url"]
                      : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                  ok: false,
                  categoryN: showitm[i]["category"]["name"],
                ),
            ]),
          );
  }

  // int? ni = ItemsId[0]['Id'];

  // Widget _GridAlsoLike() {
  //   return Container(
  //     height: 650,
  //     child: CupertinoScrollbar(
  //       child: ListView.builder(
  //           controller: cntr,
  //           scrollDirection: Axis.horizontal,
  //           itemCount: Items.length,
  //           itemBuilder: (BuildContext context, int index) => (index % 2 == 1)
  //               ? Container()
  //               : Column(children: [
  //                   productCard(
  //                       id: index,
  //                       name: '${Items[index]['title']}',
  //                       rating: 5,
  //                       left: 755,
  //                       price: 652,
  //                       oldPrice: 746,
  //                       image: '${Items[index]['image']}'),
  //                   (9 <= index + 1)
  //                       ? Container()
  //                       : productCard(
  //                           id: index + 1,
  //                           name: '${Items[index + 1]['title']}',
  //                           rating: 5,
  //                           left: 755,
  //                           price: 652,
  //                           oldPrice: 746,
  //                           image: '${Items[index + 1]['image']}',
  //                         ),
  //                 ])),
  //     ),
  //   );
  // }

  Widget _buildIconWithText(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 5),
        Text(label),
      ],
    );
  }
}
