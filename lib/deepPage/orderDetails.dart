import 'dart:convert';

import 'package:Template/Purchase/buyItem.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class OrderDetailsCard extends StatefulWidget {
  final Color adth;
  final int orderid;
  final String? orderpic;
  OrderDetailsCard({required this.adth, required this.orderid, this.orderpic});

  @override
  State<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  Map orderUserdata = {};
  String orderId = "ksdks";
  String paymentMode = "ksdks";
  String productImage = "ksdks";
  String productName = "ksdks";
  String variant = "ksdks";
  int quantity = 1;
  int price = 1;
  int shippingCharge = 2;
  int variId = 2;
  Map<String, dynamic> address = {};
  String statusord = "CANCELLED";
  Future<void> _getmeuseroderss() async {
    try {
      final res = await http.get(
          Uri.parse('${BASE_URL}order-variants/${widget.orderid}'),
          headers: {
            'Authorization': "Bearer ${userToken}",
          });

      if (res.statusCode == 200) {
        print("success userrrrrrrrrrrrrrrrrrrr");
        // userData = json.decode(res.body)["data"];

        orderUserdata = json.decode(res.body)["data"];
        orderId = orderUserdata["OrderId"].toString() ?? "1";
        statusord = orderUserdata["status"] ?? "CANCELLED";
        paymentMode = orderUserdata["order"]["payment_mode"] ?? "";
        productImage = "ksdks";
        productName = orderUserdata["variant"]["product"]["name"] ?? "";
        variant = orderUserdata["variant"]["name"] ?? "";
        quantity = orderUserdata["quantity"] ?? 1;
        price = int.parse(orderUserdata["variant"]["price"]) ?? 1;
        shippingCharge = 0;
        address = orderUserdata["order"]["address"] ?? {};
        variId = orderUserdata["variant"]["ProductId"] ?? 1;

        setState(() {});
        print(userData);
      } else {
        print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _invoicedwlod() async {
    try {
      final dio = Dio();

      final response = await dio.get(
        '${BASE_URL}orders/${widget.orderid}/invoice', // your API or file URL
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      // Get local path
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/downloaded_file.pdf";

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

  void initState() {
    super.initState();
    _getmeuseroderss();

    if (!mounted) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final int total = price + shippingCharge;
    return Scaffold(
      appBar: AppBar(
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
                  icon: Icon(Icons.favorite_border_outlined),
                  iconSize: 30,
                  color: widget.adth,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: (statusord != "CANCELLED") ? Colors.green : Colors.red,
              padding: EdgeInsets.all(2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close, color: Colors.white),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your Order has been $statusord',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(12.0),
                  //   child: Text(
                  //     'Order ID: $orderId',
                  //     style: const TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Header + status

            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            'Order ID: #$orderId',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            'Payment Mode: $paymentMode',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.deepOrangeAccent),
                    ),
                    onPressed: () {
                      /* Download logic */
                      _invoicedwlod();
                    },
                    child: const Text('Download Invoice'),
                  ),
                ],
              ),
            ),
            // Product details
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.orderpic ??
                                "https://mtt-s3.s3.ap-south-1.amazonaws.com/1721284931557MAIN-IMAGE_c75004a7-8279-4778-86e0-6a1a53041ff8_1080x.jpg",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 80),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName,
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text('Variant: $variant',
                                        style: const TextStyle(
                                            color: Colors.orange,
                                            fontSize: 10)),
                                  ),
                                  Text(
                                    'Quantity: $quantity',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Price ₹$price',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          child: MaterialButton(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Product \nReview"),
                                ),
                                Icon(Icons.reviews),
                              ],
                            ),
                            onPressed: () {/* Delete logic */},
                          ),
                        ),
                        Card(
                          child: MaterialButton(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Share \nTracking"),
                                ),
                                Icon(Icons.reviews),
                              ],
                            ),
                            onPressed: () {/* Delete logic */},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Order summary
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal of 1 item'),
                        Text('₹${price * quantity}'),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Shipping Charges'),
                        Text('₹$shippingCharge'),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Amount',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('₹${price * quantity + shippingCharge}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Address
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery Address'),
                    const SizedBox(height: 8),
                    Text(
                      (address == null)
                          ? ""
                          : "" +
                              "${address["name"]}\n${address["phone"]}\n${address["email"]}\n${address["houseNumber"]}, ${address["area"]}, ${address["addressLine1"]}," +
                              " ${address["city"]}\n${address["state"]}, ${address["pincode"]}, ${address["country"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // Reorder button
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 14)),
          onPressed: () {
            /* reorder action */
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BuyItem(adth: widget.adth, buyid: variId)));
          },
          child: const Text(
            'Reorder Product',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
