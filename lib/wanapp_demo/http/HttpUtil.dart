import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_demo/wanapp_demo/http/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUtil {
  static const String GET = 'get';
  static const String POST = 'post';

  static void get(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = Api.BaseUrl + url;
    }

    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });

      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }

    await _request(url, callback,
        method: GET,
        headers: headers,
        params: null,
        errorCallback: errorCallback);
  }

  static void post(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = Api.BaseUrl + url;
    }

    await _request(url, callback,
        method: POST,
        headers: headers,
        params: params,
        errorCallback: errorCallback);
  }

  static Future _request(String url, Function callback,
      {String method,
      Map<String, String> headers,
      Map<String, String> params,
      Function errorCallback}) async {
    String errorMsg;
    int errorCode;
    var data;
    try {
      Map<String, String> headerMap = headers == null ? new Map() : headers;
      Map<String, String> paramsMap = params == null ? new Map() : params;

      SharedPreferences sp = await SharedPreferences.getInstance();
      String cookie = sp.get("cookie");
      if (cookie == null || cookie.length == 0) {
      } else {
        headerMap['cookie'] = cookie;
      }

      http.Response response;
      if (POST == method) {
        print("POST:URL=" + url);
        print("POST:BODY=" + paramsMap.toString());
        response = await http.post(url, headers: headerMap, body: paramsMap);
      } else {
        print("GET:URL=" + url);
        response = await http.get(url, headers: headerMap);
      }

      print("statusCode=" + response.statusCode.toString());

      if (response.statusCode < 200 || response.statusCode >= 400) {
        errorMsg = "网络请求错误,状态码:" + response.statusCode.toString();
        _handleError(errorCallback, errorMsg);
        return;
      }

      Map<String, dynamic> map = json.decode(response.body);
      errorCode = map['errorCode'];
      errorMsg = map['errorMsg'];
      data = map['data'];

      print(response.headers.toString());
      if (url.contains(Api.LOGIN) || url.contains(Api.REGISTER)) {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("cookie", response.headers['set-cookie']);
      }

      if (callback != null) {
        if (errorCode >= 0) {
          callback(data);
        } else {
          _handleError(errorCallback, errorMsg);
        }
      } else {
        _handleError(errorCallback, errorMsg);
      }
    } catch (exception) {
      _handleError(errorCallback, errorMsg);
    }
  }

  static void _handleError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("errorMsg:" + errorMsg);
  }
}
