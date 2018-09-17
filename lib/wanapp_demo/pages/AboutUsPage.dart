import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/pages/ArticleDetailPage.dart';

class AboutUsPage extends StatefulWidget {
  @override
  AboutUsPageState createState() {
    return new AboutUsPageState();
  }
}

class AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("关于"),
      ),
      body: new ListView(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        children: <Widget>[
          new Image.asset(
            "assets/ic_launcher_round.png",
            height: 100.0,
            width: 100.0,
          ),
          new ListTile(
            title: const Text("关于项目"),
            subtitle: Text("学习Flutter第一个项目，纪念一下"),
            trailing: new Icon(
              Icons.chevron_right,
              color: Theme.of(context).accentColor,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (context) {
                return new ArticleDetailPage(
                  title: 'Demo地址',
                  url: 'https://github.com/RoyXing/flutter_demo.git',
                );
              }));
            },
          ),
        ],
      ),
    );
  }
}
