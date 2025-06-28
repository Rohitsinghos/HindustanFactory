import 'package:Template/profilePages/collection.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  final Color adth;
  const SupportPage({required this.adth});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Support Page",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CollectionPage(adth: widget.adth)));
                  },
                  icon: Icon(
                    Icons.favorite_border_outlined,
                  ),
                  iconSize: 30,
                  color: widget.adth,
                )),
          )
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
