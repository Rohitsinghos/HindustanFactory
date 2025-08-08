// model category
import 'dart:ui';

import 'package:flutter/material.dart';

String BASE_URL = "https://hindustanapi.mtlapi.socialseller.in/api/";

// token for test
String userToken = "";

List CourseL = [];
//vvideo data
List vddataa = [];
List<String> videoUrls = [
  "https://mtt-s3.s3.ap-south-1.amazonaws.com/1749709738560WhatsApp+Video+2025-06-12+at+11.57.44_9a59f530.mp4",
];

int addid = -1;

int cartnn = 0;

String userName = "";

bool ispremi = false;
int userid = -1;
int adrss = 0;

List colii = [[], [], [], []];

int wallet = 0;

bool isPremiium = false;
int chaddr = 0;
// "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsImlhdCI6MTc1MTAzMTg2MCwiZXhwIjoxNzUxNjM2NjYwfQ.aBjcIxMrKBqSfdw33XiB1exeZDg65cBDXbZiFQzqLt8";
// "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImlhdCI6MTc1MTI2OTMzMCwiZXhwIjoxNzUxODc0MTMwfQ.8W0xZaBPzvHWxrcQvcnwEDdMMvdURBHpOdJEjd99lu0";
int cartn = 0;

Color adth = Colors.deepOrange;

List WalletaddData = [];

String qrTexts = "";

List<int> cartIds = [];
List<int> cartCnts = [];

Color b1 = const Color.fromARGB(255, 169, 169, 169);
Color bottomback = const Color.fromARGB(255, 255, 250, 248);

// address dataa

List<dynamic> addressdata = [];

//favorite_border_outlined collections
List<int> favIds = [];

//get user data
dynamic LoginData = {};

String searchTop = "Top";

// cart datattat
Map<String, dynamic> usercartData = {};

// order data
List<Map<String, int>> orderData = [];

// register new create user
Map<String, dynamic> createData = {};

// category page 1

List<dynamic> categoData = [];

bool _isConnected = true;
bool loading = true;
// bannner data

List<dynamic> bannerData = [];

List productData4i = [];
List productData2i = [];
List productData6i = [];
List productData13i = [];

// product data alll important
List<dynamic> productData1 = [];

List<dynamic> TopData1 = [];

List<Map<String, dynamic>> productData = [];

List<Map<String, dynamic>> products = [];

List<Map<String, dynamic>> ItemsInt = [
  {'price': 100},
  {'price': 600},
  {'price': 300},
  {'price': 800},
  {'price': 100},
  {'price': 100},
  {'price': 800},
  {'price': 100},
  {'price': 100},
];

List<int> ItemsId2 = [0, 1, 2, 3, 4, 5, 6, 7, 8];
List<bool> okid = [false, false, false, true, false, false, false, true, true];

Map<String, dynamic> userData = {};

List<Map<String, int>> ItemsId = [
  {'id': 0},
  {'id': 1},
  {'id': 2},
  {'id': 3},
  {'id': 4},
  {'id': 5},
  {'id': 6},
  {'id': 7},
  {'id': 8},
];
