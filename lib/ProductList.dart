import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:framed/ProductListItem.dart';

typedef Null ItemSelectedCallback(String productID);

class ProductList extends StatefulWidget {
  final ItemSelectedCallback onItemSelected;

  ProductList(this.onItemSelected);

  @override
  State createState() => new ProductListState();
}

class ProductListState extends State<ProductList> {
  Future<List<ProductListItem>> _products;

  Future<List<ProductListItem>> fetchItemList() async {
    List<ProductListItem> _items = <ProductListItem>[];
    final response =
        await http.get('https://framed.noahscholfield.com/item/info.php');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      var itemsJson = json.decode(response.body)['items'];
      itemsJson.forEach((item) =>
          _items.add(ProductListItem.fromJson(item, widget.onItemSelected)));

      return _items;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    _products = fetchItemList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductListItem>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: snapshot.data.length,
              itemBuilder: (_, int index) => snapshot.data[index],
            );
          } else if (snapshot.hasError) {
            return new Text('${snapshot.error}');
          } else {
            return Container(
                child: Center(child: new CircularProgressIndicator()));
          }
        });
  }
}
