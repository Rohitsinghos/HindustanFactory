import 'package:template/CategoryPages/category1.dart';
import 'package:template/Purchase/cartdirect.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/pages/home.dart';
import 'package:template/pages/profile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class VideoPage extends StatefulWidget {
  final Color adth;
  final int admin;

  VideoPage({required this.adth, required this.admin});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

Color b11 = const Color.fromARGB(255, 169, 169, 169);
Color b2 = const Color.fromARGB(255, 169, 169, 169);
Color b3 = const Color.fromARGB(255, 169, 169, 169);
Color b4 = const Color.fromARGB(255, 169, 169, 169);
Color b5 = const Color.fromARGB(255, 169, 169, 169);

List<Color> b = [b1, b2, b3, b4, b5];

class _VideoPageState extends State<VideoPage> {
  final List<String> videoUrls = [
    'https://mtt-s3.s3.ap-south-1.amazonaws.com/1749709720646WhatsApp+Video+2025-06-12+at+11.57.44_9a59f530.mp4',
    'https://mtt-s3.s3.ap-south-1.amazonaws.com/1749709738560WhatsApp+Video+2025-06-12+at+11.57.44_9a59f530.mp4',
    'https://mtt-s3.s3.ap-south-1.amazonaws.com/1749709720646WhatsApp+Video+2025-06-12+at+11.57.44_9a59f530.mp4',
  ];

  late List<VideoPlayerController> controllers;

  @override
  void initState() {
    super.initState();
    controllers =
        videoUrls.map((url) {
          final controller = VideoPlayerController.network(url);
          controller.initialize().then((_) {
            if (!mounted)
              return; // prevents calling setState if widget is disposed

            setState(() {}); // refresh UI
          });
          controller.setLooping(true);
          return controller;
        }).toList();

    // Autoplay the first video
    controllers.first.play();
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  int vid = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controllers.length,
        onPageChanged: (index) {
          vid = index;
          for (int i = 0; i < controllers.length; i++) {
            if (i == index) {
              controllers[i].play();
            } else {
              controllers[i].pause();
            }
          }
        },
        itemBuilder: (context, index) {
          final controller = controllers[index];
          return controller.value.isInitialized
              ? Stack(
                fit: StackFit.expand,
                children: [
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                  // Overlay UI
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: Text(
                      'Video ${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 68,
        // currentIndex: 0,
        // selectedItemColor: widget.adth,
        // unselectedItemColor: Colors.grey,
        // showSelectedLabels: true,
        // showUnselectedLabels: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  controllers[i].pause();
                  for (var controller in controllers) {
                    controller.dispose();
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHome(adth: widget.adth, admin: 0),
                    ),
                    (context) => false,
                  );
                },
                child: Column(
                  children: [
                    Icon(Icons.home_outlined, size: 21, color: b[0]),
                    Text(style: TextStyle(color: b1, fontSize: 13), 'Home'),
                  ],
                ),
              ),
            ),
            Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  controllers[i].pause();
                  for (var controller in controllers) {
                    controller.dispose();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              Cart1Page(adth: widget.adth, admin: widget.admin),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(Icons.dashboard_outlined, color: b1, size: 21),
                    Text('Category', style: TextStyle(color: b1, fontSize: 13)),
                  ],
                ),
              ),
            ),
            Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  controllers[i].pause();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => VideoPage(admin: 2, adth: widget.adth),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(Icons.ondemand_video, color: widget.adth, size: 21),
                    Text(
                      style: TextStyle(color: widget.adth, fontSize: 13),
                      'Shorts',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  for (var controller in controllers) {
                    controller.dispose();
                  }
                  controllers[i].pause();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CartDirPage(admin: 3, adth: widget.adth),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(Icons.shopping_cart_outlined, color: b[3], size: 21),
                    Text(style: TextStyle(color: b1, fontSize: 13), 'Cart'),
                  ],
                ),
              ),
            ),
            Container(
              height: 45,
              width: 60,
              child: MaterialButton(
                padding: EdgeInsets.only(bottom: 0),
                onPressed: () {
                  for (var controller in controllers) {
                    controller.dispose();
                  }
                  controllers[i].pause();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ProfilePage(
                            adth: widget.adth,
                            admin: widget.admin,
                          ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Icon(Icons.person_outline, color: b[4], size: 21),
                    Text(style: TextStyle(color: b1, fontSize: 13), 'Profile'),
                  ],
                ),
              ),
            ),
          ],
        ),

        //
        // ],
      ),
    );
  }
}
