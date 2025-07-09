import 'package:template/models/categorymodel/cate.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> getdata() async {
  userData = {};
  try {
    final res = await http.get(
      Uri.parse('${BASE_URL}store-users/me'),
      headers: {'Authorization': "Bearer ${userToken}"},
    );

    if (res.statusCode == 200) {
      print("success userrrrrrrrrrrrrrrrrrrr");
      userData = json.decode(res.body)["data"];
      return true;
    } else {
      print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      return false;
    }
  } catch (e) {
    print(e);
  }
  return false;
}

Future<void> getdatatoAddr(int id, int qu) async {
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

    final req = await http.get(
      Uri.parse("${BASE_URL}address"),
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': "Bearer ${userToken}",
      },
    );

    if (req.statusCode == 200) {
      print(jsonDecode(req.body)["data"]);

      addressdata = jsonDecode(req.body)["data"];

      // usercartData = jsonDecode(req.body)["data"];

      print(addressdata);

      print("jsdjjhdjdjjdjdjjd cart millll gayaya  ho gyayyaya");

      // if (!mounted) return; // prevents calling setState if widget is disposed

      // setState(() {});
    } else {
      print(
        "not cart nahi millallalal to cart... abbebebebbhhdshdhhdhnananannanan",
      );
    }
  } catch (e) {
    print(e);
    print("error  haiiaiia biroroo jdjdjjdjdjjdjjd");
  }
}
