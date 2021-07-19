import 'package:carnival/screens/home.dart';
import 'package:carnival/screens/productDesc.dart';
import 'package:carnival/screens/productList.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Home(),
      '/productlist': (context) => ProductList(),
      '/productdesc': (cobtext) => ProductDesc(),
    },
  ));
}
