import 'package:template/main.dart';
import 'package:template/pages/category1.dart';
import 'package:template/pages/searchPage.dart';
import 'package:template/pages/topPage.dart';
import 'package:template/pages/buyItem.dart';
import 'package:template/pages/cartdirect.dart';
import 'package:template/usls/scanner.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/usls/notification.dart';
import 'package:template/pages/profile.dart';
import 'package:template/usls/video.dart';
import 'package:template/usls/collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class MyHome extends StatefulWidget {
  final Color adth;
  final int admin;

  MyHome({required this.adth, required this.admin});
  @override
  State<MyHome> createState() => _MyHomeState();
}

int n = 5;

int i = 0;
int activeIndex = 0;
bool ok = true;

class _MyHomeState extends State<MyHome> {
  late ScrollController _scrollController;

  final txcont = TextEditingController();

  @override
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

  String load = "Loading";

  Future<void> fetchProducts() async {
    try {
      if (productData1.length == 0) {
        try {
          final responseBanner1 = await http.get(
            Uri.parse(
              BASE_URL +
                  "products", //?&&pagination[page]=1&pagination[pageSize]=14",
            ),
          );

          if (responseBanner1.statusCode == 200) {
            final jsonBody = json.decode(responseBanner1.body);

            productData1 = jsonBody["data"];
            TopData1 = productData1;
            colii[0] = (List.filled(productData1.length, 0));
          } else {
            print("Failed to load banner data");
            if (!mounted) return;
            load = "Server Error!";
            setState(() {});
          }
        } catch (e) {
          print(e);
          if (!mounted) return;
          load = "Network Error!";
          setState(() {});
        }
      }

      ok = false;

      if (bannerData.length == 0) {
        final responseBanner = await http.get(
          Uri.parse("${BASE_URL}store-banners"),
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

          if (!mounted) return;
          if (!mounted)
            return; // prevents calling setState if widget is disposed

          setState(() {});
        } else {
          print("Failed to load banner data");
          if (!mounted) return;
          load = "Server Error!";
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      load = "Network Error!";
      setState(() {});
    }

    try {
      final res = await http.get(
        Uri.parse('${BASE_URL}store-users/me'),
        headers: {'Authorization': "Bearer ${userToken}"},
      );

      if (res.statusCode == 200) {
        print("success userrrrrrrrrrrrrrrrrrrr");
        // userData = json.decode(res.body)["data"];

        userData = json.decode(res.body)["data"];
        isPremiium = (userData["isPremium"] == true);
        userName = userData["name"];
        ispremi = isPremiium;
        print(userData["isPremium"]);
        adrss = userData["addresses"].length;
        wallet = userData["wallet_balance"];
        userid = userData["id"];

        if (!mounted) {
          return;
        }
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
        print(userData);
      } else {
        print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
        if (!mounted) return;
        load = "Server Error!";
        setState(() {});
        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp(isLoggedIn: false)),
          (context) => false,
        );
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      load = "Network Error!";
      setState(() {});
    }
  }

  void initState() {
    super.initState();
    // fetchProducts();
    if (!mounted) return;
    load = "Loading";
    setState(() {});
    _checkConnection();
    // _getrand4();
    _scrollController = ScrollController();

    fetchProducts();

    if (!mounted) {
      return;
    }
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  _getrand4() async {
    try {
      if (productData4i.length == 0) {
        final rs = await http.get(Uri.parse(BASE_URL + "products/4/random"));

        if (rs.statusCode == 200) {
          productData4i = json.decode(rs.body)["data"];
          colii[2] = (List.filled(productData4i.length, 0));
          print("success to get random products");
        } else {
          print("failed to get random products");
          if (!mounted) return;
          load = "Server Error!";
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      load = "Network Error!";
      setState(() {});
    }
    try {
      if (productData2i.length == 0) {
        final rs = await http.get(Uri.parse(BASE_URL + "products/2/random"));

        if (rs.statusCode == 200) {
          productData2i = json.decode(rs.body)["data"];
          colii[1] = (List.filled(productData2i.length, 0));
          print("success to get random products");
        } else {
          print("failed to get random products");
          if (!mounted) return;
          load = "Server Error!";
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      load = "Network Error!";
      setState(() {});
    }
    try {
      if (productData13i.length == 0) {
        final rs = await http.get(Uri.parse(BASE_URL + "products/12/random"));

        if (rs.statusCode == 200) {
          productData13i = json.decode(rs.body)["data"];
          print("success to get random products");
        } else {
          print("failed to get random products");
          if (!mounted) return;
          load = "Server Error!";
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      load = "Network Error!";
      setState(() {});
    }
    try {
      if (productData6i.length == 0) {
        final rs = await http.get(Uri.parse(BASE_URL + "products/6/random"));

        if (rs.statusCode == 200) {
          productData6i = json.decode(rs.body)["data"];
          colii[3] = (List.filled(productData6i.length, 0));
          print("success to get random products");
        } else {
          print("failed to get random products");
          if (!mounted) return;
          load = "Server Error!";
          setState(() {});
        }
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      load = "Network Error!";
      setState(() {});
    }
  }

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

  Future<void> _refreshData() async {
    if (!mounted) return;
    await Future.delayed(Duration(milliseconds: 100));
    if (!mounted) return;

    // Simulate network call
    // prevents calling setState if widget is disposed
    _checkConnection();
    if (!mounted) return;
    load = "Loading";
    setState(() {});
  }

  int pp = 1;

  Future<void> _checkConnection() async {
    final result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.none) {
      loading = true;
      if (!mounted) return;
      load = "No Network !";
      setState(() {});
    } else {
      loading = false;
      if (!mounted) return;
      load = "Loading";
      setState(() {});
      fetchProducts();
      // _checkConnection();
      _getrand4();
    }
  }

  @override
  Widget build(BuildContext context) {
    int nfp = productData13i.length;

    int nfpp = nfp ~/ 2;

    if (nfp != nfpp * 2) {
      nfpp = nfpp + 1;
    }

    return WillPopScope(
      onWillPop: () async {
        // Show the confirmation dialog
        final shouldExit = await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
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
      child:
          (productData1.isEmpty)
              ? Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text(
                          (load == "Loading") ? "" : load,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                (load == "Loading") ? Colors.black : Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (!mounted) return;
                            load = "Loading";
                            setState(() {});
                            // _getProfileData();
                          },
                          icon:
                              (load == "Loading")
                                  ? RefreshProgressIndicator()
                                  : Icon(Icons.refresh),
                          //         Text(
                          //   load,
                          //   style: TextStyle(
                          //     fontSize: 16,

                          //     // color: widget.adth,
                          //   ),
                          // ),
                          // IconButton(
                          //   onPressed: () {
                          //     if (!mounted) return;
                          //     load = "Loading";
                          //     setState(() {});
                          //     // _getProfileData();
                          //   },
                          //   icon:
                          // ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  surfaceTintColor: Colors.white,

                  title: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://mtt-s3.s3.ap-south-1.amazonaws.com/1744179549972Adobe%20Express%20-%20file.WEBP',
                      placeholder: (context, url) => Icon(Icons.image),
                      errorWidget: (context, url, error) => Icon(Icons.image),

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
                        // _openCamera();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ScannerQrrr(adth: widget.adth),
                          ),
                        );
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
                              builder:
                                  (context) =>
                                      CollectionPage(adth: widget.adth),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    NotificationPage(adth: widget.adth),
                          ),
                        );
                      },
                      icon: Icon(Icons.notifications, color: Colors.white),
                    ),
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
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              // Search bar
                              SizedBox(height: 15),
                              MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              SearchPage(adth: widget.adth),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: 50,
                                      color: const Color.fromARGB(
                                        255,
                                        245,
                                        243,
                                        243,
                                      ),
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
                                                fontSize: 15,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Text(qrTexts),
                              SizedBox(height: 10),

                              _categoryBanner(4),

                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     left: 15.0,
                              //     right: 15,
                              //     bottom: 10,
                              //   ),
                              //   child: Column(
                              //     children: [
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "Features Brand",
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.bold,
                              //             ),
                              //           ),
                              //           GestureDetector(
                              //             onTap: () {
                              //               Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                   builder:
                              //                       (context) => SerchTopPage(
                              //                         searchpro: "",
                              //                         adth: widget.adth,
                              //                         index: -1,
                              //                       ),
                              //                 ),
                              //               );
                              //             },
                              //             child: GestureDetector(
                              //               onTap: () {
                              //                 Navigator.push(
                              //                   context,
                              //                   MaterialPageRoute(
                              //                     builder:
                              //                         (context) => SerchTopPage(
                              //                           searchpro: "",
                              //                           adth: widget.adth,
                              //                           index: -1,
                              //                         ),
                              //                   ),
                              //                 );
                              //               },
                              //               child: Text(
                              //                 "view more",
                              //                 style: TextStyle(
                              //                   color: Colors.grey,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              // (loading)
                              //     ? Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         const Icon(
                              //           Icons.wifi_off,
                              //           size: 80,
                              //           color: Colors.grey,
                              //         ),
                              //         const SizedBox(height: 16),
                              //         const Text(
                              //           "No Internet Connection",
                              //           style: TextStyle(fontSize: 20),
                              //         ),
                              //         const SizedBox(height: 20),
                              //         IconButton(
                              //           icon: Icon(Icons.refresh),
                              //           onPressed: _checkConnection,
                              //         ),
                              //       ],
                              //     )
                              //     : Container(),

                              // Container(
                              //   margin: EdgeInsets.all(10),
                              //   padding: const EdgeInsets.only(
                              //     left: 4.0,
                              //     right: 4,
                              //     bottom: 5,
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       for (int i = 0; i < 4; i++)
                              //         GestureDetector(
                              //           onTap: () {
                              //             Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder:
                              //                     (context) => SerchTopPage(
                              //                       searchpro: "",
                              //                       adth: widget.adth,
                              //                       index: -1,
                              //                     ),
                              //               ),
                              //             );
                              //           },
                              //           child: Column(
                              //             children: [
                              //               ClipRRect(
                              //                 borderRadius:
                              //                     BorderRadius.circular(12),
                              //                 child: CachedNetworkImage(
                              //                   imageUrl:
                              //                       "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",

                              //                   placeholder:
                              //                       (context, url) => Center(
                              //                         child: Icon(Icons.image),
                              //                       ),
                              //                   errorWidget:
                              //                       (context, url, error) =>
                              //                           Icon(Icons.image),

                              //                   // width: double.infinity,
                              //                   // height: 100,
                              //                   width: 78,
                              //                   fit: BoxFit.cover,
                              //                   // fit: BoxFit.cover,
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(
                              //                   8.0,
                              //                 ),
                              //                 child: Text(
                              //                   "Hindustan Factory",
                              //                   style: TextStyle(
                              //                     fontSize: 7,
                              //                     fontWeight: FontWeight.bold,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15,
                                  bottom: 5,
                                  top: 15,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Features Products",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
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
                                          child: Text(
                                            "view more",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 10),

                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                  right: 15,
                                  bottom: 5,
                                ),
                                child:
                                    (loading && productData13i == null)
                                        ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.wifi_off,
                                              // size: 80,
                                              color: Colors.grey,
                                            ),
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
                                          height: 246,
                                          child: ListView.builder(
                                            // shrinkWrap: true,
                                            // physics: NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: nfpp,
                                            itemBuilder: (context, index) {
                                              int xx = index * 2;
                                              int yy = (index * 2) + 1;
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder:
                                                              (
                                                                context,
                                                              ) => BuyItem(
                                                                adth:
                                                                    widget.adth,
                                                                buyid:
                                                                    (productData13i.length >
                                                                            xx)
                                                                        ? productData13i[xx]["id"]
                                                                        : -1,
                                                              ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 80,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  right: 5.0,
                                                                ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    12,
                                                                  ),
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                    (productData13i.length >
                                                                            xx)
                                                                        ? productData13i[xx]["thumbnail"]["url"]
                                                                        : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",

                                                                placeholder:
                                                                    (
                                                                      context,
                                                                      url,
                                                                    ) => Center(
                                                                      child: Icon(
                                                                        Icons
                                                                            .image,
                                                                      ),
                                                                    ),
                                                                errorWidget:
                                                                    (
                                                                      context,
                                                                      url,
                                                                      error,
                                                                    ) => Icon(
                                                                      Icons
                                                                          .image,
                                                                    ),

                                                                width:
                                                                    double
                                                                        .infinity,
                                                                // height: 100,
                                                                height: 90,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                                // fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  8.0,
                                                                ),
                                                            child: Text(
                                                              (productData13i
                                                                          .length >
                                                                      xx)
                                                                  ? productData13i[xx]["name"]
                                                                  : "Laptop & pc ausdhsjj s sjs j ajaj aa ",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 9,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
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
                                                                  (
                                                                    context,
                                                                  ) => BuyItem(
                                                                    adth:
                                                                        widget
                                                                            .adth,
                                                                    buyid:
                                                                        (productData13i.length >
                                                                                yy)
                                                                            ? productData13i[yy]["id"]
                                                                            : -1,
                                                                  ),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 80,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.only(
                                                                      right:
                                                                          5.0,
                                                                    ),
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        12,
                                                                      ),
                                                                  child: CachedNetworkImage(
                                                                    imageUrl:
                                                                        (productData13i.length >
                                                                                yy)
                                                                            ? productData13i[yy]["thumbnail"]["url"]
                                                                            : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                                                                    placeholder:
                                                                        (
                                                                          context,
                                                                          url,
                                                                        ) => Center(
                                                                          child: Icon(
                                                                            Icons.image,
                                                                          ),
                                                                        ),
                                                                    errorWidget:
                                                                        (
                                                                          context,
                                                                          url,
                                                                          error,
                                                                        ) => Icon(
                                                                          Icons
                                                                              .image,
                                                                        ),

                                                                    width:
                                                                        double
                                                                            .infinity,
                                                                    // height: 100,
                                                                    height: 90,
                                                                    fit:
                                                                        BoxFit
                                                                            .cover,
                                                                    // fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                      8.0,
                                                                    ),
                                                                child: Text(
                                                                  (productData13i
                                                                              .length >
                                                                          yy)
                                                                      ? productData13i[yy]["name"]
                                                                      : "Laptop & pc ausdhsjj s sjs j ajaj aa ",
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 9,
                                                                  ),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Domenstic Shipping",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              _buildItemsGridDom(2),

                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                  bottom: 20,
                                ),
                                child: GestureDetector(
                                  onTap: () {
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
                                  child: Center(
                                    child: Text(
                                      "View More",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Trending Products",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                        left: 2,
                                      ),
                                      child:
                                          (loading && productData6i == null)
                                              ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.wifi_off,
                                                    size: 80,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(height: 16),
                                                  const Text(
                                                    "No Internet Connection",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  IconButton(
                                                    icon: Icon(Icons.refresh),
                                                    onPressed: _checkConnection,
                                                  ),
                                                ],
                                              )
                                              : Container(
                                                height: 335,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,

                                                  itemCount:
                                                      productData6i.length,
                                                  itemBuilder:
                                                      (
                                                        BuildContext context,
                                                        int i,
                                                      ) => Padding(
                                                        padding: EdgeInsets.all(
                                                          3,
                                                        ),
                                                        child: productCard21(
                                                          name:
                                                              (productData6i
                                                                          .length >
                                                                      i)
                                                                  ? productData6i[i]["name"]
                                                                  : "not found",
                                                          index: i,
                                                          rating:
                                                              "${productData6i[i]["rating"] ?? "0"}",
                                                          left:
                                                              productData6i[i]["variants"][0]["quantity"],
                                                          price:
                                                              productData6i[i]["variants"][0]["price"],
                                                          oldPrice:
                                                              productData6i[i]["variants"][0]["strike_price"],
                                                          id:
                                                              productData6i[i]["id"],
                                                          coli: 3,
                                                          image:
                                                              (productData6i
                                                                          .length >
                                                                      i)
                                                                  ? productData6i[i]["thumbnail"]["url"]
                                                                  : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                                                          categoryN:
                                                              productData6i[i]["category"]["name"],
                                                          ok: false,
                                                        ), //),
                                                      ), // ok: false,
                                                ),
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
                                    Text(
                                      "Deals for you",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              _buildItemsGridDom(4),

                              _categoryBanner(-1),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                ),
                                child: _buildItemsGridDom(-1),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
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
                        height: 55,
                        width: 60,
                        child: GestureDetector(
                          // padding: EdgeInsets.all(0),
                          onTap: () {},
                          child: Column(
                            children: [
                              Icon(
                                Icons.home_outlined,
                                size: 21,
                                color: widget.adth,
                              ),
                              Text(
                                style: TextStyle(
                                  color: widget.adth,
                                  fontSize: 13,
                                ),
                                'Home',
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
                                    (context) => Cart1Page(
                                      adth: widget.adth,
                                      admin: widget.admin,
                                    ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.dashboard_outlined,
                                color: b1,
                                size: 21,
                              ),
                              Text(
                                'Category',
                                style: TextStyle(color: b1, fontSize: 13),
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
                                    (context) =>
                                        VideoPage(admin: 2, adth: widget.adth),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Icon(Icons.ondemand_video, color: b1, size: 21),
                              Text(
                                style: TextStyle(color: b1, fontSize: 13),
                                'Shorts',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
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
                                        (context) => CartDirPage(
                                          admin: 3,
                                          adth: widget.adth,
                                        ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: b1,
                                    size: 21,
                                  ),
                                  Text(
                                    style: TextStyle(color: b1, fontSize: 13),
                                    'Cart',
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
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
                                    (context) => ProfilePage(
                                      adth: widget.adth,
                                      admin: widget.admin,
                                    ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Icon(Icons.person_outline, color: b1, size: 21),
                              Text(
                                style: TextStyle(color: b1, fontSize: 13),
                                'Profile',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //
                  // ],
                ),
              ),
    );
  }

  // productCard2({
  //   required int id,
  //   required String name,
  //   required String rating,
  //   required int left,
  //   required String price,
  //   required String oldPrice,
  //   required String image,
  //   String? categoryN,
  // }) {
  //   return Padding(
  //     padding: EdgeInsets.all(10.0),
  //     child: Card(
  //       elevation: 1,
  //       child: GestureDetector(
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) {
  //                 return BuyItem(adth: widget.adth, buyid: id);
  //               },
  //             ),
  //           );
  //         },
  //         child: Container(
  //           width: 164,
  //           // height: 250,

  //           // color: Colors.white,
  //           child: ClipRRect(
  //             borderRadius: BorderRadius.circular(15),
  //             child: Container(
  //               color: Colors.white,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Stack(
  //                     children: [
  //                       CachedNetworkImage(
  //                         imageUrl: image,
  //                         placeholder: (context, url) => Icon(Icons.image),
  //                         errorWidget:
  //                             (context, url, error) => Icon(Icons.image),

  //                         // width: double.infinity,
  //                         // height: 100,
  //                         height: 220,
  //                         fit: BoxFit.cover,
  //                       ),
  //                       // Image.network(
  //                       //   '$image',
  //                       //   // height: 110,
  //                       //   fit: BoxFit.cover,

  //                       //   // width: double.infinity,
  //                       // ),
  //                       Positioned(
  //                         top: 1,
  //                         right: 1,
  //                         // ignore: avoid_unnecessary_containers
  //                         child: Container(
  //                           child: IconButton(
  //                             icon: Icon(
  //                               (favIds.contains(id))
  //                                   ? Icons.favorite
  //                                   : Icons.favorite_border_outlined,
  //                               color:
  //                                   (favIds.contains(id)) ? Colors.red : null,
  //                             ),
  //                             onPressed: () {
  //                               // _getans(id);
  //                               (favIds.contains(id))
  //                                   ? {favIds.remove(id)}
  //                                   : favIds.add(id);
  //                               if (!mounted)
  //                                 return; // prevents calling setState if widget is disposed

  //                               setState(() {});
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                       Positioned(
  //                         top: 1,
  //                         left: 1,
  //                         // ignore: avoid_unnecessary_containers
  //                         child: Container(
  //                           padding: EdgeInsets.only(top: 10, left: 5),
  //                           child: ClipRRect(
  //                             borderRadius: BorderRadius.circular(12),
  //                             child: Container(
  //                               // height: 30,
  //                               color: Colors.black,
  //                               padding: const EdgeInsets.all(5.0),
  //                               child: Text(
  //                                 " NEW ",
  //                                 style: TextStyle(
  //                                   fontSize: 9,
  //                                   color: Colors.white,
  //                                   fontWeight: FontWeight.bold,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   SizedBox(height: 5),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                     child: Text(
  //                       name,
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                       textScaler: MediaQuery.textScalerOf(context),
  //                       overflow: TextOverflow.ellipsis,
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //                     child: Text(
  //                       categoryN!,
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 10,
  //                       ),
  //                       textScaler: MediaQuery.textScalerOf(context),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.symmetric(
  //                       horizontal: 12.0,
  //                       vertical: 5,
  //                     ),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Icon(
  //                                   Icons.star,
  //                                   color: Colors.amberAccent,
  //                                   size: 15,
  //                                 ),
  //                                 Text(
  //                                   "($rating)",
  //                                   style: TextStyle(
  //                                     fontSize: 12,
  //                                     color: Colors.grey,
  //                                   ),
  //                                 ),
  //                                 Text(
  //                                   "250k+",
  //                                   style: TextStyle(
  //                                     fontSize: 12,
  //                                     color: Colors.grey,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Text(
  //                               "₹ $price",
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 12,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         IconButton(
  //                           onPressed: () {},
  //                           icon: Icon(
  //                             Icons.add_circle_rounded,
  //                             color: widget.adth,
  //                             size: 30,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     margin: EdgeInsets.symmetric(horizontal: 15),
  //                     // padding: EdgeInsets.only(bottom: 5),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         CircleAvatar(
  //                           radius: 10,
  //                           backgroundColor: CupertinoColors.systemYellow,
  //                         ),
  //                         CircleAvatar(
  //                           radius: 10,
  //                           backgroundColor: Colors.deepPurpleAccent,
  //                         ),
  //                         CircleAvatar(radius: 10, backgroundColor: Colors.red),
  //                         CircleAvatar(
  //                           radius: 10,
  //                           backgroundColor: Colors.brown,
  //                         ),
  //                         Text("+0"),
  //                       ],
  //                     ),
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
            IconButton(icon: Icon(Icons.refresh), onPressed: _checkConnection),
          ],
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.all(0),
              padding: const EdgeInsets.all(0.0),
              child: CarouselSlider.builder(
                // carouselController: v,
                // carouselController: _carouselController,
                itemCount: n,
                itemBuilder: (context, index, realIndex) {
                  int minn = 0;
                  if (leng == -1) {
                    minn = index + index;
                  }
                  String url =
                      (bannerData.length > index)
                          ? bannerData[index +
                              ind -
                              minn]['desktop_thumbnail']['url']
                          : 'https://mtt-s3.s3.ap-south-1.amazonaws.com/1723189954707banner1-phone.webp';
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) => Icon(Icons.image),
                      errorWidget: (context, url, error) => Icon(Icons.image),

                      width: double.infinity,
                      // height: 200,
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
                  height: 180,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.92,
                  onPageChanged:
                      (index, reason) =>
                      // prevents calling setState if widget is disposed
                      setState(() => activeIndex = index),
                ),
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
    required int index,
    required int coli,
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
                              // color: Colors.white,
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
                        categoryN!,
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
                                    "($rating)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  // Text(
                                  //   "250k+",
                                  //   style: TextStyle(
                                  //     fontSize: 12,
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
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
                              HometoCart(id);
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
                    (true)
                        ? Container()
                        : Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              for (
                                int i = 0;
                                i < showitm[index]["variants"].length && i < 4;
                                i++
                              )
                                GestureDetector(
                                  // padding: EdgeInsets.all(0),
                                  onTap: () {
                                    colii[coli][index] = i;
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    decoration:
                                        (colii[coli][index] != i)
                                            ? BoxDecoration()
                                            : BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: adth,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: HexColor(
                                        showitm?[index]?["variants"]?[i]?['primary_attribute']?['hex_code'] ??
                                            "#B74093",
                                      ),
                                      child: Text(
                                        "${showitm?[index]?["variants"]?[i]?['name'] ?? ""}",
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ),
                                  ),
                                ),

                              // GestureDetector(
                              //   onTap: () {
                              //     colii[coli][index] = 1;
                              //     setState(() {});
                              //   },
                              //   child: Container(
                              //     decoration:
                              //         (colii[coli][index] != 1)
                              //             ? BoxDecoration()
                              //             : BoxDecoration(
                              //               border: Border.all(width: 2),
                              //               borderRadius: BorderRadius.circular(
                              //                 20,
                              //               ),
                              //             ),
                              //     child: CircleAvatar(
                              //       radius: 10,
                              //       backgroundColor: Colors.deepPurpleAccent,
                              //     ),
                              //   ),
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     colii[coli][index] = 2;
                              //     setState(() {});
                              //     // setState(() {});
                              //   },
                              //   child: Container(
                              //     decoration:
                              //         (colii[coli][index] != 2)
                              //             ? BoxDecoration()
                              //             : BoxDecoration(
                              //               border: Border.all(width: 2),
                              //               borderRadius: BorderRadius.circular(
                              //                 20,
                              //               ),
                              //             ),
                              //     child: CircleAvatar(
                              //       radius: 10,
                              //       backgroundColor: Colors.red,
                              //     ),
                              //   ),
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     colii[coli][index] = 3;
                              //     setState(() {});
                              //   },
                              //   child: Container(
                              //     decoration:
                              //         (colii[coli][index] != 3)
                              //             ? BoxDecoration()
                              //             : BoxDecoration(
                              //               border: Border.all(width: 2),
                              //               borderRadius: BorderRadius.circular(
                              //                 20,
                              //               ),
                              //             ),
                              //     child: CircleAvatar(
                              //       radius: 10,
                              //       backgroundColor: Colors.brown,
                              //     ),
                              //   ),
                              //   //
                              //   //
                              //   //
                              // ),
                              if (showitm[index]["variants"].length > 4)
                                Text(
                                  "+${showitm[index]["variants"].length - 4}",
                                ),
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

  List showitm = [];

  Widget _buildItemsGridDom(int mxi) {
    List cco = [];
    int colnu = 0;
    showitm = productData1;

    if (mxi == 2) {
      showitm = productData2i;
      cco = colii[1];
      colnu = 1;
    } else if (mxi == 4) {
      showitm = productData4i;
      colnu = 2;
      cco = colii[2];
    } else if (mxi == 6) {
      showitm = productData6i;
      colnu = 3;

      cco = colii[3];
    } else {
      showitm = productData1;
      colnu = 0;
      cco = colii[0];
    }

    // print(showitm[i]["variants"]);

    int n = showitm.length;

    return (loading && showitm == null)
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            IconButton(icon: Icon(Icons.refresh), onPressed: _checkConnection),
          ],
        )
        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.53,
              // mainAxisSpacing: 5,
              // crossAxisSpacing: 5,
            ),
            itemCount: n,
            itemBuilder: (context, i) {
              // print(
              //   showitm?[i]?["variants"]?[0]?['primary_attribute']?['hex_code'],
              // );
              // print(showitm?[i]?["variants"]?[0]);
              return productCard21(
                name: (showitm.length > i) ? showitm[i]["name"] : "not found",
                rating: "${showitm[i]["rating"] ?? 0}",
                left: showitm[i]["variants"][colii[colnu][i]]["quantity"],
                price: showitm[i]["variants"][colii[colnu][i]]["price"],
                oldPrice:
                    showitm[i]["variants"][colii[colnu][i]]["strike_price"],
                id:
                    // showitm[i]["variants"][colii[colnu][i]]["id"] ??
                    // 0,
                    showitm[i]["id"],
                index: i,
                image:
                    (showitm.length > i)
                        ? showitm[i]["thumbnail"]["url"]
                        : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                ok: false,
                categoryN: showitm[i]["category"]["name"],
                coli: colnu,
              );
            },
          ),
        );
  }

  Widget _buildIconWithText(IconData icon, String label) {
    return Row(
      children: [Icon(icon, size: 20), SizedBox(width: 5), Text(label)],
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor; // Add FF for full opacity if not provided
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
