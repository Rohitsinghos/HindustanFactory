import 'package:template/api/get.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:template/landing.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// final storage = FlutterSecureStorage();

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void requestNotificationPermission() async {

//     showNotification();

// }

// void showNotification() async {
//   const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
//     'channel_id',
//     'channel_name',
//     importance: Importance.max,
//     priority: Priority.high,
//   );

//   const NotificationDetails details =
//       NotificationDetails(android: androidDetails);

//   await flutterLocalNotificationsPlugin.show(
//     1, // Notification ID
//     '🔔 You are welcome, Here!',
//     'This is Hindustan Factory, We would be pleasant to serve you!',
//     details,
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // const AndroidInitializationSettings androidSettings =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');

  // const InitializationSettings initSettings =
  //     InitializationSettings(android: androidSettings);

  // await flutterLocalNotificationsPlugin.initialize(initSettings);

  final storage = FlutterSecureStorage();

  String? token = await storage.read(
    key: 'bota**@useryuwqdhsaahsjkhnxloggedtoken',
  );

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
  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          (widget.isLoggedIn)
              ? MyHome(admin: 0, adth: defaultAppTheme)
              : LandPage(adth: defaultAppTheme),
    );
  }
}
