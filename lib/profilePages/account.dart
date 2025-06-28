import 'dart:convert';
import 'dart:io';

import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart'; // for MediaType
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class AccPage extends StatefulWidget {
  final Color adth;
  AccPage({required this.adth});

  @override
  State<AccPage> createState() => _AccPageState();
}

class _AccPageState extends State<AccPage> {
  final picker = ImagePicker();
  File? _pickedImage;

  Future<void> uploadImage(File imageFile) async {
    final uri = Uri.parse('https://your-api.com/upload');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $userToken';

    final mimeType = lookupMimeType(imageFile.path)?.split('/');

    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // this is the field name expected by the API
        imageFile.path,
        contentType: mimeType != null
            ? MediaType(mimeType[0], mimeType[1])
            : MediaType('image', 'jpeg'), // fallback
      ),
    );

    final response = await request.send();

    if (response.statusCode == 200) {
      print("✅ Image uploaded successfully!");
    } else {
      print("❌ Failed to upload. Status: ${response.statusCode}");
    }
  }

  void _uploadPickedImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File imageFile = File(picked.path);
      await uploadImage(imageFile);
    }
  }

  Future<void> _showPickOptionsDialog() async {
    final isCamera = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
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
    setState(() => _pickedImage = File(file.path));
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
    setState(() {});
  }

  _photoLong() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Profile Picture"),
              actions: [
                Container(
                  child: CircleAvatar(
                    radius: 130,
                    backgroundImage: NetworkImage((userData != null &&
                            userData["avatar"] != null &&
                            userData["avatar"]["url"] != null)
                        ? userData["avatar"]["url"]
                        : 'https://img.freepik.com/free-vector/smiling-young-account_box_outlined-illustration_1308-174669.jpg'),
                  ),
                ),
              ],
            ));
  }

  Future<void> _getmeuser() async {
    try {
      if (false) {
        final res =
            await http.get(Uri.parse('${BASE_URL}store-users/me'), headers: {
          'Authorization': "Bearer ${userToken}",
        });

        if (res.statusCode == 200) {
          print("success userrrrrrrrrrrrrrrrrrrr");
          // userData = json.decode(res.body)["data"];

          // userData = json.decode(res.body)["data"];
          print(userData);
          namc.text = userData["name"] ?? "";
          emailc.text = userData["email"] == null ? "" : userData["email"];
          mobc.text = userData["phone"] ?? "";
          passc.text = userData["password"];

          if (!mounted) {
            return;
          }
          setState(() {});
        } else {
          print("failure userrrrrrrrrrrrrrrrrrrrrrrrrrrr");
        }
      } else {
        print(userData);
        namc.text = userData["name"] ?? "";
        emailc.text = userData["email"] ?? "";
        mobc.text = userData["phone"] ?? "";
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    _getmeuser();

    if (!mounted) {
      return;
    }
    setState(() {});
  }

  bool showRules = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 60,
        title: Center(
          child: Text(
            "Profile Info",
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
                  icon: Icon(Icons.shopping_cart_outlined),
                  iconSize: 30,
                  color: widget.adth,
                )),
          )
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
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          GestureDetector(
                            onTap: () {
                              _showPickOptionsDialog();
                            },
                            onLongPress: () {
                              _photoLong();
                            },
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage: (_pickedImage != null)
                                  ? FileImage(_pickedImage!)
                                  // ignore: unnecessary_null_comparison
                                  : NetworkImage((userData != null &&
                                          userData["avatar"] != null &&
                                          userData["avatar"]["url"] != null)
                                      ? userData["avatar"]["url"]
                                      : 'https://img.freepik.com/free-vector/smiling-young-account_box_outlined-illustration_1308-174669.jpg'),
                            ),
                          ),
                          Text(
                            "Edit Profile Picture",
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
                                  borderSide: BorderSide.none),
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
                              labelText: "Email address",
                              prefixIcon: Icon(Icons.email_outlined),
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
                          TextField(
                            controller: passc,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: Icon(Icons.lock_outline),
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

                          // Phone Number
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
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
                                      borderSide:
                                          BorderSide(color: widget.adth),
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
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ])))),

            // Center(child: Text("No Bank Accounts")),
          ],
        ),
      ),
    );
  }
}
