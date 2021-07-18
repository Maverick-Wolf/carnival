import 'package:carnival/screens/home.dart';
import 'package:carnival/screens/productDesc.dart';
import 'package:carnival/screens/productList.dart';
import 'package:carnival/screens/productList2.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => ProductList2(),
      '/productlist': (context) => ProductList(),
      '/productdesc': (cobtext) => ProductDesc(),
    },
  ));
}
