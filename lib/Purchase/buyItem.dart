// ignore: file_names
import 'dart:convert';
import 'dart:io';

import 'package:Template/Purchase/cartdirect.dart';
import 'package:Template/deepPage/premium.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/profilePages/addr.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:url_laucher/url_launcher.dart';

void copyText(String text) {
  Clipboard.setData(ClipboardData(text: text));
  print("✅ Text copied: $text");
}

class BuyItem extends StatefulWidget {
  final Color adth;
  final int buyid;

  // ignore: use_key_in_widget_constructors
  const BuyItem({required this.adth, required this.buyid});

  @override
  State<BuyItem> createState() => _BuyItemState();
}

String msg = "Product adding in process";

int total = 0;

bool ok = true;

class _BuyItemState extends State<BuyItem> {
  String shareText1 = 'Check out this awesome image!';
  Future<void> shareNetworkImageWithText() async {
    final imageUrl = "$MainPhoto"; // Replace with your image URL
    final shareText = shareText1;

    try {
      // Step 1: Download image bytes
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Step 2: Save to temp file
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/shared_image.jpg');
        await file.writeAsBytes(response.bodyBytes);

        // Step 3: Share
        await Share.shareXFiles(
          [XFile(file.path)],
          text: shareText,
        );
      } else {
        throw Exception('Failed to download image');
      }
    } catch (e) {
      print("Error sharing: $e");
    }
  }

  Future<void> _shareImageAndText() async {
    // 1. Load image from assets or network (here: from assets)
    final byteData = await rootBundle.load('assets/shirt.jpg');

    // 2. Save it to a temporary file
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/shared_image.jpg');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // 3. Share the image and text
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Check out this image!',
    );
  }

  dialogEnquire(String sta) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(msg ?? "You need to be a premium user!"),
                  )),
                ),
                (!premiii)
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: widget.adth, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PremiumPage(
                                              adth: widget.adth,
                                            )));
                              },
                              child: Text("Upgrade Now")),
                        ),
                      )
                    : Container(),
              ],
            ));
  }

  final cntr = TextEditingController();

  // _AddCardDialog() {
  //   cntr.text = "1";
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     CircleAvatar(
  //                       radius: 10,
  //                       backgroundColor: ,,
  //                     ),
  //                     TextField(
  //                       textAlign: TextAlign.center,
  //                       smartDashesType: null,
  //                       controller: cntr,
  //                       keyboardType: TextInputType.number,
  //                       decoration: InputDecoration(
  //                         focusedBorder: InputBorder.none,
  //                         enabledBorder: InputBorder.none,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 MaterialButton(
  //                   onPressed: () {
  //                     if (cntr.text.length != 0) {
  //                       if (cartIds.indexOf(widget.buyid) == -1) {
  //                         cartn++;

  //                         cartIds.add(widget.buyid);
  //                         cartCnts.add(int.parse(cntr.text));
  //                       } else {
  //                         cartCnts[cartIds.indexOf(widget.buyid)] +=
  //                             int.parse(cntr.text);
  //                       }
  //                       Navigator.pop(context);
  //                       Navigator.push(
  //                           context,
  //                           MaterialPageRoute(
  //                               builder: (context) =>
  //                                   CartDirPage(adth: widget.adth)));

  //                       // Navigator.pop(context);
  //                     }
  //                   },
  //                   child: Text("Submit"),
  //                 )
  //               ],
  //             ),
  //           ));
  // }

  _sizes(int indd) {
    deconi = indd;
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  _vars(int indd) {
    decVarn = indd;

    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  bool dodoit = true;
  List itemsTop = List.from(productData1);
  dynamic buyItemData = {};

  Future<void> _getAllItemData() async {
    // TopData1 = [];
    // doit = false;
    // int ind = widget.index;
    itemsTop = [];
    try {
      final res =
          await http.get(Uri.parse("${BASE_URL}products/${widget.buyid}"));
      // final res2 = await http.get(Uri.parse("https://hindustanapi.mtlapi.socialseller.in/api/subcategories"));

      if (res.statusCode == 200) {
        print("success mil gaya buyyyy proddduduuduududu");

        itemsTop = json.decode(res.body)["data"]["randomProducts"];
        buyItemData = json.decode(res.body)["data"]["product"];
        MainPhoto =
            json.decode(res.body)["data"]["product"]['thumbnail']["url"];
        // print(buyItemData);

        if (!mounted) {
          return;
        }
        if (!mounted) return; // prevents calling setState if widget is disposed

        setState(() {});
      } else {
        print("failure");
      }
    } catch (e) {
      print(e);
    }
  }

  bool showDetails = false;
  bool showShopInfo = false;
  bool showSupport = false;

  int decVarn = 0;

  Decoration decpho = BoxDecoration();
  int phoin = -1;

  // ignore: non_constant_identifier_names
  String MainPhoto = "";

  _photon(int index) {
    phoin = index;

    MainPhoto = buyItemData['gallery'][index]['url'] ?? null;

    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  bool premiii = false;

  Future<void> _addtoCart(int id, int qu) async {
    try {
      //     final req = await http.post(
      //   Uri.parse("${BASE_URL}cart/add"),
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': "Bearer token", // Replace with actual token
      //   },
      //   body: jsonEncode({
      //     "VariantId": id,
      //     "quantity": qu,
      //   }),
      // );

      final req = await http.post(Uri.parse("${BASE_URL}cart/add"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': "Bearer ${userToken}",
          },
          body: jsonEncode({"VariantId": id, "quantity": qu}));

      if (req.statusCode == 200) {
        print(jsonDecode(req.body)["message"]);
        print("jsdjjhdjdjjdjdjjd  ho gyayyaya");

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartDirPage(
                      adth: widget.adth,
                      admin: 1,
                    )));
      } else {
        print("not added to cart... abbebebebbhhdshdhhdhnananannanan");
      }
    } catch (e) {
      print(e);
      print("jdjdjjdjdjjdjjd");
    }
  }

  Decoration deco = BoxDecoration();
  int deconi = 1;

  // int productIndex = -1;

  // getIndexProduct() {
  //   ok = false;
  //   for (int i = 0; i < productData1.length; i++) {
  //     if (productData1[i]['id'] == widget.buyid) {
  //       productIndex = i;
  //       MainPhoto = productData1[i]['thumbnail']['url'];
  //       return;
  //     }
  //   }
  // }

  void initState() {
    super.initState();

    // if (productIndex == -1) {
    //   getIndexProduct();
    // }

    _getAllItemData();

    if (!mounted) {
      return;
    }

    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  Future<void> _getbookedproduct() async {
    if (!premiii) {
      msg =
          "You are not a Premium user, please upgrade your plan to book this product.";
    }
    try {
      final req = await http.post(
        Uri.parse("${BASE_URL}productBooking/book"),
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
        body: jsonEncode({
          "userId": 1,
          "productId": widget.buyid,
          "variantId": widget.buyid,
          "productQuantity": 2,
          "booking_price": 150
        }),
      );

      if (req.statusCode == 201) {
        msg = "Product added to cart successfully.";
      } else if (req.statusCode == 200) {
        msg = "Product already added to cart.";
      } else {
        msg = "Product not added to cart. Try again.";
      }

      if (!mounted) return;

      if (!mounted) return; // prevents calling setState if widget is disposed

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getdwlodmainpic() async {
    try {
      final dio = Dio();

      final response = await dio.get(
        '${MainPhoto}', // your API or file URL
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      // Get local path
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/hindustanproduct${widget.buyid}.png";

      // Save to file
      File file = File(filePath);
      await file.writeAsBytes(response.data);

      print("✅ File downloaded to: $filePath");

      // Optionally open the file
      OpenFile.open(filePath);

      // final res = await http.get(
      //   Uri.parse('${BASE_URL}orders/${widget.orderid}/invoice'),
      // headers: {
      //   'Authorization': "Bearer ${userToken}",
      // }
      // );
    } catch (e) {
      print(e);
    }
  }

  Decoration decoVar = BoxDecoration();
  @override
  Widget build(BuildContext context) {
    decpho = BoxDecoration(
      border: Border.all(color: widget.adth),
      borderRadius: BorderRadius.circular(12),
    );
    deco = BoxDecoration(
      border: Border.all(color: widget.adth),
      borderRadius: BorderRadius.circular(5),
    );
    decoVar = BoxDecoration(
      border: Border.all(color: widget.adth),
      borderRadius: BorderRadius.circular(7),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: (MainPhoto == "")
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 280,
                        child: CachedNetworkImage(
                          imageUrl: (MainPhoto != null)
                              ? MainPhoto
                              : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg",
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.broken_image),

                          // width: double.infinity,
                          // height: 100,
                          // fit: BoxFit.cover,
                        ),

                        // Image.network((productIndex != -1)
                        //     ? MainPhoto
                        //     : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1744806170850xilinks.jpg"),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 237, 236, 236),
                            child: IconButton(
                              onPressed: () {
                                shareText1 =
                                    "Hi, I love this product and sharing this amazing product. Check it out: " +
                                        "${(buyItemData != -1 && buyItemData['name'] != null) ? buyItemData['name'] : "The title of the product"} from Hindan Factory. https://hindustanfactory.socialseller.in/product/${widget.buyid}";
                                // _shareImageAndText();
                                shareNetworkImageWithText();
                                // url_launcher(
                                //   "https://wa.me/91${productData[productIndex]['whatsapp']}"
                                // );
                              },
                              icon: Icon(
                                Icons.share,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 237, 236, 236),
                            child: IconButton(
                              onPressed: () {
                                copyText(
                                    "I love this product and sharing this amazing product. Check it out: " +
                                        "${(buyItemData != -1 && buyItemData['name'] != null) ? buyItemData['name'] : "The title of the product"} from Hindan Factory. https://hindustanfactory.socialseller.in/product/${widget.buyid}");
                              },
                              icon: Icon(
                                Icons.copy_all,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 237, 236, 236),
                            child: IconButton(
                              onPressed: () {
                                _getdwlodmainpic();
                              },
                              icon: Icon(
                                Icons.file_download_sharp,
                                size: 25,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    Container(
                      height: 100,
                      margin: EdgeInsets.all(10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (buyItemData != -1 &&
                                buyItemData['gallery'] != null)
                            ? buyItemData['gallery'].length
                            : 1,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              _photon(index);
                            },
                            child: Container(
                              decoration: (phoin == index) ? decpho : null,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CachedNetworkImage(
                                  imageUrl: (buyItemData != -1 &&
                                          buyItemData['gallery'] != null)
                                      ? buyItemData['gallery'][index]['url']
                                      : MainPhoto,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.broken_image),

                                  // width: double.infinity,
                                  height: 100,
                                  // fit: BoxFit.cover,
                                ),

                                //  Image.network(
                                //   (productIndex != -1 &&
                                //           productData[productIndex]['gallery'] != null)
                                //       ? productData[productIndex]['gallery'][index]
                                //       : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                                //   height: 100,
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //description
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  (buyItemData != -1 &&
                                          buyItemData['name'] != null)
                                      ? buyItemData['name']
                                      : "The title of the product",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Text(
                                    "₹ ${(buyItemData != -1 && buyItemData['variants'] != null) ? buyItemData['variants'][decVarn]['price'] : "2000.00"} ",
                                    style: TextStyle(
                                        color: widget.adth, fontSize: 15),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "₹ ${(buyItemData != null && buyItemData['variants'] != null) ? buyItemData['variants'][decVarn]['strike_price'] : "3000"}",
                                    style: TextStyle(
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "COD ${(buyItemData != null && buyItemData['cod_enabled'] == false) ? 'Unavailable' : 'Available'}",
                                    style: TextStyle(
                                        color: (buyItemData != null &&
                                                buyItemData['cod_enabled'] ==
                                                    true)
                                            ? Colors.greenAccent
                                            : Colors.red,
                                        fontSize: 14),
                                  ),
                                ),
                              ]),
                          Row(
                            children: [
                              Text(
                                "Size",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          _getszx(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: [
                                Text("Variants",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey)),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            margin: EdgeInsets.all(0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: (buyItemData != null &&
                                      buyItemData['variants'] != null)
                                  ? buyItemData['variants'].length
                                  : 0,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _vars(index);
                                      },
                                      child: Container(
                                        decoration:
                                            (decVarn == index) ? decoVar : null,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          child: CachedNetworkImage(
                                            imageUrl: (buyItemData != null &&
                                                    buyItemData['thumbnail'] !=
                                                        null)
                                                ? buyItemData['thumbnail']
                                                    ['url']
                                                : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.broken_image),

                                            // width: double.infinity,
                                            height: 70,
                                            // fit: BoxFit.cover,
                                          ),

                                          //  Image.network(
                                          //   (productIndex != -1 && productData != null)
                                          //       ? productData[productIndex]['image']
                                          //       : "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                                          //   height: 70,
                                          // ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "${(buyItemData['variants'] == null) ? "Colors" : buyItemData['variants'][index]['name']}",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        "${(buyItemData['variants'] == null) ? 20 : buyItemData['variants'][index]['quantity']} Left",
                                        style: TextStyle(fontSize: 8),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Shipping available",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: MaterialButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  child: Text("India",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: MaterialButton(
                                      color: Colors.black,
                                      onPressed: () {},
                                      child: Text(
                                        "Worldwide",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    showDetails = !showDetails;
                                    if (!mounted)
                                      return; // prevents calling setState if widget is disposed

                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Items details"),
                                      Icon((showDetails == true)
                                          ? Icons.arrow_downward
                                          : Icons.navigate_next),
                                    ],
                                  ),
                                ),
                                (showDetails == true)
                                    ? Container(
                                        child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text((buyItemData == null)
                                            ? ""
                                            : buyItemData["description"]),
                                      ))
                                    : Container(),
                                MaterialButton(
                                  onPressed: () {
                                    showShopInfo = !showShopInfo;
                                    if (!mounted)
                                      return; // prevents calling setState if widget is disposed

                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Shipping info"),
                                      Icon((showShopInfo == true)
                                          ? Icons.arrow_downward
                                          : Icons.navigate_next),
                                    ],
                                  ),
                                ),
                                (showShopInfo == true)
                                    ? Container(
                                        child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Text((buyItemData == null)
                                            ? ""
                                            : "COD :${(buyItemData["cod_enabled"]) ? "Available" : "Unavailable"} ," +
                                                "Shipping value type :${buyItemData["shipping_value_type"]}, return days :${buyItemData["return_days"]}, "),
                                      ))
                                    : Container(),
                                MaterialButton(
                                  onPressed: () {
                                    showSupport = !showSupport;
                                    if (!mounted)
                                      return; // prevents calling setState if widget is disposed

                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Support"),
                                      Icon((showSupport == true)
                                          ? Icons.arrow_downward
                                          : Icons.navigate_next),
                                    ],
                                  ),
                                ),
                                (showSupport == true)
                                    ? Container(
                                        child: Text(
                                            "Go to support section over Profile page."))
                                    : Container(),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              children: [
                                Text("You can also like this",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),

                          //
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, left: 15),
                      child: SizedBox(
                        height: 330,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (itemsTop != null) ? itemsTop.length : 0,
                            itemBuilder: (context, index) {
                              return productCard2(
                                name: itemsTop[index]['name'],
                                rating: (itemsTop[index]['rating'] != null)
                                    ? (double.parse(itemsTop[index]['rating']))
                                        .toInt()
                                    : 0,
                                left: itemsTop[index]["variants"][0]
                                    ["quantity"],
                                price: itemsTop[index]["variants"][0]["price"],
                                oldPrice: itemsTop[index]["variants"][0]
                                    ["strike_price"],
                                id: itemsTop[index]["id"],
                                image: itemsTop[index]['thumbnail']["url"],
                                category: itemsTop[index]["category"]["name"],
                              );
                            }),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Container(
                              height: 55,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(color: widget.adth),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: MaterialButton(
                                  highlightColor: widget.adth,
                                  color: Colors.white,
                                  onPressed: () {
                                    _getbookedproduct();
                                    dialogEnquire(msg);
                                  },
                                  child: Text(
                                    "Book Now",
                                    style: TextStyle(color: widget.adth),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: MaterialButton(
                                color: widget.adth,
                                onPressed: () {
                                  // _AddCardDialog();

                                  // (productIndex != -1) ? productData1[productIndex]['variants'][decVarn]['price'] : widget.buyid;

                                  // if (cartn == 0 || !cartIds.contains(widget.buyid)) {
                                  //   cartn++;

                                  //   cartIds.add(widget.buyid);
                                  //   cartCnts.add(1);
                                  // } else {
                                  //   cartCnts[cartIds.indexOf(widget.buyid)] += 1;
                                  // }

                                  _addtoCart(
                                      (buyItemData != null)
                                          ? buyItemData['variants'][decVarn]
                                              ['id']
                                          : widget.buyid,
                                      1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 14, left: 5, right: 5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "Add to Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _getszx() {
    List<String> lsz = ['S', "M", "L", "XL", "XXL", "XXXL"];
    Row rsz = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < lsz.length; i++) _getszcontent(lsz[i], i),
      ],
    );

    return rsz;
  }

  Widget _getszcontent(String str, int index) {
    return GestureDetector(
      onTap: () {
        _sizes(index);
      },
      child: Container(
        decoration: (deconi == index) ? deco : BoxDecoration(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: 45,
            width: 45,
            color: Color.fromARGB(255, 237, 236, 236),
            child: Center(
              child: Text(
                str,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  productCard2({
    required int id,
    required String name,
    required int rating,
    required int left,
    required String price,
    required String oldPrice,
    required String image,
    String? category,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BuyItem(buyid: id, adth: widget.adth)));
        },
        child: SizedBox(
          width: 151,

          // color: const Color.fromRGBO(234, 229, 229, 1),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image),

                  // width: double.infinity,
                  // height: 70,
                  fit: BoxFit.cover,
                ),

                // Image.network(
                //   image,
                //   fit: BoxFit.cover,

                //   // width: double.infinity,
                // ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children:
                            List.generate((rating == 0) ? 1 : rating, (index) {
                          return Icon(
                            Icons.star,
                            size: 17,
                            color: index < rating ? Colors.amber : Colors.grey,
                          );
                        }),
                      ),
                    ),
                    Text(
                      "($rating)",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    category!,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                    textScaler: MediaQuery.textScalerOf(context),
                  ),
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
                  child: Row(
                    children: [
                      Text("₹$oldPrice",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text("₹$price",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
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
}
