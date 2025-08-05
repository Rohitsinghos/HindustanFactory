import 'dart:ui';

import 'package:template/models/categorymodel/cate.dart';

void resetModelData() {
  userToken = "";

  userid = -1;
  adrss = 0;
  wallet = 0;

  isPremiium = false;
  chaddr = 0;
  // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsImlhdCI6MTc1MTAzMTg2MCwiZXhwIjoxNzUxNjM2NjYwfQ.aBjcIxMrKBqSfdw33XiB1exeZDg65cBDXbZiFQzqLt8";
  // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImlhdCI6MTc1MTI2OTMzMCwiZXhwIjoxNzUxODc0MTMwfQ.8W0xZaBPzvHWxrcQvcnwEDdMMvdURBHpOdJEjd99lu0";
  cartn = 0;

  qrTexts = "";

  cartIds = [];
  cartCnts = [];

  b1 = const Color.fromARGB(255, 169, 169, 169);
  bottomback = const Color.fromARGB(255, 255, 250, 248);

  // address dataa

  addressdata = [];

  //favorite_border_outlined collections
  favIds = [];

  //get user data
  LoginData = {};

  searchTop = "Top";

  // cart datattat
  usercartData = {};

  // order data
  orderData = [];

  // register new create user

  loading = true;
  // bannner data
}
