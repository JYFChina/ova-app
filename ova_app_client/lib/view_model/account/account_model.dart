import 'package:flutter/material.dart';
import 'package:ova_app_client/config/env_config.dart';
import 'package:ova_app_client/models/account/account_init.dart';
import 'package:ova_app_client/models/account/account_menu.dart';
import 'package:ova_app_client/models/account/req_dto/account_dto.dart';
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
    this._imageUrl =
        "${EnvConfig.apiHost}${EnvConfig.codeUrl}?randomStr=${this.randomStr}";
    notifyListeners();
  }

  /* * 功能描述:
    *
    * @param: account 账户对象
    * @return: isLogin 登陆状态
    * @Author: JYF
    * @date: 2021/5/21 13:55
    */
  Future<bool> phoneLogin(AccountDTO account) async {
    try {
      //移除token
      StorageManager.sharedPreferences.remove(HttpConfig.TOKEN_KEY);
      //发送登陆请求
      ResponseData response =
          await HttpRequest.post("/auth/oauth/token", param: account.toJson());

      if (response != null && response.result) {
        response.data = AccountInit.fromJson(response.jsonData);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

/* * 功能描述:获取用户信息
* @param:
* @return:
* @Author: JYF
* @date: 2021/5/21 14:31
*/
  Future<ResponseData> getUserInfo() async {
    ResponseData response = await HttpRequest.post("/admin/user/info");

    if (response != null && response.result) {
      return response;
    } else {
      return null;
    }
  }

  /* * 功能描述: 获取用户所有菜单信息
    * @param:parentId 父级ID
    * @return:
    * @Author: JYF
    * @date: 2021/5/21 14:07
    */
  Future<ResponseData> getMenu(String parentId) async {
    ResponseData response =
        await HttpRequest.get("/admin/menu", param: {'parentId': parentId});
    response.data = AccountMenu.fromJson(response.jsonData);
    if (response != null && response.result) {
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
  Future<ResponseData> getBottomNavMenu() async {
    ResponseData response = await HttpRequest.post("/auth/oauth/token");

    if (response != null && response.result) {
      return response;
    } else {
      return null;
    }
  }
}
