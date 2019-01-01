import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:framed/ProductInfo.dart';

class ProductDescription extends StatefulWidget {
  final String id;

  ProductDescription(this.id);

  @override
  State createState() => new ProductDescriptionState();
}

class ProductDescriptionState extends State<ProductDescription> {
  Future<ProductInfo> _productInfo;
  bool firstRun = true;

  Future<ProductInfo> fetchInfo() async {
    final response = await http
        .get('https://framed.noahscholfield.com/item/info.php?id=${widget.id}');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return ProductInfo.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    _productInfo = fetchInfo();
    firstRun = false;
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Prevent fetchInfo from running twice for page version
    if(!firstRun) {
      _productInfo = fetchInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: FutureBuilder<ProductInfo>(
          future: _productInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView(
                children: <Widget>[
                  new Text(snapshot.data.name,
                      style: Theme.of(context).textTheme.display2),
                  new Text(snapshot.data.photographer,
                      style: Theme.of(context).textTheme.display1),
                  new Divider(),
                  new Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: new Image.network(snapshot.data.imageURL)),
                  new Text(snapshot.data.description,
                      style: TextStyle(fontSize: 20))
                ],
              );
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            } else {
              return new Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
