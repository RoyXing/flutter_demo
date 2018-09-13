import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/constant/Constant.dart';
import 'package:flutter_demo/wanapp_demo/event/LoginEvent.dart';
import 'package:flutter_demo/wanapp_demo/event/LogoutEvent.dart';
import 'package:flutter_demo/wanapp_demo/pages/AboutUsPage.dart';
import 'package:flutter_demo/wanapp_demo/pages/CollectPage.dart';
import 'package:flutter_demo/wanapp_demo/pages/LoginPage.dart';
import 'package:flutter_demo/wanapp_demo/utils/DataUtils.dart';

class MyInfoPage extends StatefulWidget {
  @override
  MyInfoPageState createState() {
    return new MyInfoPageState();
  }
}

class MyInfoPageState extends State<MyInfoPage> {
  String userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getName();
    Constants.eventBus.on<LoginEvent>().listen((event) {
      _getName();
    });
  }

  void _getName() async {
    DataUtils.getUserName().then((userName) {
      setState(() {
        this.userName = userName;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget image = new Image.asset(
      "assets/ic_launcher_round.png",
      width: 100.0,
      height: 100.0,
    );

    Widget raiseButton = new RaisedButton(
      onPressed: () async {
        await DataUtils.isLogin().then((isLogin) {
          if (!isLogin) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => new LoginPage()));
          }
        });
      },
      child: new Text(
        userName == null ? "请登录" : userName,
        style: new TextStyle(color: Colors.white),
      ),
      color: Theme.of(context).accentColor,
    );

    Widget listLike = new ListTile(
      leading: new Icon(Icons.favorite),
      title: const Text('喜欢的文章'),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).accentColor,
      ),
      onTap: () async {
        await DataUtils.isLogin().then((isLogin) {
          if (isLogin) {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) {
              return new CollectPage();
            }));
          } else {
            print('已登录!');
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (context) {
              return new LoginPage();
            }));
          }
        });
      },
    );

    Widget listAbout = new ListTile(
      leading: new Icon(Icons.share),
      title: new Text('关于我们'),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).accentColor,
      ),
      onTap: () {
        Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) => new AboutUsPage()));
      },
    );

    Widget listLogout = new ListTile(
      leading: new Icon(Icons.info),
      title: new Text('退出登录'),
      trailing: Icon(
        Icons.chevron_right,
        color: Theme.of(context).accentColor,
      ),
      onTap: () {
        DataUtils.clearLoginInfo();
        Constants.eventBus.fire(new LogoutEvent());
        setState(() {
          userName = null;
        });
      },
    );

    return new ListView(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      children: <Widget>[
        image,
        raiseButton,
        listLike,
        listAbout,
        listLogout,
      ],
    );
  }
}
