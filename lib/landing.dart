import 'package:flutter/material.dart';
import 'package:template/loginPaages/login.dart';
import 'package:template/loginPaages/reg.dart';

class LandPage extends StatefulWidget {
  final Color adth;
  // final Link nn;

  LandPage({required this.adth});

  @override
  State<LandPage> createState() => _LandPageState();
}

String nn =
    ("https://mtt-s3.s3.ap-south-1.amazonaws.com/17443727107671744111638232HF%20PNG%20Transparent%20%281%29.WEBP");

class _LandPageState extends State<LandPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Show the confirmation dialog
        final shouldExit = await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Exit App'),
                content: Text('Do you want to exit the Hindustan Factory app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('Yes'),
                  ),
                ],
              ),
        );
        // If the user confirmed, exit the app
        return shouldExit ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          // surfaceTintColor: Colors.white,
          backgroundColor: widget.adth,
          toolbarHeight: 0,
        ),
        body: Container(
          height: BoxConstraints().maxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 280,
                margin: EdgeInsets.only(top: 180),
                child: Container(child: Image.asset('assets/logo.png')),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        RegisterPage(adth: widget.adth),
                              ),
                            );
                          },
                          height: 43,
                          minWidth: 320,
                          child: Text("Get Started"),
                          color: widget.adth,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LogIn(adth: widget.adth),
                              ),
                            );
                          },
                          height: 43,
                          minWidth: 320,
                          child: Text("Login"),
                          color: Colors.white,
                          textColor: widget.adth,
                        ),
                      ),
                    ),
                  ),
                  BottomAppBar(
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    height: 60,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => RegisterPage(adth: widget.adth),
                          ),
                        );
                      },
                      child: Center(child: Text("New around here? Register")),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
