import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/constant/Constant.dart';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:flutter_demo/wanapp_demo/http/HttpUtil.dart';
import 'package:flutter_demo/wanapp_demo/pages/ArticleDetailPage.dart';
import 'dart:async';
import 'package:flutter_demo/wanapp_demo/widget/EndLine.dart';

class CollectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('我的收藏'),
      ),
      body: new CollectListPage(),
    );
  }
}

class CollectListPage extends StatefulWidget {
  @override
  CollectListPageState createState() {
    return new CollectListPageState();
  }
}

class CollectListPageState extends State<CollectListPage> {
  ScrollController _controller = new ScrollController();
  List listData = new List();
  int curPage = 0;
  int totalDataSize = 0;

  @override
  void initState() {
    super.initState();
    _getCollectData();
    _controller.addListener(() {
      var maxScrollExtent = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScrollExtent == pixels && listData.length < totalDataSize) {
        _getCollectData();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Null> _pullToRefresh() async {
    curPage = 0;
    _getCollectData();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new Text("暂无数据"),
      );
    } else {
      Widget listView = new ListView.builder(
        physics: new AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => buildItem(index),
        itemCount: listData.length,
        controller: _controller,
      );
      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  Widget buildItem(int index) {
    var listItem = listData[index];

    if (index == listData.length - 1 &&
        listItem.toString() == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    Widget name = new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Text('作者：'),
              new Text(
                listItem['author'],
                style: new TextStyle(color: Theme.of(context).accentColor),
              )
            ],
          ),
          new Text(listItem['niceDate']),
        ]);

    Widget item = new Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: new Column(
        children: <Widget>[
          name,
          new Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: new Text(
              listItem['title'],
              style: new TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          new Container(
            alignment: Alignment.centerRight,
            child: new GestureDetector(
              child: new Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onTap: () {
                _handleUnCollect(listItem);
              },
            ),
          ),
        ],
      ),
    );

    return new Card(
      elevation: 4.0,
      child: new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new ArticleDetailPage(
              title: listItem['title'],
              url: listItem['link'],
            );
          }));
        },
        child: item,
      ),
    );
  }

  void _getCollectData() {
    String url;
    url = Api.COLLECT_LIST;
    url += '$curPage/json';
    HttpUtil.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;
        var _listData = map['datas'];
        totalDataSize = map['total'];
        setState(() {
          List list = new List();

          if (curPage == 0) {
            listData.clear();
          }
          curPage++;
          list.addAll(listData);
          list.addAll(_listData);

          if (totalDataSize > 0 && list.length >= totalDataSize) {
            list.add(Constants.END_LINE_TAG);
          }
          listData = list;
        });
      }
    });
  }

  void _handleUnCollect(listItem) {
    String url;
    url = Api.UNCOLLECT_LIST;
    Map<String, String> map = new Map();
    map['originId'] = listItem['originId'].toString();
    url = url + listItem['id'].toString() + "/json";
    HttpUtil.post(url, (data) {
      setState(() {
        listData.remove(listItem);
      });
    }, params: map);
  }
}
