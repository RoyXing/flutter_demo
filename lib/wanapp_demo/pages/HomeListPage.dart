import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/constant/Constant.dart';
import 'package:flutter_demo/wanapp_demo/event/LoginEvent.dart';
import 'package:flutter_demo/wanapp_demo/event/LogoutEvent.dart';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:flutter_demo/wanapp_demo/http/HttpUtil.dart';
import 'package:flutter_demo/wanapp_demo/item/ArticleItem.dart';
import 'package:flutter_demo/wanapp_demo/utils/DataUtils.dart';
import 'package:flutter_demo/wanapp_demo/widget/EndLine.dart';
import 'package:flutter_demo/wanapp_demo/widget/SlideView.dart';
import 'dart:async';

class HomeListPage extends StatefulWidget {
  @override
  HomeListPageState createState() {
    return new HomeListPageState();
  }
}

class HomeListPageState extends State<HomeListPage> {
  List listData = new List();
  var bannerData;
  var curPage = 0;
  var listTotalSize = 0;

  ScrollController _controller = new ScrollController();
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);
  TextStyle subtitleTextStyle =
      new TextStyle(color: Colors.red, fontSize: 12.0);

  HomeListPageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && listData.length < listTotalSize) {
        getHomeArticlelist();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBanner();
    getHomeArticlelist();
    Constants.eventBus.on<LogoutEvent>().listen((event) {
      onRefresh();
    });
    Constants.eventBus.on<LoginEvent>().listen((event) {
      onRefresh();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> onRefresh() async {
    curPage = 0;
    getBanner();
    getHomeArticlelist();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      Widget listView = new ListView.builder(
        itemBuilder: (context, index) => buildItem(index),
        itemCount: listData.length + 1,
        controller: _controller,
      );
      return new RefreshIndicator(child: listView, onRefresh: onRefresh);
    }
  }

  void getHomeArticlelist() {
    String url = Api.ARTICLE_LIST;
    url += "$curPage/json";

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
    });
  }

  SlideView _bannerView;

  void getBanner() {
    String bannerUrl = Api.BANNER;
    HttpUtil.get(bannerUrl, (data) {
      if (data != null) {
        setState(() {
          bannerData = data;
          _bannerView = new SlideView(data);
        });
      }
    });
  }

  Widget buildItem(int i) {
    if (i == 0) {
      return new Container(
        height: 180.0,
        child: _bannerView,
      );
    }
    i -= 1;
    var itemData = listData[i];

    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return new EndLine();
    }

    return new ArticleItem(itemData);
  }
}
