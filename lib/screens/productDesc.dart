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
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0.0,
          // backwardsCompatibility: true,
          backgroundColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              // height: 200.0,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Hero(
                          tag: "product${dataReceived['index']}",
                          child: Image(
                            height:
                                (MediaQuery.of(context).size.height / 2) - 55.0,
                            width:
                                (MediaQuery.of(context).size.width / 2) - 27.0,
                            image: NetworkImage(dataReceived['image']),
                          ),
                        ),
                        Visibility(
                          visible: isVisible2,
                          child: Positioned(
                            top: 0.0,
                            right: 5.0,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
