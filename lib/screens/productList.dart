import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  getProduct() async {
    dynamic dataReceived = ModalRoute.of(context).settings.arguments;
    String url;
    if (dataReceived['category'] == 'All Products') {
      url = 'https://fakestoreapi.com/products';
    } else {
      url =
          'https://fakestoreapi.com/products/category/${dataReceived['category']}';
    }
    Response response = await get(Uri.parse("$url"));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select A Product",
          style: TextStyle(
            fontSize: 25.0,
            letterSpacing: 2.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder(
            future: getProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List response = jsonDecode(snapshot.data);
                return ListView.builder(
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey[400]),
                          height: 100.0,
                          width: MediaQuery.of(context).size.width - 20.0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              response[index]['title'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}