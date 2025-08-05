import 'dart:convert';
import 'dart:io';

import 'package:template/models/categorymodel/cate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class GetVerMoney extends StatefulWidget {
  final Color adth;

  const GetVerMoney({required this.adth});

  @override
  State<GetVerMoney> createState() => _GetVerMoneyState();
}

class _GetVerMoneyState extends State<GetVerMoney> {
  final picker = ImagePicker();
  File? _pickedImage;

  Future<void> uploadImage(File file) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('${BASE_URL}uploads'))
          ..headers['Authorization'] = 'Bearer $userToken'
          ..files.add(
            await http.MultipartFile.fromPath(
              'file', // replace with your API's field name
              file.path,
            ),
          );

    try {
      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final resBody = await response.stream.bytesToString();
        final resBody = await response.stream.bytesToString();

        // 👇 Decode JSON string to List
        final List<dynamic> data = jsonDecode(resBody);
        final int id = data[0]['id'];
        // print(jsonDecode(jsonDecode(source))));

        print('✅ File uploaded: $id');
      } else {
        // final error = await response.stream.bytesToString();
        print('❌ Upload failed:');
      }
    } catch (e) {
      print('❗ Upload error: $e');
    }
  }

  void _uploadPickedImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File imageFile = File(picked.path);
      _pickedImage = File(picked.path);
      await uploadImage(imageFile);
    }

    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  Future<void> _showPickOptionsDialog() async {
    final isCamera = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Select image source'),
            actions: [
              TextButton(
                child: const Text('Camera'),
                onPressed: () => Navigator.pop(context, true),
              ),
              TextButton(
                child: const Text('Gallery'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
    );
    if (isCamera == null) return;
    _pickImage(isCamera ? ImageSource.camera : ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? file = await picker.pickImage(source: source, maxWidth: 800);
    if (file == null) return;

    _pickedImage = File(file.path);
    // _uploadPickedImage();

    if (!mounted) return;
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  bool checkValue = true;

  final namc = TextEditingController();
  final emailc = TextEditingController();
  final passc = TextEditingController();
  final mobc = TextEditingController();

  // myController.text = "hshshhshs";
  //  myController2 = "hshshhshs";
  //  myController3 = "hshshhshs";
  //  myController4 ="hshhs";
  Color rit = const Color.fromARGB(248, 231, 222, 222);
  int rith = 50;
  bool didsave = false;
  String msg = "";
  bool registered = false;
  bool agreeToTerms = false;
  _runCheck() {
    if (checkValue == true) {
      checkValue = false;
    } else {
      checkValue = true;
    }
    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  _photoLong() {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Profile Picture"),
            actions: [
              Container(
                child: CircleAvatar(
                  radius: 130,
                  backgroundImage: NetworkImage(
                    (userData["avatar"] != null &&
                            userData["avatar"]["url"] != null)
                        ? userData["avatar"]["url"]
                        : 'https://img.freepik.com/free-vector/smiling-young-account_box_outlined-illustration_1308-174669.jpg',
                  ),
                ),
              ),
            ],
          ),
    );
  }

  // _updateuser() async {
  //   print("ududjdjd");
  //   try {
  //     final rs =
  //         await http.put(Uri.parse('${BASE_URL}store-users/${widget.userid}'),
  //             headers: {
  //               'Content-Type': 'application/json',
  //               'Authorization': "Bearer ${userToken}",
  //             },
  //             body: jsonEncode({
  //               "name": "${namc.text}",
  //               "email": "${emailc.text}",
  //               "phone": "${mobc.text}",
  //               "AvatarId": (avarId == -1) ? null : avarId,
  //             }));
  //     if (rs.statusCode == 200) {
  //       print("success userrrrrrrrrrrrrrrrrrrr");

  //       if (!mounted) {
  //         return;
  //       }
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (context) => ProfilePage(adth: widget.adth, admin: 0)));
  //     } else {
  //       print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
  //       if (!mounted) {
  //         return;
  //       }
  //       if (!mounted) return; // prevents calling setState if widget is disposed

  // setState(() {});
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> _getmeuser() async {
  //   try {
  //     if (false) {
  //       final res =
  //           await http.get(Uri.parse('${BASE_URL}store-users/me'), headers: {
  //         'Authorization': "Bearer ${userToken}",
  //       });

  //       if (res.statusCode == 200) {
  //         print("success userrrrrrrrrrrrrrrrrrrr");
  //         // userData = json.decode(res.body)["data"];

  //         // userData = json.decode(res.body)["data"];
  //         print(userData);
  //         namc.text = userData["name"] ?? "";
  //         emailc.text = userData["email"] == null ? "" : userData["email"];
  //         mobc.text = userData["phone"] ?? "";
  //         passc.text = userData["password"];

  //         if (!mounted) {
  //           return;
  //         }
  //         if (!mounted) return; // prevents calling setState if widget is disposed

  // setState(() {});
  //       } else {
  //         print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
  //       }
  //     } else {
  //       print(userData);
  //       namc.text = userData["name"] ?? "";
  //       emailc.text = userData["email"] ?? "";
  //       mobc.text = userData["phone"] ?? "";
  //       avarId = userData["avatar"] == null ? -1 : userData["avatar"]["id"];
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void initState() {
  //   super.initState();
  //   _getmeuser();

  //   if (!mounted) {
  //     return;
  //   }
  //   if (!mounted) return; // prevents calling setState if widget is disposed

  // setState(() {});
  // }

  bool showRules = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        surfaceTintColor: Colors.white,

        toolbarHeight: 60,
        title: Center(
          child: Text(
            "Recharge Your Wallet",
            style: TextStyle(color: Colors.black),
          ),
        ),
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
            ),
          ),
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
                icon: Icon(Icons.shopping_cart_outlined),
                iconSize: 30,
                color: widget.adth,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // _showPickOptionsDialog();
                          _uploadPickedImage();
                        },
                        onLongPress: () {
                          _photoLong();
                        },
                        child: Image(
                          height: 100,
                          image:
                              (_pickedImage != null)
                                  ? FileImage(_pickedImage!)
                                  // ignore: unnecessary_null_comparison
                                  : NetworkImage(
                                    'https://img.freepik.com/free-vector/smiling-young-account_box_outlined-illustration_1308-174669.jpg',
                                  ),
                        ),
                      ),
                      Text(
                        "Add your payment screenshot",
                        style: TextStyle(color: widget.adth),
                      ),

                      SizedBox(height: 20),

                      // Full Name
                      TextField(
                        controller: namc,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          prefixIcon: Icon(Icons.person_outline),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: widget.adth),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelStyle: TextStyle(color: widget.adth),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Email
                      TextField(
                        controller: emailc,
                        decoration: InputDecoration(
                          labelText: "Paid Amount",
                          prefixIcon: Icon(Icons.money),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: widget.adth),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelStyle: TextStyle(color: widget.adth),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Password
                      // TextField(
                      //   controller: passc,
                      //   obscureText: true,
                      //   decoration: InputDecoration(
                      //     labelText: "Password",
                      //     prefixIcon: Icon(Icons.lock_outline),
                      //     filled: true,
                      //     fillColor: Colors.grey.shade100,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(12),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide: BorderSide(color: widget.adth),
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     labelStyle: TextStyle(color: widget.adth),
                      //   ),
                      // ),
                      // SizedBox(height: 16),

                      // Phone Number
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text("+91"),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: mobc,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: widget.adth),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                labelStyle: TextStyle(color: widget.adth),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Terms and conditions
                      Row(
                        children: [
                          Checkbox(
                            value: agreeToTerms,
                            onChanged: (value) {
                              if (!mounted)
                                return; // prevents calling setState if widget is disposed

                              setState(() => agreeToTerms = value!);
                            },
                          ),
                          Expanded(
                            child: Text("I agree to Terms & Conditions."),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: MaterialButton(
                          height: 50,
                          minWidth: 200,
                          color: widget.adth,
                          onPressed: () {
                            if (agreeToTerms == true) {
                              // _updateuser();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Send Request",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              Icon(Icons.save, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Center(child: Text("No Bank Accounts")),
          ],
        ),
      ),
    );
  }
}
