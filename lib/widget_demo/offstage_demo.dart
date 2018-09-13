import 'package:flutter/material.dart';

class OffstageDemo extends StatefulWidget {
  @override
  OffstageDemoState createState() {
    return new OffstageDemoState();
  }
}

class OffstageDemoState extends State<OffstageDemo> {
  bool offstage = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
//        new Offstage(
//          offstage: offstage,
//          child: Container(
//            color: Colors.blue,
//            height: 100.0,
//          ),
//        ),
//        new RaisedButton(
//          onPressed: () {
//            setState(() {
//              offstage = !offstage;
//            });
//          },
//          child: new Text('点击切换显示'),
//        ),
//        new Container(
//          color: Colors.green,
//          width: 200.0,
//          height: 200.0,
//          padding: const EdgeInsets.all(5.0),
//          child: OverflowBox(
//            alignment: Alignment.topLeft,
//            maxWidth: 500.0,
//            maxHeight: 300.0,
//            child: new Container(
//              color: Color(0x33FF00FF),
//              width: 300.0,
//              height: 400.0,
//            ),
//          ),
//        ),
//        new Container(
//          color: Colors.green,
//          padding: const EdgeInsets.all(5.0),
//          child: SizedBox(
//            width: 200.0,
//            height: 200.0,
//            child: Container(
//              color: Colors.red,
//              width: 100.0,
//              height: 300.0,
//            ),
//          ),
//        ),
        new Container(
            color: Colors.purple,
            alignment: Alignment.topRight,
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(5.0),
            child: SizedOverflowBox(
              size: Size(100.0, 200.0),
              child: Container(
                color: Colors.red,
                width: 200.0,
                height: 100.0,
              ),
            )),
        new CustomSingleChildLayout(
            delegate: FixedSizeLayoutDelegate(size:Size(200.0,200.0)),
            child: Container(
              color: Colors.red,
              width: 100.0,
              height: 300.0,
            ),
        )
      ],
    );
  }
}

class FixedSizeLayoutDelegate extends SingleChildLayoutDelegate {
  FixedSizeLayoutDelegate({this.size});
  final Size size;

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    return size;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // TODO: implement getConstraintsForChild
    return new BoxConstraints.tight(size);
  }

  @override
  bool shouldRelayout(FixedSizeLayoutDelegate oldDelegate) {
    return size != oldDelegate.size;
  }

}
