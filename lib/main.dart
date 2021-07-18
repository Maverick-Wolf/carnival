import 'package:carnival/screens/productDesc.dart';
import 'package:carnival/screens/productList.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => ProductList(),
      '/productdesc': (cobtext) => ProductDesc(),
    },
  ));
}
