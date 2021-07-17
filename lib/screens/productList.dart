import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
      backgroundColor: Color(0xFF333333),
      body: SafeArea(
        child: FutureBuilder(
            future: getProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List response = jsonDecode(snapshot.data);
                return AnimationLimiter(
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    itemCount: response.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: Duration(seconds: 2),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  // Text("Test Message"),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/productdesc', arguments: {"image": response[index]['image'], "index": index});
                                    },
                                    child: Hero(
                                      tag: "product$index",
                                      child: Image(
                                        image: NetworkImage(
                                            response[index]['image']),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text("Test Message lets see"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 8.0,
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}