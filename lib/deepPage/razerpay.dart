import 'dart:convert';

import 'package:template/models/categorymodel/cate.dart';
import 'package:template/profilePages/Orders.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazerPay extends StatefulWidget {
  final int money;
  final Color adth;
  const RazerPay({required this.money, required this.adth});

  @override
  State<RazerPay> createState() => _RazerPayState();
}

class _RazerPayState extends State<RazerPay> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_X862k3ZFG0a9mY', // ✅ Put your Razorpay TEST key here
      'amount': widget.money * 100, // 100 rupees in paise
      'name': 'Hindustan Factory',
      'description': 'Test Payment',
      'prefill': {
        'contact': (userData != null) ? userData["phone"] : '9123456789',
        'email': 'demo@razorpay.com',
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('❗ Razorpay open error: $e');
      Navigator.pop(context);
    }
  }

  Future<void> _verifyPay() async {
    try {
      final res = await http.post(
        Uri.parse("${BASE_URL}razorpay/verify"),
        headers: {'Authorization': "Bearer ${userToken}"},
        body: jsonEncode({
          "razorpay_order_id": "order_QnPBm5V65GDTLy",
          "razorpay_payment_id": "pay_QnPFCRqO9mH8OB",
          "razorpay_signature":
              "7901628360502ef72c002c842496b6bfca229c4a1fc2ad0b42da709333652823",
        }),
      );
      print(res.body);
      if (!mounted) return; // prevents calling setState if widget is disposed

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("✅ SUCCESS: ${response.paymentId}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("✅ Payment Successful: ${response.paymentId}")),
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersPage(adth: widget.adth, page: 0),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("❌ ERROR: ${response.code} | ${response.message}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ Payment Failed: ${response.message}")),
    );
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("💼 WALLET: ${response.walletName}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("💼 External Wallet: ${response.walletName}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    openCheckout();
    return Scaffold(
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: ,
      //     child: Text("Pay ₹${widget.money}"),
      //   ),
      // ),
    );
  }
}
