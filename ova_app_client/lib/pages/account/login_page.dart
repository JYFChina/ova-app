import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ova_app_client/models/account/account.dart';
import 'package:ova_app_client/models/account/req_dto/account_dto.dart';
import 'package:ova_app_client/utils/http/http_code.dart';
import 'package:ova_app_client/utils/util.dart';

import 'package:ova_app_client/view_model/account/account_model.dart';
import 'package:provider/provider.dart';

/* *
 * @Author: JYF
 * @Description:   账户登陆页
 * @Date: create in 2021/5/17 15:15
 */

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _cardController = TextEditingController();
  final _passwordController = TextEditingController();
  final _smsCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLook = true;
  @override
  void dispose() {
    _cardController.dispose();
    _passwordController.dispose();
    _smsCodeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }



  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          CircleAvatar(
            child: Image.network(
              'https://www.baidu.com/img/flexible/logo/pc/result.png',
              fit: BoxFit.cover,
            ),
            maxRadius: 50,
            backgroundColor: Colors.transparent,
          ),
          SizedBox(
            height: 20.0,
          ),
          _buildLoginForm(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
//                  Navigator.push(context, MaterialPageRoute(
//                          builder: (BuildContext context) => SignupOnePage()
//                  ));
                },
                child: Text("注 册",
                    style: TextStyle(color: Colors.blue, fontSize: 18.0)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm(BuildContext context) {
    AccountModel model = Provider.of<AccountModel>(context);
    if (model.imageUrl == null) {
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        model.getImageCode();
      });
    }
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 450,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        // keyboardType: TextInputType.number,
                        autofocus: true,
                        controller: _cardController,

                        validator: (val) =>
                            (val == null || val.isEmpty) ? "账号不能为空" : null,

                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          hintText: '请输入账号',
                          hintStyle: TextStyle(color: Colors.blue.shade200),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.blue.shade400,
                      ),
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.blue),
                        autofocus: false,
//                            obscureText: isLook,
                        controller: _passwordController,
                        validator: (val) =>
                            (val == null || val.isEmpty) ? "密码不能为空" : null,
                        decoration: InputDecoration(
                          hintText: "密码",
                          hintStyle: TextStyle(color: Colors.blue.shade200),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            maxWidth: 25,
                            maxHeight: 15,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              print("点击");
//                                  setState(() {
//                                    isLook = !isLook;
//                                  });
                            },
//                                child: ImageIcon(
//                                  AssetImage(
//                                    'assets/images/${isLook ? 'unlook.png' : 'look.png'}',
//                                  ),
//                                ),
                          ),
                          suffixIconConstraints: BoxConstraints(
                            maxWidth: 18,
                            maxHeight: 15,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.blue.shade400,
                      ),
                      padding:
                          EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextField(
                              style: TextStyle(color: Colors.blue),
                              controller: _smsCodeController,
                              decoration: InputDecoration(
                                hintText: "验证",
                                hintStyle:
                                    TextStyle(color: Colors.blue.shade200),
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.add_to_home_screen,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: model.imageUrl == null
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.black12,
                                    ),
                                  )
                                : CachedNetworkImage(
                                    placeholder: (cacheImageContext, value) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.black12,
                                        ),
                                      );
                                    },
                                    imageUrl: model.imageUrl,
                                    width: 100,
                                    height: 40,
                                  ),
                            onTap: () {
                              model.getImageCode();
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: Divider(
                        color: Colors.blue.shade400,
                      ),
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text(
                              "找回密码",
                              style: TextStyle(color: Colors.black45),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue.shade600,
                child: Icon(Icons.person),
              ),
            ],
          ),
          Container(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  AccountDTO dto = AccountDTO();
                  dto.username = _cardController.text;
//                  dto.password="LFEt60GoMTj5/mQQ7HjJeA==";
                  dto.password = _passwordController.text;
                  dto.grantType = "password";
                  dto.randomStr = model.randomStr;
                  dto.code = _smsCodeController.text;
                  dto.scope = "server";
                  dto.loginType = "phone";

                  var _state = _formKey.currentState;
                  if (_state.validate()) {
                    EventBusUtil.loading();
                    model.phoneLogin(dto).then((value) {
                      EventBusUtil.notify(value?"登陆成功":"登陆失败");
                    });
                    EventBusUtil.done();
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0)),
                child: Text("登 陆", style: TextStyle(color: Colors.white70)),
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountModel>.value(
      value: AccountModel(
          randomStr: Utils.getRandomLenNum(
              4, DateTime.now().millisecondsSinceEpoch)), //2
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: _buildPageContent(context),
          );
        },
      ),
    );
  }
}
