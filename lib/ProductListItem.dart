import 'package:flutter/material.dart';

typedef Null ItemSelectedCallback(String productID);

class ProductListItem extends StatelessWidget {
  final String productID;
  final String name;
  final String photographer;
  final ItemSelectedCallback onItemSelected;

  ProductListItem(
      {this.productID, this.name, this.photographer, this.onItemSelected});

  factory ProductListItem.fromJson(Map<String, dynamic> json, callback) {
    return ProductListItem(
      productID: json['productID'],
      name: json['name'],
      photographer: json['photographer'],
      onItemSelected: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      // padding: EdgeInsets.all(8.0),
      onTap: () {
        this.onItemSelected(productID);
      },
      title: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(name, style: Theme.of(context).textTheme.title),
          new Text(photographer, style: Theme.of(context).textTheme.subhead),
          new Divider(),
        ],
      ),
    );
  }
}