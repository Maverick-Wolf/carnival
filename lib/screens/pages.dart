import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';

class Pages extends StatelessWidget {
  final String url;
  Pages({this.url});
  @override
  Widget build(BuildContext context) {
    getProduct() async {
      Response response = await get(Uri.parse("$url"));
      return response.body;
    }

    getFuture() {
      double height = MediaQuery.of(context).size.height / 2 - 60.0;
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
                      duration: Duration(seconds: 2),
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
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        7.0, 5.0, 7.0, 5.0),
                                    child: Center(
                                        child: Text(
                                            "${response[index]['title']}")),
                                  ),
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
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, height, 0.0, height),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(),
              getFuture(),
            ],
          ),
        ),
      ),
    );
  }
}
