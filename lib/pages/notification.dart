import 'package:template/main.dart';
import 'package:template/profilePages/collection.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  final Color adth;

  NotificationPage({required this.adth});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   requestNotificationPermission();
  //   // showNotification();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,

        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Notifications",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CollectionPage(adth: widget.adth),
                    ),
                  );
                },
                icon: Icon(Icons.favorite_border_outlined),
                iconSize: 30,
                color: widget.adth,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Center(child: Text("No data found"))],
      ),
    );
  }
}
