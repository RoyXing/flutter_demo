import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/pages/WanAndroidPage.dart';
import 'package:flutter_demo/widget_demo/container_demo.dart';
import 'package:flutter_demo/widget_demo/flow_demo.dart';
import 'package:flutter_demo/widget_demo/listbody_demo.dart';
import 'package:flutter_demo/widget_demo/offstage_demo.dart';
import 'package:flutter_demo/widget_demo/row_demo.dart';
import 'package:flutter_demo/widget_demo/table_demo.dart';
import 'package:flutter_demo/widget_demo/wrap_demo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new WanAndroidApp();
  }
}