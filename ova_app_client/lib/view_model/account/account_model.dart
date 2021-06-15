import 'package:flutter/material.dart';
import 'package:ova_app_client/config/env_config.dart';
import 'package:ova_app_client/config/http_config.dart';
import 'package:ova_app_client/models/account/account.dart';
import 'package:ova_app_client/models/account/account_info.dart';
import 'package:ova_app_client/models/account/account_init.dart';
import 'package:ova_app_client/models/account/account_menu.dart';
import 'package:ova_app_client/models/account/req_dto/account_dto.dart';
import 'package:ova_app_client/service/account_service.dart';
import 'package:ova_app_client/utils/http/dio_util.dart';
import 'package:ova_app_client/utils/http/http_code.dart';
import 'package:ova_app_client/utils/storage_manager.dart';
import 'package:ova_app_client/utils/util.dart';

/* *
 * @Author: JYF
 * @Description:    账户
 * @Date: create in 2021/5/17 15:39
 */
class AccountModel with ChangeNotifier {
  Account account;
  String _imageUrl;
  String randomStr;
  get imageUrl => _imageUrl;

  AccountModel({this.randomStr});

  /* * 功能描述: 获取图形验证码
  * @Author: JYF
  * @date: 2021/5/21 13:55
  */
  void getImageCode() async {
    this.randomStr =
        Utils.getRandomLenNum(4, DateTime.now().millisecondsSinceEpoch);
    this._imageUrl = await AccountService.getImageCode(this.randomStr);
    notifyListeners();
  }

  /* * 功能描述: 退出登录
    *
    * @return: bool 成功失败
    * @Author: JYF
    * @date: 2021/5/24 10:40
    *
    */
  Future<bool> logOut() async {
    //清除token
    StorageManager.sharedPreferences.remove(HttpConfig.TOKEN_KEY);
    //清除登陆信息
    StorageManager.sharedPreferences.remove(HttpConfig.LOGIN_STATUS);
    //清除用户信息
    StorageManager.sharedPreferences.remove(HttpConfig.USER_INFO);

    return true;
  }

  /* * 功能描述:
    *
    * @param: account 账户对象
    * @return: isLogin 登陆状态
    * @Author: JYF
    * @date: 2021/5/21 13:55
    */
  Future<bool> phoneLogin(AccountDTO account) async {

      //移除token
      StorageManager.sharedPreferences.remove(HttpConfig.TOKEN_KEY);
      //发送登陆请求
      ResModel<AccountInit> response = await AccountService.phoneLogin(account);

      if (response != null) {
        //绑定用户登陆状态信息
        StorageManager.localStorage
            .setItem(HttpConfig.LOGIN_STATUS, response.data);
        //获取用户信息
        getUserInfo();
        return true;
      } else {
        return false;
      }

  }

  /* * 功能描述:获取用户信息
  * @Author: JYF
  * @date: 2021/5/21 14:31
  */
  Future<ResModel> getUserInfo() async {
    ResModel response = await AccountService.getUserInfo();

    if (response != null) {
      StorageManager.localStorage.setItem(HttpConfig.USER_INFO, response.data);
      return response;
    } else {
      return null;
    }
  }

  /* * 功能描述: 获取用户所有菜单信息
    * @param:parentId 父级ID
    * @Author: JYF
    * @date: 2021/5/21 14:07
    */
  Future<ResModel> getMenu(String parentId) async {
    ResModel response = await AccountService.getMenu(parentId);
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  /* * 功能描述: 获取用户底部导航菜单
      * @param:
      * @return:
      * @Author: JYF
      * @date: 2021/5/21 14:07
      */
  Future<ResModel> getBottomNavMenu() async {
    ResModel response = await AccountService.getBottomNavMenu();
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }
}
