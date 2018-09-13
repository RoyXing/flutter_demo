import 'package:flutter/material.dart';

class RowDemo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.red,
            padding: EdgeInsets.all(5.0),
          ),
        ),

        Expanded(
          child: Container(
            color: Colors.yellow,
            padding: EdgeInsets.all(5.0),
          ),
        ),

        Expanded(
          child: Container(
            color: Colors.blue,
            padding: EdgeInsets.all(5.0),
          ),
        )
      ],
    );
  }
}