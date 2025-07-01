import 'package:Template/api/get.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:Template/landing.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = FlutterSecureStorage();

  String? token =
      await storage.read(key: 'bota**@useryuwqdhsaahsjkhnxloggedtoken');

  userToken = token ?? "";

  runApp(MyApp(isLoggedIn: token != null && token.isNotEmpty));
}

final store = GetStorage();

Color defaultAppTheme = Colors.deepOrange;

// bool loggedIn = false;
// String number = store.read('Usernumber') ?? '';

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // _doood() {
  //   if (store.read('bota**@userloggedtoken') != null) {
  //     userToken = store.read('bota**@userloggedtoken');
  //     setState(() {});
  //   }
  // }

  bool loggedIn = false;

  // @override
  // // void initState() {
  //   super.initState();
  //   _doood();
  // }

  // _getuserdatata() async {
  //   String? token =
  //       await storage.read(key: 'bota**@useryuwqdhsaahsjkhnxloggedtoken');

  //   // String? token = await getToken();

  //   if (token == null || token.isEmpty) {
  //     print("❌ Token not found. Ask user to login.");
  //     return false;
  //   } else {
  //     userToken = token;
  //     print("✅ Token loaded: $token");
  //     loggedIn = true;
  //     return true;
  //   }

  //   return true;
  // }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  //   _getuserdatata();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (widget.isLoggedIn)
          ? MyHome(
              admin: 0,
              adth: defaultAppTheme,
            )
          : LandPage(
              adth: defaultAppTheme,
            ),
    );
  }
}
