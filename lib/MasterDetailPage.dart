import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:framed/ProductList.dart';
import 'package:framed/ProductDescription.dart';
import 'package:framed/ProductDescriptionPage.dart';

class MasterDetailPage extends StatefulWidget {
  @override
  _MasterDetailPageState createState() => _MasterDetailPageState();
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  String selectedValue = "4";
  var isLargeScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: Theme.of(context).platform == TargetPlatform.iOS
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: <Widget>[
            new Icon(FontAwesomeIcons.images),
            Container(
                margin: EdgeInsets.only(left: 8.0),
                child: new Text('FRAMED',
                    style: TextStyle(fontFamily: 'Montserrat'))),
          ],
        ),
      ),
      body: OrientationBuilder(builder: (context, orientation) {

        if (MediaQuery.of(context).size.width > 600) {
          isLargeScreen = true;
        } else {
          isLargeScreen = false;
        }

        return Row(children: <Widget>[
          Expanded(
            child: ProductList((value) {
              if (isLargeScreen) {
                selectedValue = value;
                setState(() {});
              } else {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ProductDescriptionPage(value);
                  },
                ));
              }
            }),
          ),
          isLargeScreen ? Expanded(child: ProductDescription(selectedValue)) : Container(),
        ]);
      }),
    );
  }
}