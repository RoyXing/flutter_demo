import 'package:flutter/material.dart';
import 'package:flutter_demo/container_demo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "flutter demo",
     home: new Scaffold(
       appBar: new AppBar(
         title: new Text('flutter demo'),
       ),
       body: new ContainerDemo(),
     ),
    );
  }
}