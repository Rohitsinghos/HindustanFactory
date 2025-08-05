import 'package:template/models/categorymodel/cate.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerQrrr extends StatefulWidget {
  final Color adth;

  const ScannerQrrr({required this.adth});

  @override
  State<ScannerQrrr> createState() => _ScannerQrrrState();
}

class _ScannerQrrrState extends State<ScannerQrrr> {
  List barcodes = [];
  String? qrText = 'No QR code found';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,

        title: Center(
          // padding: const EdgeInsets.only(left: 0.0),
          child: Text(
            qrText ?? "No QR code found",
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
      ),
      body: Center(
        child: MobileScanner(
          // allowDuplicates: false,
          onDetect: (barcodes) {
            qrText = barcodes.barcodes.first.rawValue;
            qrTexts = qrText.toString();
            print(qrText);

            Future.delayed(Duration(seconds: 5));

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
