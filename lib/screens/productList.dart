import 'package:carnival/screens/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int selectedIndex = 0;
  onSelected(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    String men = "men's clothing";
    String women = "women's clothing";
    List<Widget> _list = [
      SafeArea(
          child: Container(
              child: Pages(
        url: 'https://fakestoreapi.com/products',
      ))),
      SafeArea(
        child: Pages(
          url: 'https://fakestoreapi.com/products/category/electronics',
        ),
      ),
      SafeArea(
          child: Container(
              child: Pages(
        url: 'https://fakestoreapi.com/products/category/jewelery',
      ))),
      SafeArea(
          child: Container(
              child: Pages(
        url: 'https://fakestoreapi.com/products/category/$men',
      ))),
      SafeArea(
          child: Container(
              child: Pages(
        url: 'https://fakestoreapi.com/products/category/$women',
      ))),
    ];
    List<String> title = [
      "All",
      "Electronics",
      "Jewelery",
      "Men's Clothing",
      "Women's Clothing",
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
                              const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
                          child: InkWell(
                            onTap: () {
                              controller.jumpToPage(index);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
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
                                    fontSize: 16.0,
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
            SliverFillRemaining(
              child: PageView(
                children: _list,
                scrollDirection: Axis.horizontal,
                controller: controller,
                onPageChanged: (index) => onSelected(index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
