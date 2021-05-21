import 'package:flutter/material.dart';
import 'package:ova_app_client/models/account/account.dart';

/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/21 15:03
 */
class AccountInfo {
  Account sysUser;
  List<String> permissions;
  List<int> roles;

  AccountInfo({this.sysUser, this.permissions, this.roles});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    sysUser =
    json['sysUser'] != null ? new Account.fromJson(json['sysUser']) : null;
    permissions = json['permissions'].cast<String>();
    roles = json['roles'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sysUser != null) {
      data['sysUser'] = this.sysUser.toJson();
    }
    data['permissions'] = this.permissions;
    data['roles'] = this.roles;
    return data;
  }
}