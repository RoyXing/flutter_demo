import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:flutter_demo/wanapp_demo/http/HttpUtil.dart';
import 'package:flutter_demo/wanapp_demo/pages/ArticleDetailPage.dart';
import 'package:flutter_demo/wanapp_demo/pages/SearchPage.dart';

class HotPage extends StatefulWidget {
  @override
  HotPageState createState() {
    return new HotPageState();
  }
}

class HotPageState extends State<HotPage> {
  List<Widget> hotKeyWights = new List();
  List<Widget> friendWights = new List();

  @override
  void initState() {
    super.initState();
    _getFriend();
    _getHotKey();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: new Text(
            '大家都在搜',
            style: new TextStyle(
                color: Theme.of(context).accentColor, fontSize: 20.0),
          ),
        ),
        new Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: hotKeyWights,
        ),
        new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Text('常用网站',
                style: new TextStyle(
                    color: Theme.of(context).accentColor, fontSize: 20.0))),
        new Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: friendWights,
        ),
      ],
    );
  }

  void _getFriend() {
    HttpUtil.get(Api.FRIEND, (datas) {
      setState(() {
        friendWights.clear();
        for (var itemData in datas) {
          Widget actionChip = new ActionChip(
            backgroundColor: Theme.of(context).accentColor,
            label: new Text(
              itemData['name'],
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: () {
              itemData['title'] = itemData['name'];
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new ArticleDetailPage(
                  title: itemData['title'],
                  url: itemData['link'],
                );
              }));
            },
          );
          friendWights.add(actionChip);
        }
      });
    });
  }

  void _getHotKey() {
    HttpUtil.get(Api.HOTKEY, (data) {
      setState(() {
        hotKeyWights.clear();
        for (var itemData in data) {
          Widget actionChip = new ActionChip(
            backgroundColor: Theme.of(context).accentColor,
            label: new Text(
              itemData['name'],
              style: new TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(new MaterialPageRoute(builder: (context) {
                return new SearchPage(itemData['name']);
              }));
            },
          );
          hotKeyWights.add(actionChip);
        }
      });
    });
  }
}
