import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/constant/Constant.dart';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:flutter_demo/wanapp_demo/http/HttpUtil.dart';
import 'package:flutter_demo/wanapp_demo/item/ArticleItem.dart';
import 'package:flutter_demo/wanapp_demo/widget/EndLine.dart';

class SearchListPage extends StatefulWidget {

  SearchListPage(ValueKey<String> key) : super(key: key) {
    this.id = key.value.toString();
  }

//  SearchListPage(this.id);

  String id;

  @override
  SearchListPageState createState() {
    return new SearchListPageState();
  }
}

class SearchListPageState extends State<SearchListPage> {
  int curPage = 0;
  List listData = new List();
  int listTotalSize = 0;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _articleQuery();
    _scrollController.addListener(() {
      var scrollExtent = _scrollController.position.maxScrollExtent;
      var pixels = _scrollController.position.pixels;

      if (scrollExtent == pixels && listData.length < listTotalSize) {
        _articleQuery();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null || listData.length <= 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemBuilder: (context, index) => buildItem(index),
        itemCount: listData.length,
        controller: _scrollController,
      );

      return new RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

  void _articleQuery() {
    String url = Api.ARTICLE_QUERY;
    url += "$curPage/json";
    Map<String, String> map = new Map();
    map['k'] = widget.id;
    HttpUtil.post(url, (data) {
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

          if (listTotalSize > 0 && list.length >= listTotalSize) {
            list.add(Constants.END_LINE_TAG);
          }

          listData = list;
        });
      }
    }, params: map);
  }

  Widget buildItem(int index) {
    var listItem = listData[index];
    if (index == listData.length - 1 &&
        listItem.toString() == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    return new ArticleItem.isFromSearch(listItem, widget.id);
  }

  Future<void> _pullToRefresh() async {
    curPage = 0;
    _articleQuery();
  }
}
