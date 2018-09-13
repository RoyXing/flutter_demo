import 'package:flutter/material.dart';

class WrapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900,
            child: new Text(
              'AH',
              style: TextStyle(fontSize: 10.0),
            ),
          ),
          label: Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: new Text(
                'ML',
                style: TextStyle(fontSize: 10.0),
              )),
          label: Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: new Text(
                'HM',
                style: TextStyle(fontSize: 10.0),
              )),
          label: Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: new Text(
                'JL',
                style: TextStyle(fontSize: 10.0),
              )),
          label: Text('Laurens'),
        ),
      ],
    );
  }
}
