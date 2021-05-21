/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/17 15:19
 */


class Account {
  int userId;
  String username;
  String password;
  String createTime;
  String updateTime;
  String lockFlag;
  String phone;
  String avatar;
  int deptId;
  String delFlag;

  Account({this.userId,
    this.username,
    this.password,
    this.createTime,
    this.updateTime,
    this.lockFlag,
    this.phone,
    this.avatar,
    this.deptId,
    this.delFlag});

  Account.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    username = json['username'];
    password = json['password'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    lockFlag = json['lockFlag'];
    phone = json['phone'];
    avatar = json['avatar'];
    deptId = json['deptId'];
    delFlag = json['delFlag'];
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['lockFlag'] = this.lockFlag;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    data['deptId'] = this.deptId;
    data['delFlag'] = this.delFlag;
    return data;
  }
}