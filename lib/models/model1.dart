import 'package:flutter/material.dart';

class Userdata {
  final int id;
  final String name;
  Userdata({
    required this.id,
    required this.name,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) {
    return Userdata(
      id: json['id'],
      name: json['firstName'],
    );
  }
}

class categoData1 {
  final int id;
  final String name;
  final String image;

  static var length;
  categoData1({
    required this.id,
    required this.name,
    required this.image,
  });

  factory categoData1.fromJson(Map<String, dynamic> json) {
    return categoData1(
      id: json['id'],
      name: json['name'],
      image: json['thumbnail']['url'],
    );
  }
}
