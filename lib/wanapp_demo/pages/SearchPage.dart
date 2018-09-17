import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/pages/HotPage.dart';
import 'package:flutter_demo/wanapp_demo/pages/SearchListPage.dart';

class SearchPage extends StatefulWidget {
  String searchStr;

  SearchPage(this.searchStr);

  @override
  SearchPageState createState() {
    return new SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  TextEditingController _searchController;

  SearchListPage _searchListPage;

  @override
  void initState() {
    super.initState();
    _searchController = new TextEditingController(text: widget.searchStr);
    changeContent();
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      autofocus: true,
      decoration:
          new InputDecoration(border: InputBorder.none, hintText: "搜索关键词"),
      controller: _searchController,
    );
    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: () {
              changeContent();
            },
          ),
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () {
              setState(() {
                _searchController.clear();
              });
            },
          ),
        ],
      ),
      body: (_searchController.text == null || _searchController.text.isEmpty)
          ? new Center(
              child: new HotPage(),
            )
          : _searchListPage,
    );
  }

  void changeContent() {
    setState(() {
      _searchListPage =
          new SearchListPage(new ValueKey(_searchController.text));
    });
  }
}
