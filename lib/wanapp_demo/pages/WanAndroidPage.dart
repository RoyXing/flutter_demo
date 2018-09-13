import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/constant/AppColors.dart';
import 'package:flutter_demo/wanapp_demo/pages/HomeListPage.dart';
import 'package:flutter_demo/wanapp_demo/pages/MyInfoPage.dart';
import 'package:flutter_demo/wanapp_demo/pages/TreePage.dart';

class WanAndroidApp extends StatefulWidget {
  @override
  WanAndroidAppState createState() {
    return new WanAndroidAppState();
  }
}

class WanAndroidAppState extends State<WanAndroidApp> {
  int _tabIndex = 0;

  List<BottomNavigationBarItem> _navigationViews;

  var appBarTitles = ['首页', '发现', '我的'];

  var _body;

  initData() {
    _body = new IndexedStack(
      children: <Widget>[new HomeListPage(), new TreePage(), new MyInfoPage()],
      index: _tabIndex,
    );
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _navigationViews = <BottomNavigationBarItem>[
      new BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text(appBarTitles[0]),
          backgroundColor: Colors.red),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.widgets),
          title: new Text(appBarTitles[1]),
          backgroundColor: Colors.red),
      new BottomNavigationBarItem(
          icon: new Icon(Icons.person),
          title: new Text(appBarTitles[2]),
          backgroundColor: Colors.red),
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();

    return new MaterialApp(
      navigatorKey: navigatorKey,
      theme: new ThemeData(
          primaryColor: AppColors.colorPrimary, accentColor: Colors.red),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            appBarTitles[_tabIndex],
            style: new TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.search), onPressed: null),
          ],
        ),
        body: _body,
        bottomNavigationBar: new BottomNavigationBar(
          items:
              _navigationViews.map((BottomNavigationBarItem b) => b).toList(),
          currentIndex: _tabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }
}
