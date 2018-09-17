import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_demo/wanapp_demo/pages/ArticleListPage.dart';

class ArticlesPage extends StatefulWidget {
  var data;

  ArticlesPage(this.data);

  @override
  ArticlesPageState createState() {
    return new ArticlesPageState();
  }
}

class ArticlesPageState extends State<ArticlesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabs = new List();
  List<dynamic> list;

  @override
  void initState() {
    super.initState();
    list = widget.data['children'];
    for (var value in list) {
      tabs.add(new Tab(
        text: value['name'],
      ));
    }
    _tabController = new TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.data['name']),
      ),
      body: new DefaultTabController(
        length: list.length,
        child: new Scaffold(
          appBar: new TabBar(
            tabs: tabs,
            isScrollable: true,
            controller: _tabController,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.black,
            indicatorColor: Theme.of(context).accentColor,
          ),
          body: new TabBarView(
            children: list.map((item){
              return new ArticleListPage(item['id'].toString());
            }).toList(),
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
