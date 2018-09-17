import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/constant/Constant.dart';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:flutter_demo/wanapp_demo/http/HttpUtil.dart';
import 'package:flutter_demo/wanapp_demo/item/ArticleItem.dart';
import 'dart:async';

import 'package:flutter_demo/wanapp_demo/widget/EndLine.dart';

class ArticleListPage extends StatefulWidget {
  var id;

  ArticleListPage(this.id);

  @override
  ArticleListPageState createState() {
    return new ArticleListPageState();
  }
}

class ArticleListPageState extends State<ArticleListPage> {
  int curPage = 0;
  List listData = new List();
  int listTotalSize = 0;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getArticleList();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        _getArticleList();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.isEmpty) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemBuilder: (context, i) => buildItem(i),
        itemCount: listData.length,
        controller: _controller,
        key: new PageStorageKey(widget.id),
      );

      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _getArticleList() {
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";
    Map<String, String> map = new Map();
    map['cid'] = widget.id;
    HttpUtil.get(url, (data) {
      if (data != null) {
        Map<String, dynamic> map = data;
        var _listData = map['datas'];
        listTotalSize = map['total'];

        setState(() {
          List list = new List();
          if (curPage == 0) {
            listData.clear();
          }
          curPage++;
          list.addAll(listData);
          list.addAll(_listData);
          if (list.length >= listTotalSize) {
            list.add(Constants.END_LINE_TAG);
          }
          listData = list;
        });
      }
    }, params: map);
  }

  Future _pullToRefresh() async {
    curPage = 0;
    _getArticleList();
  }

  Widget buildItem(int i) {
    var itemData = listData[i];
    if (i == listData.length - 1 &&
        itemData.toString() == Constants.END_LINE_TAG) {
      return new EndLine();
    }
    return new ArticleItem(itemData);
  }
}
