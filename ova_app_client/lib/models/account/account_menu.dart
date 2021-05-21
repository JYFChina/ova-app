import 'package:flutter/material.dart';

/* *
 * @Author: JYF
 * @Description:    账户菜单
 * @Date: create in 2021/5/21 14:41
 */
class AccountMenu {
  int id;
  int parentId;
  List<AccountMenu> children;
  bool hasChildren;
  String icon;
  String name;
  bool spread;
  String path;
  String keepAlive;
  Null permission;
  String type;
  String label;
  int sort;

  AccountMenu(
          {this.id,
            this.parentId,
            this.children,
            this.hasChildren,
            this.icon,
            this.name,
            this.spread,
            this.path,
            this.keepAlive,
            this.permission,
            this.type,
            this.label,
            this.sort});

  AccountMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parentId'];
    if (json['children'] != null) {
      children = new List<AccountMenu>();
      json['children'].forEach((v) {
        children.add(new AccountMenu.fromJson(v));
      });
    }
    hasChildren = json['hasChildren'];
    icon = json['icon'];
    name = json['name'];
    spread = json['spread'];
    path = json['path'];
    keepAlive = json['keepAlive'];
    permission = json['permission'];
    type = json['type'];
    label = json['label'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentId'] = this.parentId;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    data['hasChildren'] = this.hasChildren;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['spread'] = this.spread;
    data['path'] = this.path;
    data['keepAlive'] = this.keepAlive;
    data['permission'] = this.permission;
    data['type'] = this.type;
    data['label'] = this.label;
    data['sort'] = this.sort;
    return data;
  }
}