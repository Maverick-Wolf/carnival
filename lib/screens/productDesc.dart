import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDesc extends StatefulWidget {
  @override
  _ProductDescState createState() => _ProductDescState();
}

class _ProductDescState extends State<ProductDesc> {
  @override
  Widget build(BuildContext context) {
    dynamic dataReceived = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 200.0,
              child: Hero(
                tag: "product${dataReceived['index']}",
                child: Image(
                  image: NetworkImage(dataReceived['image']),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
