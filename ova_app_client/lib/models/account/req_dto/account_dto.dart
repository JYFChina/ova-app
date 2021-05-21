
/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/21 15:11
 */
class AccountDTO {
  String username;
  String password;
  String randomStr;
  String code;
  String grantType;
  String scope;
  String loginType;
  AccountDTO();
  AccountDTO.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    randomStr = json['randomStr'];
    code = json['code'];
    grantType = json['grant_type'];
    scope = json['scope'];
    loginType = json['login_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['randomStr'] = this.randomStr;
    data['code'] = this.code;
    data['grant_type'] = this.grantType;
    data['scope'] = this.scope;
    data['login_type'] = this.loginType;
    return data;
  }
}