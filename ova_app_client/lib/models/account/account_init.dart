import 'package:flutter/material.dart';

/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/21 14:58
 */
class AccountInit {
  String accessToken;
  String tokenType;
  String refreshToken;
  int expiresIn;
  String scope;
  String license;
  int deptId;
  int userId;
  String username;

  AccountInit(
          {this.accessToken,
            this.tokenType,
            this.refreshToken,
            this.expiresIn,
            this.scope,
            this.license,
            this.deptId,
            this.userId,
            this.username});

  AccountInit.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    license = json['license'];
    deptId = json['dept_id'];
    userId = json['user_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['refresh_token'] = this.refreshToken;
    data['expires_in'] = this.expiresIn;
    data['scope'] = this.scope;
    data['license'] = this.license;
    data['dept_id'] = this.deptId;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}