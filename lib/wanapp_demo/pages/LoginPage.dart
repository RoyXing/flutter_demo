import 'package:flutter/material.dart';
import 'package:flutter_demo/wanapp_demo/constant/Constant.dart';
import 'package:flutter_demo/wanapp_demo/event/LoginEvent.dart';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:flutter_demo/wanapp_demo/http/HttpUtil.dart';
import 'package:flutter_demo/wanapp_demo/utils/DataUtils.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _nameController =
      new TextEditingController(text: 'xingzy');

  TextEditingController _pwdController =
      new TextEditingController(text: '123456');

  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scaffoldKey = new GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    Row avator = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Icon(
          Icons.account_circle,
          color: Theme.of(context).accentColor,
          size: 80.0,
        ),
      ],
    );

    TextField name = new TextField(
      autofocus: true,
      decoration:
          new InputDecoration(icon: Icon(Icons.person), labelText: '用户名'),
      controller: _nameController,
    );

    TextField password = new TextField(
      autofocus: true,
      decoration:
          new InputDecoration(icon: Icon(Icons.vpn_key), labelText: '密码'),
      controller: _pwdController,
    );

    Row loginAndRegister = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new RaisedButton(
          onPressed: () {
            _login();
          },
          child: new Text(
            '登录',
            style: new TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).accentColor,
          disabledColor: Colors.red,
          textColor: Colors.white,
        ),
        new RaisedButton(
          onPressed: () {
            _register();
          },
          child: new Text(
            '注册',
            style: new TextStyle(color: Colors.white),
          ),
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
          disabledColor: Colors.red,
        )
      ],
    );

    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('登录'),
      ),
      body: new Padding(
        padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
        child: new ListView(
          children: <Widget>[
            avator,
            name,
            password,
            new Padding(padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0)),
            loginAndRegister
          ],
        ),
      ),
    );
  }

  void _login() {
    String name = _nameController.text;
    String password = _pwdController.text;
    if (name.length == 0) {
      _showMessage("请输入用户名");
      return;
    }
    if (password.length == 0) {
      _showMessage("请输入密码");
      return;
    }

    Map<String, String> map = new Map();
    map['username'] = name;
    map['password'] = password;
    HttpUtil.post(
        Api.LOGIN,
        (data) async {
          DataUtils.saveLoginInfo(name).then((r) {
            Constants.eventBus.fire(new LoginEvent());
            Navigator.of(context).pop();
          });
        },
        params: map,
        errorCallback: (msg) {
          _showMessage(msg);
        });
  }

  void _register() {
    String name = _nameController.text;
    String password = _pwdController.text;
    if (name.length == 0) {
      _showMessage("请输入用户名");
      return;
    }
    if (password.length == 0) {
      _showMessage("请输入密码");
      return;
    }

    Map<String, String> map = new Map();
    map['username'] = name;
    map['password'] = password;
    map['repassword'] = password;

    HttpUtil.post(
        Api.REGISTER,
        (data) async {
          DataUtils.saveLoginInfo(name).then((r) {
            Constants.eventBus.fire(new LoginEvent());
            Navigator.of(context).pop();
          });
        },
        params: map,
        errorCallback: (msg) {
          _showMessage(msg);
        });
  }

  void _showMessage(String s) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(s)));
  }
}
