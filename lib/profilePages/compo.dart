import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/pages/buyItem.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool logi = false;
  bool onprocess = false;

  Future<void> uploadImage(File file) async {
    logi = true;
    onprocess = true;
    if (!mounted) return;
    setState(() {});
    final request =
        http.MultipartRequest('POST', Uri.parse('${BASE_URL}uploads'))
          ..headers['Authorization'] = 'Bearer $userToken'
          ..files.add(
            await http.MultipartFile.fromPath(
              'file', // replace with your API's field name
              file.path,
            ),
          );
    if (!mounted) return;

    try {
      final response = await request.send();
      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final resBody = await response.stream.bytesToString();
        final resBody = await response.stream.bytesToString();

        // 👇 Decode JSON string to List
        final List<dynamic> data = jsonDecode(resBody);
        final int id = data[0]['id'];
        print(jsonDecode(jsonDecode(resBody)));
        // avarId = id;

        print('✅ File uploaded: $id');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ File uploaded successfully!')),
        );
        onprocess = false;
        logi = false;
        if (!mounted) return;
        setState(() {});
      } else {
        // final error = await response.stream.bytesToString();
        print('❌ Upload failed:');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Upload failed!')));
        onprocess = false;

        logi = false;
        if (!mounted) return;
        setState(() {});
      }
    } catch (e) {
      logi = false;
      print('❗ Upload error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❗ Upload error: $e')));
      onprocess = false;

      if (!mounted) return;
      setState(() {});
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

  final picker = ImagePicker();
  File? _pickedImage;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? file = await picker.pickImage(source: source, maxWidth: 800);
    if (file == null) return;

    _pickedImage = File(file.path);
    // _uploadPickedImage();

    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  final cam = TextEditingController();
  // const QrPage({super.key});

  Future<void> AddSend() async {
    try {
      final rs = await http.post(
        Uri.parse('${BASE_URL}review'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
        body: jsonEncode({
          // "mode": "bank",
          "amount": int.parse((cam.text == "") ? "0" : cam.text),
          "UserId": userid,
          "remark": "test remarkable",
          // "account_number": "${cac.text}",
          // "ifsc": "${cif.text}",
          // "amount": "${cam.text}",

          // "AvatarId": (avarId == -1) ? null : avarId,
        }),
      );
      if (rs.statusCode == 200) {
        print("gttgggg666666success userrrrrrrrrrrrrrrrrrrr");
        print(jsonDecode(rs.body));

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Successfully submitted!")));

        Navigator.pop(context);
      } else {
        logi = false;
        print(jsonDecode(rs.body));
        print("nnnnnnnjjjkkkskksk");
        print(jsonDecode(rs.body));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Server error, Failed!")));

        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Network error, Failed!")));
      Navigator.pop(context);
    }
  }

  final cre = TextEditingController();
  final ctl = TextEditingController();

  // File _pickedImage = File('path');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),

        // Get available height and width of the build area of this widget. Make a choice depending on the size.
      ),
      child: Container(
        // height: height - 400,
        width: width - 0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.cancel,
                          size: 28,
                          color:
                              Colors
                                  .blue, // const Color.fromARGB(255, 111, 110, 110),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter your review",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    // fontWeight: FontWeight.bold,
                    // color: blackTitle,
                  ),
                ),

                SizedBox(height: 25),
                Container(
                  // height: 200,
                  width: width,

                  child: TextField(
                    scrollPadding: EdgeInsets.symmetric(horizontal: 4),
                    keyboardType: TextInputType.text,
                    controller: ctl,
                    // style: TextStyle(fontSize: 10),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      // hintText: "Enter Amount",
                      labelText: "Enter Title",
                      hintStyle: TextStyle(color: adth),
                      labelStyle: TextStyle(color: adth), // fontSize: 10),

                      enabledBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(color: adth),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: adth),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Container(
                  // height: 200,
                  width: width,

                  child: TextField(
                    scrollPadding: EdgeInsets.symmetric(horizontal: 4),
                    keyboardType: TextInputType.text,
                    controller: cre,
                    // style: TextStyle(fontSize: 10),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      // hintText: "Enter Amount",
                      labelText: "Enter Review",
                      hintStyle: TextStyle(color: adth),
                      labelStyle: TextStyle(color: adth), // fontSize: 10),

                      enabledBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(color: adth),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: adth),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                // Center(
                //   child: Text(
                //     "Payment is done then upload screenshot.",
                //    // style: TextStyle(color: Colors.green),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(height: 20),

                // Center(
                //   child: Text(
                //     "Payment is done then upload screenshot.",
                //    // style: TextStyle(color: Colors.green),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(height: 20),

                Container(
                  height: 100,
                  width: 60,
                  child:
                      (_pickedImage == null)
                          ? Center(
                            child: IconButton(
                              onPressed: () {
                                _uploadPickedImage();
                              },
                              icon: Icon(Icons.image, size: 35),
                            ),
                          )
                          : Image.file(
                            _pickedImage ?? File("path"),
                            height: 100,
                          ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Container(
                          // width: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: MaterialButton(
                              color: adth,
                              padding: EdgeInsets.symmetric(
                                horizontal: 35,
                                vertical: 15,
                              ),
                              onPressed: () {
                                logi = true;
                                setState(() {});
                                AddSend();

                                // copyText(
                                //   (Stat == null || Stat["referralLink"] == null)
                                //       ? 'https://bounten.com/lakshit'
                                //       : "${Stat["referralLink"]}",
                                // );
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     msg,
                //     style: TextStyle(
                //       color: (logi == true) ? Colors.green : Colors.red,
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                if (logi) LinearProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  bool logi = false;
  bool onprocess = false;

  // Future<void> uploadImage(File file) async {
  //   logi = true;
  //   onprocess = true;
  //   if (!mounted) return;
  //   setState(() {});
  //   final request =
  //       http.MultipartRequest('POST', Uri.parse('${BASE_URL}uploads'))
  //         ..headers['Authorization'] = 'Bearer $userToken'
  //         ..files.add(
  //           await http.MultipartFile.fromPath(
  //             'file', // replace with your API's field name
  //             file.path,
  //           ),
  //         );
  //   if (!mounted) return;

  //   try {
  //     final response = await request.send();
  //     if (!mounted) return;

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       logi = false;
  //       // final resBody = await response.stream.bytesToString();
  //       final resBody = await response.stream.bytesToString();

  //       // 👇 Decode JSON string to List
  //       final List<dynamic> data = jsonDecode(resBody);
  //       final int id = data[0]['id'];
  //       print(jsonDecode(jsonDecode(resBody)));
  //       // avarId = id;

  //       print('✅ File uploaded: $id');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('✅ File uploaded successfully!')),
  //       );
  //       onprocess = false;

  //       if (!mounted) return;
  //       setState(() {});
  //     } else {
  //       logi = false;
  //       _pickedImage = null;
  //       // final error = await response.stream.bytesToString();
  //       print('❌ Upload failed:');
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('❌ Upload failed!')));
  //       onprocess = false;

  //       if (!mounted) return;
  //       setState(() {});
  //     }
  //   } catch (e) {
  //     logi = false;
  //     _pickedImage = null;
  //     print('❗ Upload error: $e');
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text('❗ Upload error: $e')));
  //     onprocess = false;

  //     if (!mounted) return;
  //     setState(() {});
  //   }
  // }

  File? fil;

  void _uploadPickedImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File imageFile = File(picked.path);
      _pickedImage = File(picked.path);
      fil = imageFile;
      // await uploadImage(imageFile);
    }

    if (!mounted) return; // prevents calling setState if widget is disposed

    setState(() {});
  }

  // Future<void> _showPickOptionsDialog() async {
  //   final isCamera = await showDialog<bool>(
  //     context: context,
  //     builder:
  //         (_) => AlertDialog(
  //           title: const Text('Select image source'),
  //           actions: [
  //             TextButton(
  //               child: const Text('Camera'),
  //               onPressed: () => Navigator.pop(context, true),
  //             ),
  //             TextButton(
  //               child: const Text('Gallery'),
  //               onPressed: () => Navigator.pop(context, false),
  //             ),
  //           ],
  //         ),
  //   );
  //   if (isCamera == null) return;
  //   _pickImage(isCamera ? ImageSource.camera : ImageSource.gallery);
  // }

  final picker = ImagePicker();
  File? _pickedImage;

  // Future<void> _pickImage(ImageSource source) async {
  //   final XFile? file = await picker.pickImage(source: source, maxWidth: 800);
  //   if (file == null) return;

  //   _pickedImage = File(file.path);
  //   // _uploadPickedImage();

  //   if (!mounted) return; // prevents calling setState if widget is disposed

  //   setState(() {});
  // }

  final cam = TextEditingController();

  Future<void> getQrData() async {
    if (WalletaddData.isNotEmpty) {
      return;
    }
    try {
      final rs = await http.get(
        Uri.parse('${BASE_URL}admin/bank-details'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
      );
      if (rs.statusCode == 200) {
        print("gttgggg666666success userrrrrrrrrrrrrrrrrrrr");
        print(jsonDecode(rs.body));

        WalletaddData = jsonDecode(rs.body)['data'];
        print(WalletaddData);

        if (!mounted) return;

        setState(() {});
      } else {
        logi = false;
        print(jsonDecode(rs.body));
      }
    } catch (e) {
      print(e);
    }
  }
  // const QrPage({super.key});

  // final file = null;

  Future<void> AddSend(File file) async {
    if (file == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('add scrshot!')));
      return;
    }
    final request =
        http.MultipartRequest('POST', Uri.parse('${BASE_URL}add-money-request'))
          ..headers['Authorization'] = 'Bearer $userToken'
          ..fields['amount'] = '${cam.text ?? "500"}'
          ..files.add(
            await http.MultipartFile.fromPath(
              'screenshot', // replace with your API's field name
              file.path,
            ),
          );
    // if (!mounted) return;

    try {
      final response = await request.send();
      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resBody = await response.stream.bytesToString();
        // final resBody = await response.stream.bytesToString();

        // // 👇 Decode JSON string to List
        // final List<dynamic> data = jsonDecode(resBody);
        // final int id = data[0]['id'];
        print(jsonDecode(resBody));
        // avarId = id;

        print('✅ File uploaded');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ File uploaded successfully!')),
        );
        onprocess = false;

        if (!mounted) return;
        setState(() {});
      } else {
        final resBody = await response.stream.bytesToString();
        // final resBody = await response.stream.bytesToString();

        // // 👇 Decode JSON string to List
        // final List<dynamic> data = jsonDecode(resBody);
        // final int id = data[0]['id'];
        print(jsonDecode(resBody));
        // final error = await response.stream.bytesToString();
        print('❌ Upload failed:');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('❌ Upload failed!')));
        onprocess = false;

        if (!mounted) return;
        setState(() {});
      }
    } catch (e) {
      print('❗ Upload error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❗ Upload error: $e')));
      onprocess = false;

      if (!mounted) return;
      setState(() {});
    }

    // try {
    //   final rs = await http.post(
    //     Uri.parse('${BASE_URL}add-money-request'),
    //     // headers: {
    //     //   'Content-Type': 'application/json',
    //     //   'Authorization': "Bearer ${userToken}",
    //     // },
    //     body: jsonEncode({
    //       // "mode": "bank",
    //       "amount": int.parse((cam.text == "") ? "0" : cam.text),
    //       // "UserId": userid,
    //       // "remark": "test remarkable",
    //       // "account_number": "${cac.text}",
    //       // "ifsc": "${cif.text}",
    //       // "amount": "${cam.text}",

    //       // "AvatarId": (avarId == -1) ? null : avarId,
    //     }),
    //   );
    //   if (rs.statusCode == 200) {
    //     print("gttgggg666666success userrrrrrrrrrrrrrrrrrrr");
    //     print(jsonDecode(rs.body));

    //     ScaffoldMessenger.of(
    //       context,
    //     ).showSnackBar(SnackBar(content: Text("Successfully submitted!")));

    //     Navigator.pop(context);
    //   } else {
    //     logi = false;
    //     print(jsonDecode(rs.body));
    //     print("nnnnnnnjjjkkkskksk");
    //     print(jsonDecode(rs.body));
    //     ScaffoldMessenger.of(
    //       context,
    //     ).showSnackBar(SnackBar(content: Text("Server error, Failed!")));

    //     Navigator.pop(context);
    //   }
    // } catch (e) {
    //   print(e);
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text("Network error, Failed!")));
    // }
  }

  void refresh() {
    getQrData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQrData();
    if (!mounted) return;

    setState(() {});
  }

  // File _pickedImage = File('path');

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),

        // Get available height and width of the build area of this widget. Make a choice depending on the size.
      ),
      child:
          (WalletaddData.isEmpty)
              ? Container(
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: IconButton(
                      onPressed: () {
                        refresh();
                      },
                      icon: RefreshProgressIndicator(color: adth),
                    ),
                  ),
                ),
              )
              : Container(
                // height: height - 400,
                width: width - 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Icon(
                                  Icons.cancel,
                                  size: 28,
                                  color:
                                      Colors
                                          .blue, // const Color.fromARGB(255, 111, 110, 110),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Scan this QR and Pay",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            // fontWeight: FontWeight.bold,
                            // color: blackTitle,
                          ),
                        ),

                        SizedBox(height: 25),

                        CachedNetworkImage(
                          imageUrl: "${WalletaddData?[0]?['qr'] ?? "ahajjaj"}",
                          placeholder: (context, url) => Icon(Icons.image),
                          errorWidget:
                              (context, url, error) => Icon(Icons.image),

                          width: double.infinity,
                          // height: 100,
                          height: 170,
                          // fit: BoxFit.cover,
                        ),

                        // Icon(Icons.image),
                        SizedBox(height: 15),

                        Text(
                          "Bank : ${WalletaddData?[0]?['bank_name'] ?? "ahajjaj"}",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "A/C No : ${WalletaddData?[0]?['account_number'] ?? "ahajjaj"}",
                            ),
                            SizedBox(width: 3),
                            GestureDetector(
                              onTap: () {
                                copyText(
                                  "${WalletaddData?[0]?['account_number'] ?? "ahajjaj"}",
                                );
                              },
                              child: Icon(Icons.copy),
                            ),
                          ],
                        ),
                        Text("IFSC : ${WalletaddData?[0]?['ifsc_code'] ?? 0}"),
                        SizedBox(height: 10),
                        TextField(
                          scrollPadding: EdgeInsets.symmetric(horizontal: 4),
                          keyboardType: TextInputType.number,
                          // controller: cam,
                          // style: TextStyle(fontSize: 10),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            // hintText: "Enter Amount",
                            labelText: "Enter Amount",
                            hintStyle: TextStyle(color: adth),
                            labelStyle: TextStyle(
                              color: adth,
                            ), // fontSize: 10),

                            enabledBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            "Payment is done then upload screenshot.",
                            style: TextStyle(color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Container(
                          height: 60,
                          width: 60,
                          child:
                              (_pickedImage == null)
                                  ? Center(
                                    child: IconButton(
                                      onPressed: () {
                                        _uploadPickedImage();
                                      },
                                      icon: Icon(Icons.image),
                                    ),
                                  )
                                  : Image.file(_pickedImage ?? File("path")),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                child: Container(
                                  // width: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: MaterialButton(
                                      color: adth,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 45,
                                        vertical: 15,
                                      ),
                                      onPressed: () async {
                                        if (fil == null) return;
                                        logi = true;
                                        setState(() {});
                                        await AddSend(fil!);

                                        // copyText(
                                        //   (Stat == null || Stat["referralLink"] == null)
                                        //       ? 'https://bounten.com/lakshit'
                                        //       : "${Stat["referralLink"]}",
                                        // );
                                      },
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Text(
                        //     msg,
                        //     style: TextStyle(
                        //       color: (logi == true) ? Colors.green : Colors.red,
                        //       fontSize: 12,
                        //     ),
                        //   ),
                        // ),
                        if (logi) LinearProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}

class WithdrowPage extends StatefulWidget {
  const WithdrowPage({super.key});

  @override
  State<WithdrowPage> createState() => _WithdrowPageState();
}

class _WithdrowPageState extends State<WithdrowPage> {
  final cnm = TextEditingController();
  final cbk = TextEditingController();
  final cac = TextEditingController();
  final cif = TextEditingController();
  final cam = TextEditingController();

  bool logi = false;
  String msg = "";

  Future<void> withdrawSendupi() async {
    try {
      final rs = await http.post(
        Uri.parse('${BASE_URL}withdrawal-request'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
        body: jsonEncode(
          // {
          // "amount": 50,
          // "method": "BANK_TRANSFER",
          // "account_details": {
          //   "accountNumber": "1234567890",
          //   "ifsc": "HDFC0001234",
          //   "bankName": "HDFC Bank",
          //   "holderName": "Raj hhTilak",
          // },
          {
            "amount": int.parse(cam.text ?? "100"),
            "method": "UPI",
            "account_details": {
              "upi": "${cbk.text}",
              // "ifsc": "${cif.text}",
              // "bankName": "${cbk.text ?? "HDFC Bank"}",
              "Name": "${cnm.text ?? "HDFC Bank"}",
            },
          },
        ),
      );

      // print(
      //   "mode" +
      //       "bank" +
      //       "account_number" +
      //       "${cac.text}" +
      //       "ifsc" +
      //       "${cif.text}" +
      //       "amount" +
      //       "${cam.text}",
      // );
      if (rs.statusCode == 200) {
        print("gttgggg666666success userrrrrrrrrrrrrrrrrrrr");
        print(jsonDecode(rs.body));

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Request submitted!")));

        Navigator.pop(context);
      } else {
        print(jsonDecode(rs.body));
        print("nnnnnnnjjjkkkskksk");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("${jsonDecode(rs.body)}")));

        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> withdrawSend() async {
    try {
      final rs = await http.post(
        Uri.parse('${BASE_URL}withdrawal-request'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${userToken}",
        },
        body: jsonEncode(
          // {
          // "amount": 50,
          // "method": "BANK_TRANSFER",
          // "account_details": {
          //   "accountNumber": "1234567890",
          //   "ifsc": "HDFC0001234",
          //   "bankName": "HDFC Bank",
          //   "holderName": "Raj hhTilak",
          // },
          {
            "amount": int.parse(cam.text ?? "100"),
            "method": "BANK_TRANSFER",
            "account_details": {
              "accountNumber": "${cac.text}",
              "ifsc": "${cif.text}",
              "bankName": "${cbk.text ?? "HDFC Bank"}",
              "holderName": "${cnm.text ?? "HDFC Bank"}",
            },
          },
        ),
      );

      // print(
      //   "mode" +
      //       "bank" +
      //       "account_number" +
      //       "${cac.text}" +
      //       "ifsc" +
      //       "${cif.text}" +
      //       "amount" +
      //       "${cam.text}",
      // );
      if (rs.statusCode == 200) {
        print("gttgggg666666success userrrrrrrrrrrrrrrrrrrr");
        print(jsonDecode(rs.body));

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Request submitted!")));

        Navigator.pop(context);
      } else {
        print(jsonDecode(rs.body));
        print("nnnnnnnjjjkkkskksk");
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("${jsonDecode(rs.body)}")));

        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  bool upi = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        height: 50,
                        // minWidth: 283,
                        color: (!upi) ? adth : Colors.grey,
                        onPressed: () {
                          upi = false;

                          cbk.text = "";
                          setState(() {});
                        },
                        child: Center(
                          child: Container(
                            child: Center(
                              child: Text(
                                "Bank Transfer",
                                style: TextStyle(
                                  color: (upi) ? adth : Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      MaterialButton(
                        height: 50,
                        // minWidth: 283,
                        color: (upi) ? adth : Colors.grey,
                        onPressed: () {
                          upi = true;
                          cbk.text = "";
                          setState(() {});
                        },
                        child: Center(
                          child: Center(
                            child: Text(
                              "UPI Transfer",
                              style: TextStyle(
                                color: (!upi) ? adth : Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Icon(
                          Icons.cancel,
                          size: 28,
                          color:
                              Colors
                                  .blue, // const Color.fromARGB(255, 111, 110, 110),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 10),
                (upi)
                    ? Column(
                      children: [
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " Upi Withdrawal Request",
                            style: TextStyle(
                              fontSize: 22, //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Holder Name",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: cnm,
                          decoration: InputDecoration(
                            hintText: "Holder Name",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "UPI id",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: cbk,
                          decoration: InputDecoration(
                            hintText: "UPI id",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Amount",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: cam,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        MaterialButton(
                          height: 50,
                          // minWidth: 283,
                          color: adth,
                          onPressed: () {
                            if (cac.text.length <= 4 ||
                                cnm.text.length <= 2 ||
                                cbk.text.length <= 2 ||
                                cif.text.length <= 4 ||
                                cac.text.isEmpty) {
                              logi = false;
                              msg =
                                  "Account No. should be more than 5 digits and IFSC code should be more than 5 characters and amount can not be empty!";
                              setState(() {});
                              return;
                            }
                            msg = "In process..";
                            logi = true;
                            setState(() {});
                            // _getChangePass();

                            withdrawSendupi();
                          },
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Submit Request",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Icon(color: Colors.white, Icons.lock_open),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : Column(
                      children: [
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Withdrawal Request",
                            style: TextStyle(
                              fontSize: 22, //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Bank Holder Name",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: cnm,
                          decoration: InputDecoration(
                            hintText: "Bank Holder Name",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Bank Name",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: cbk,
                          decoration: InputDecoration(
                            hintText: "Bank Name",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Account No.",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: cac,
                          decoration: InputDecoration(
                            hintText: "Account No.",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "IFSC Code",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: cif,
                          decoration: InputDecoration(
                            hintText: "IFSC Code",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Amount",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        //  SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: cam,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            hintStyle: TextStyle(color: adth),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: adth),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Text(
                        //     (logi == false) ? msg : '',
                        //     style: TextStyle(color: Colors.red, fontSize: 12),
                        //   ),
                        // ),
                        SizedBox(height: 20),

                        MaterialButton(
                          height: 50,
                          // minWidth: 283,
                          color: adth,
                          onPressed: () {
                            if (cac.text.length <= 4 ||
                                cnm.text.length <= 2 ||
                                cbk.text.length <= 2 ||
                                cif.text.length <= 4 ||
                                cac.text.isEmpty) {
                              logi = false;
                              msg =
                                  "Account No. should be more than 5 digits and IFSC code should be more than 5 characters and amount can not be empty!";
                              setState(() {});
                              return;
                            }
                            msg = "In process..";
                            logi = true;
                            setState(() {});
                            // _getChangePass();

                            withdrawSend();
                          },
                          child: Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "Submit Request",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Icon(color: Colors.white, Icons.lock_open),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    msg,
                    style: TextStyle(
                      color: (logi == true) ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),

                if (logi) LinearProgressIndicator(),

                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color:
                            Colors
                                .blue, // const Color.fromARGB(255, 111, 110, 110),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Are you sure, log out??",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              // QrImageView(
              //   data: '${Stat["referralLink"]}',
              //   size: 200,
              //   version: QrVersions.auto,
              // ),

              // // Icon(Icons.image),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        width: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: MaterialButton(
                            color: adth,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      borderOnForeground: false,
                      child: Container(
                        width: 220,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: adth),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: MaterialButton(
                            color: Colors.white,
                            onPressed: () {
                              // final storage = FlutterSecureStorage();

                              // storage.delete(
                              //   key:
                              //       'bota**@useryubountensaahsjkhnxloggedtoken',
                              // );
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         MyApp(isLoggedIn: false),
                              //   ),
                              //   (context) => false,
                              // );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: adth),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExitPage extends StatelessWidget {
  const ExitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color:
                            Colors
                                .blue, // const Color.fromARGB(255, 111, 110, 110),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Are you sure, Exit App??",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              // QrImageView(
              //   data: '${Stat["referralLink"]}',
              //   size: 200,
              //   version: QrVersions.auto,
              // ),

              // // Icon(Icons.image),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        width: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: MaterialButton(
                            color: adth,
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      borderOnForeground: false,
                      child: Container(
                        width: 220,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: adth),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: MaterialButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: adth),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetPicPage extends StatelessWidget {
  const GetPicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationDuration: Duration(seconds: 3),
      insetAnimationCurve: Curves.easeInBack,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color:
                            Colors
                                .blue, // const Color.fromARGB(255, 111, 110, 110),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Select, Image Source?",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              // QrImageView(
              //   data: '${Stat["referralLink"]}',
              //   size: 200,
              //   version: QrVersions.auto,
              // ),

              // // Icon(Icons.image),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      child: Container(
                        width: 220,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: MaterialButton(
                            color: adth,
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      borderOnForeground: false,
                      child: Container(
                        width: 220,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: adth),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(12),
                          child: MaterialButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Galley',
                                    style: TextStyle(color: adth),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
