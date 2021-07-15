import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatelessWidget {
  getProduct() async {
    Response response =
        await get(Uri.parse("https://fakestoreapi.com/products/categories"));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select A Category",
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
                response.add("All Products");
                return ListView.builder(
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/productlist', arguments: {"category": response[index]});
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[400]),
                            height: 70.0,
                            width: MediaQuery.of(context).size.width - 20.0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                response[index].toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  letterSpacing: 1.2,
                                ),
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
