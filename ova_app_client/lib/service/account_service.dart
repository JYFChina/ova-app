/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/24 10:03
 */
import 'package:ova_app_client/config/env_config.dart';
import 'package:ova_app_client/models/account/account_info.dart';
import 'package:ova_app_client/models/account/account_init.dart';
import 'package:ova_app_client/models/account/account_menu.dart';
import 'package:ova_app_client/models/account/req_dto/account_dto.dart';
import 'package:ova_app_client/utils/http/dio_util.dart';

/* *
 * @Author: JYF
 * @Description:    账户
 * @Date: create in 2021/5/17 15:39
 */
class AccountService {
/* * 功能描述: 获取图形验证码
  * @Author: JYF
  * @date: 2021/5/21 13:55
  */
  static Future<String> getImageCode(String randomStr) async {
    return "${EnvConfig.apiHost}${EnvConfig.codeUrl}?randomStr=$randomStr";
  }

/* * 功能描述:
    *
    * @param: account 账户对象
    * @return: response 登陆信息
    * @Author: JYF
    * @date: 2021/5/21 13:55
    */
  static Future<ResponseData> phoneLogin(AccountDTO account) async {
    try {
      //发送登陆请求
      ResponseData<AccountInit> response =
          await HttpRequest.post("/auth/oauth/token", param: account.toJson());

      if (response != null && response.result) {
        response.data = AccountInit.fromJson(response.jsonData);
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

/* * 功能描述:获取用户信息
* @param:
* @return:
* @Author: JYF
* @date: 2021/5/21 14:31
*/
  static Future<ResponseData> getUserInfo() async {
    ResponseData<AccountInfo> response =
        await HttpRequest.get("/admin/user/info");

    if (response != null && response.result) {
      response.data = AccountInfo.fromJson(response.jsonData);
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
  static Future<ResponseData> getMenu(String parentId) async {
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
  static Future<ResponseData> getBottomNavMenu() async {
    ResponseData response = await HttpRequest.post("/auth/oauth/token");

    if (response != null && response.result) {
      return response;
    } else {
      return null;
    }
  }
}
