import 'package:Template/api/get.dart';
import 'package:Template/models/categorymodel/cate.dart';
import 'package:Template/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:Template/landing.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(MyApp());
}

final store = GetStorage();

Color defaultAppTheme = Colors.deepOrange;

// bool loggedIn = false;
// String number = store.read('Usernumber') ?? '';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _doood() {
    if (store.read('bota**@userloggedtoken') != null) {
      userToken = store.read('bota**@userloggedtoken');
      setState(() {});
    }
  }

  bool loggedIn = (userToken == "") ? false : true;

  @override
  void initState() {
    super.initState();
    _doood();
  }

  @override
  Widget build(BuildContext context) {
    loggedIn = (userToken == "") ? false : true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (loggedIn)
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
