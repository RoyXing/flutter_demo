import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:flutter_demo/wanapp_demo/http/HttpUtil.dart';
import 'package:flutter_demo/wanapp_demo/pages/LoginPage.dart';
import 'package:flutter_demo/wanapp_demo/utils/DataUtils.dart';

class ArticleItem extends StatefulWidget {
  //是否来自搜索列表
  bool isSearch;

  //搜索列表的id
  String id;

  var itemData;

  ArticleItem(var itemData) {
    this.itemData = itemData;
    this.isSearch = false;
  }

  ArticleItem.isFromSearch(var itemData, String id) {
    this.itemData = itemData;
    this.isSearch = true;
    this.id = id;
  }

  @override
  ArticleItemState createState() {
    return new ArticleItemState();
  }
}

class ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    bool isCollect = widget.itemData['collect'];

    Row row1 = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text('作者：'),
            new Text(
              widget.itemData['author'],
              style: new TextStyle(color: Theme.of(context).accentColor),
            ),
          ],
        ),

        new Text(widget.itemData['niceDate']),
      ],
    );

    Row title = new Row(
      children: <Widget>[
        new Expanded(
            child: new Text.rich(
          new TextSpan(text: widget.itemData['title']),
          softWrap: true,
          style: new TextStyle(fontSize: 16.0, color: Colors.black),
          textAlign: TextAlign.left,
        ))
      ],
    );

    Row chapterName = new Row(
      children: <Widget>[
        new Expanded(
            child: new Text(
          widget.itemData['chapterName'],
          softWrap: true,
          style: new TextStyle(color: Theme.of(context).accentColor),
          textAlign: TextAlign.left,
        )),
        new GestureDetector(
          onTap: () {
            _handleOnItemCollect(widget.itemData);
          },
          child: new Icon(
            isCollect ? Icons.favorite : Icons.favorite_border,
            color: isCollect ? Colors.red : null,
          ),
        )
      ],
    );

    Column column = new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: row1,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: chapterName,
        ),
      ],
    );

    return new Card(
      elevation: 4.0,
      child: new InkWell(
        child: column,
        onTap: () {
          _itemClick(widget.itemData);
        },
      ),
    );
  }

  void _handleOnItemCollect(itemData) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        _login();
      } else {
        _itemCollect(itemData);
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  void _itemClick(itemData) {}

  void _login() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
  }

  void _itemCollect(var itemData) {
    String url;
    if (itemData['collect']) {
      print("取消收藏");
      url = Api.UNCOLLECT_ORIGINID;
    } else {
      print("收藏");
      url = Api.COLLECT;
    }
    url += '${itemData['id']}/json';
    HttpUtil.post(url, (data) async {
      setState(() {
        itemData['collect'] = !itemData['collect'];
      });
    });
  }
}
