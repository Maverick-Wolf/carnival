import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDesc extends StatefulWidget {
  @override
  _ProductDescState createState() => _ProductDescState();
}

class _ProductDescState extends State<ProductDesc> {
  bool isVisible = true;
  bool isVisible2 = false;
  void toggleButton() {
    setState(() {
      isVisible = !isVisible;
      isVisible2 = !isVisible2;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic dataReceived = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            "${dataReceived['title']}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          // backwardsCompatibility: true,
          backgroundColor: Colors.white,
        ),
      ),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: Colors.white,
          // height: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: "product${dataReceived['index']}",
                    child: Image(
                      height: (MediaQuery.of(context).size.height / 2) - 40.0,
                      width: (MediaQuery.of(context).size.width / 2) - 10.0,
                      image: NetworkImage(dataReceived['image']),
                    ),
                  ),
                  Visibility(
                    visible: isVisible2,
                    child: Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.favorite_rounded),
                          onPressed: () {
                            toggleButton();
                          }),
                    ),
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Positioned(
                      top: 0.0,
                      right: 5.0,
                      child: IconButton(
                          color: Colors.red,
                          icon: Icon(Icons.favorite_outline_rounded),
                          onPressed: () {
                            toggleButton();
                          }),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                "\$${dataReceived['price']}",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                child: Text(
                  "${dataReceived['desc']}",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xFFFFA41C)),
                width: MediaQuery.of(context).size.width - 30.0,
                height: 40.0,
                child: Center(
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xFFFFD814)),
                width: MediaQuery.of(context).size.width - 30.0,
                height: 40.0,
                child: Center(
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
