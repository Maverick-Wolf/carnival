import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  getFuture() {
    return FutureBuilder(
        future: getProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List response = jsonDecode(snapshot.data);
            return AnimationLimiter(
              child: SliverStaggeredGrid.countBuilder(
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
                                    borderRadius: BorderRadius.circular(12.0),
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
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  int selectedIndex = 0;
  onSelected(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    List<String> title = [
      "All",
      "Electronics",
      "Jewelery",
      "Men's Clothing",
      "Womens's Clothing",
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              title: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: title.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                          child: InkWell(
                            onTap: () => onSelected(index),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: selectedIndex != null &&
                                        selectedIndex == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              child: Center(
                                child: Text(
                                  "${title[index]}",
                                  style: TextStyle(
                                    color: selectedIndex != null &&
                                            selectedIndex == index
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              floating: true,
              expandedHeight: 70.0,
            ),
            getFuture(),
          ],
        ),
      ),
    );
  }
}
