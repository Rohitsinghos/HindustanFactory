import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:template/pages/buyItem.dart';
import 'package:template/pages/category1.dart';
import 'package:template/pages/cartdirect.dart';
import 'package:template/models/categorymodel/cate.dart';
import 'package:template/pages/home.dart';
import 'package:template/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
  Future<void> getvideos() async {
    try {
      final res = await http.get(
        Uri.parse(
          BASE_URL +
              "stories", //?&&pagination[page]=1&pagination[pageSize]=14",
        ),
      );

      if (res.statusCode == 200) {
        print(res.body);
        vddataa = jsonDecode(res.body)['data'];
        videoUrls = [];
        for (int i = 0; i < vddataa.length; i++) {
          videoUrls.add(vddataa[i]['video']['url']);
        }
        try {
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
        } catch (e) {
          print(e);
        }
      } else {
        print("Failed to load banner data");
        if (!mounted) return;
        load = "Server Error!";
        setState(() {});
      }
    } catch (e) {
      print(e);
      if (!mounted) return;
      load = "Network Error!";
      setState(() {});
    }
  }

  late List<VideoPlayerController> controllers;

  @override
  void initState() {
    super.initState();
    if (vddataa.isEmpty) {
      getvideos();
    }

    try {
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
      // controllers.first.play();
    } catch (e) {
      print(e);
    }
  }

  String load = "Loading";

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  int vid = 0;

  bool pause = false;

  @override
  Widget build(BuildContext context) {
    // dostart();
    return (vddataa.isEmpty || videoUrls.isEmpty)
        ? Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child:
                  (videoUrls.isEmpty)
                      ? Text(
                        "No Shorts found!",
                        style: TextStyle(
                          fontSize: 16,
                          // color:
                          //     (load == "Loading") ? Colors.green : Colors.red,
                        ),
                      )
                      : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Text(
                            (load == "Loading") ? "" : load,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  (load == "Loading")
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (!mounted) return;
                              load = "Loading";
                              setState(() {});
                              getvideos();
                              // _getmeuser();
                              // _getProfileData();
                            },
                            icon:
                                (load == "Loading")
                                    ? RefreshProgressIndicator()
                                    : Icon(Icons.refresh, color: Colors.blue),
                          ),
                        ],
                      ),
            ),
          ),
          bottomNavigationBar: bottombr(),
        )
        : Scaffold(
          backgroundColor: Colors.white,
          body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controllers.length,

            onPageChanged: (index) {
              vid = index;
              pause = false;
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
                  ? GestureDetector(
                    onTap: () {
                      if (pause) {
                        controllers[index].play();
                        pause = false;
                        return;
                      }
                      pause = true;
                      controllers[index].pause();
                    },
                    child: Stack(
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
                          child: Container(
                            height: 90,

                            child: Row(
                              children: [
                                for (
                                  int i = 0;
                                  i < vddataa?[index]?['products'].length;
                                  i++
                                )
                                  GestureDetector(
                                    onTap: () {
                                      controllers[i].pause();
                                      for (var controller in controllers) {
                                        controller.dispose();
                                      }
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => BuyItem(
                                                adth: adth,
                                                buyid:
                                                    vddataa[index]['products'][i]['id'] ??
                                                    0,
                                              ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 90,
                                      decoration: BoxDecoration(
                                        // border: Border.all(color: Colors.grey),
                                        // color: Colors.white,
                                        // borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  vddataa[index]['products'][i]['thumbnail']['url'],
                                              placeholder:
                                                  (context, url) =>
                                                      Icon(Icons.image),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.image),

                                              // width: double.infinity,
                                              height: 65,
                                              // height: 200,
                                              // fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              vddataa?[index]?['products']?[i]?['name'] ??
                                                  "jhdjhdhd",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            // child: ListView.builder(
                            //   scrollDirection: Axis.horizontal,
                            //   itemCount: vddataa[index]['products'].length,
                            //   itemBuilder:
                            //       (ind, cx) =>
                            // ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(Icons.image, color: widget.adth),
                    ),
                  );
            },
          ),
          bottomNavigationBar: bottombr(),
        );
  }

  Widget bottombr() {
    return BottomAppBar(
      surfaceTintColor: Colors.white,
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
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
                controllers[i].pause();
                for (var controller in controllers) {
                  controller.dispose();
                }
                dispose();
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
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
                controllers[i].pause();
                for (var controller in controllers) {
                  controller.dispose();
                }
                dispose();
                Navigator.pushReplacement(
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
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
                controllers[i].pause();
                dispose();
                Navigator.pushReplacement(
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
          Stack(
            children: [
              Container(
                height: 45,
                width: 60,
                child: GestureDetector(
                  // padding: EdgeInsets.only(bottom: 0),
                  onTap: () {
                    for (var controller in controllers) {
                      controller.dispose();
                    }
                    controllers[i].pause();
                    dispose();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                CartDirPage(admin: 3, adth: widget.adth),
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
              if (cartnn != 0)
                Positioned(
                  top: 0,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: adth,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 3),

                    child: Text(
                      "${cartnn}",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          Container(
            height: 45,
            width: 60,
            child: GestureDetector(
              // padding: EdgeInsets.only(bottom: 0),
              onTap: () {
                for (var controller in controllers) {
                  controller.dispose();
                }
                controllers[i].pause();
                dispose();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            ProfilePage(adth: widget.adth, admin: widget.admin),
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
    );
  }
}
