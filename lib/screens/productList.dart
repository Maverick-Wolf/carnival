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
    Map respo = ModalRoute.of(context).settings.arguments;
    String title = respo['category'].toString();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text(
            "${title.toUpperCase()}",
            style: TextStyle(
              fontSize: 17.5,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
      ),
      backgroundColor: Colors.grey[200],
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
                        duration: Duration(milliseconds: 1500),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/productdesc',
                                      arguments: {
                                        "image": response[index]['image'],
                                        "index": index,
                                        "title": response[index]['title'],
                                        "price": response[index]['price'],
                                        "desc": response[index]['description'],
                                      });
                                },
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: "product$index",
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        child: Image(
                                          image: NetworkImage(
                                              response[index]['image']),
                                        ),
                                      ),
                                    ),
                                    Text("test"),
                                  ],
                                ),
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
