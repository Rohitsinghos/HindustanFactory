import 'package:Template/profilePages/collection.dart';
import 'package:flutter/material.dart';

class CoursePAge extends StatefulWidget {
  final Color adth;

  CoursePAge({required this.adth});

  @override
  State<CoursePAge> createState() => _CoursePAgeState();
}

class _CoursePAgeState extends State<CoursePAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            "Courses",
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
