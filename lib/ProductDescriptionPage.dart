import 'package:flutter/material.dart';
import 'package:framed/ProductDescription.dart';

class ProductDescriptionPage extends StatefulWidget {

  final String data;

  ProductDescriptionPage(this.data);

  @override
  _ProductDescriptionPageState createState() => _ProductDescriptionPageState();
}

class _ProductDescriptionPageState extends State<ProductDescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          title: new Text('Item Details',
              style: TextStyle(fontFamily: 'Montserrat'))),
      body: ProductDescription(widget.data),
    );
  }
}