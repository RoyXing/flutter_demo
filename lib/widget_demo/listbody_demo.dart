import 'package:flutter/material.dart';

class ListBodyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Flex(
      direction: Axis.vertical,
      children: <Widget>[
        ListBody(
          mainAxis: Axis.vertical,
          reverse: false,
          children: <Widget>[
            Container(
              color: Colors.red,
              width: 50.0,
              height: 50.0,
            ),
            Container(
              color: Colors.yellow,
              width: 50.0,
              height: 50.0,
            ),
            Container(
              color: Colors.green,
              width: 50.0,
              height: 50.0,
            ),
            Container(
              color: Colors.blue,
              width: 50.0,
              height: 50.0,
            ),
            Container(
              color: Colors.black,
              width: 50.0,
              height: 50.0,
            ),
          ],
        )
      ],
    );
  }
}
