import 'package:flutter/cupertino.dart';

class ProductDesc extends StatefulWidget {
  @override
  _ProductDescState createState() => _ProductDescState();
}

class _ProductDescState extends State<ProductDesc> {
  @override
  Widget build(BuildContext context) {
    dynamic dataReceived = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Hero(
        tag: "product",
        child: Image(
          image: NetworkImage(dataReceived['image']),
        ),
      ),
    );
  }
}
