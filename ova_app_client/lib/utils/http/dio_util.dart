import 'dart:io';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ova_app_client/config/env_config.dart';
import 'package:ova_app_client/config/http_config.dart';

import 'dart:collection';

import 'package:ova_app_client/utils/http/http_code.dart';
import 'package:ova_app_client/utils/storage_manager.dart';

///http请求管理类，可单独抽取出来
class HttpRequest {
  static String _baseUrl = EnvConfig.apiHost;
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
  static Map optionParams = {
    "timeoutMs": 15000,
    "token": null,
    "authorizationCode": null,
  };

  static setBaseUrl(String baseUrl) {
    _baseUrl = baseUrl;
  }

  static get(url, {param}) async {
    return await request(
        _baseUrl + url, param, null, new Options(method: "GET"));
  }

  static post(url, {param}) async {
    return await request(
        _baseUrl + url,
        param,
        {'Accept': 'application/json, text/plain, */*'},
        new Options(method: 'POST'));
  }

  static delete(url, param) async {
    return await request(
        _baseUrl + url, param, null, new Options(method: 'DELETE'));
  }

  static put(url, param) async {
    return await request(_baseUrl + url, param, null,
        new Options(method: "PUT", contentType: "${ContentType.text}"));
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  static request(url, params, Map<String, String> header, Options option,
      {noTip = false}) async {
    //没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResponseData(
          Code.errorHandleFunction(Code.NETWORK_ERROR, "", noTip),
          false,
          Code.NETWORK_ERROR);
    }

    Map<String, String> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    //授权码

    var authorizationCode = await getAuthorization();
    if (authorizationCode != null) {
      optionParams["authorizationCode"] = authorizationCode;
    }

    headers["Authorization"] = optionParams["authorizationCode"];
    // 设置 baseUrl

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    ///超时
    option.sendTimeout = 15000;

    Dio dio = new Dio();
    // 添加拦截器
    if (HttpConfig.DEBUG) {
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        print("\n================== 请求数据 ==========================");
        print("url = ${options.uri.toString()}");
        print("headers = ${options.headers}");
        print("params = ${options.data}");
      }, onResponse: (Response response) {
        print("\n================== 响应数据 ==========================");
        print("code = ${response.statusCode}");
        print("data = ${response.data}");
        print("\n");
      }, onError: (DioError e) {
        print("\n================== 错误响应数据 ======================");
        print("type = ${e.type}");
        print("message = ${e.message}");
        print("stackTrace = ${e.error}");
        print("\n");
      }));
    }

    Response response;

    try {
      response = await dio.request(url,
          data: params, queryParameters: params, options: option);
    } on DioError catch (e) {
      // 请求错误处理
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (HttpConfig.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常 url: ' + url);
      }

      return new ResponseData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message, noTip),
          false,
          errorResponse.statusCode);
    }

    try {
      if (option.contentType != null) {
        return new ResponseData(response.data, true, Code.SUCCESS);
      } else {
        var responseJson = response.data;
        if (response.statusCode == 200 &&
            responseJson["access_token"] != null) {
          StorageManager.sharedPreferences
              .setString(HttpConfig.TOKEN_KEY, responseJson["access_token"]);
        }
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ResponseData(response.data, true, Code.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      print(e.toString() + url);
      return ResponseData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    return new ResponseData(
        Code.errorHandleFunction(response.statusCode, "", noTip),
        false,
        response.statusCode);
  }

  ///清除授权
  static clearAuthorization() {
    optionParams["authorizationCode"] = null;
    StorageManager.sharedPreferences.remove(HttpConfig.TOKEN_KEY);
  }

  ///获取授权token
  static getAuthorization() async {
    try {
      String token =
          StorageManager.sharedPreferences.getString(HttpConfig.TOKEN_KEY);
      if (token == null) {
        String basic = HttpConfig.USER_BASIC_CODE;
        if (basic == null) {
          //提示输入账号密码
        } else {
          //通过 basic 去获取token，获取到设置，返回token
          return "$basic";
        }
      } else {
        optionParams["authorizationCode"] = "Bearer " + token;
        return "Bearer " + token;
      }
    } catch (e) {
      return HttpConfig.USER_BASIC_CODE;
    }
  }
}

/* *
  * 网络结果数据
  * Date: 2018-07-16
  */
class ResponseData<T> {
  int code;
  String msg;
  var jsonData;//为转换的json数据
  T data;//转换成对象的可用数据
  bool result;
  var headers;

  ResponseData(this.jsonData, this.result, this.code, {this.headers, this.msg,this.data});
}
