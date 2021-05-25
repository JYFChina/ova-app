import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/19 13:43
 */
///网络请求错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const NETWORK_JSON_EXCEPTION = -3;

  static const SUCCESS = 200;

  static final EventBus eventBus = new EventBus();

  static errorHandleFunction(code, message, noTip) {
    if (noTip) {
      return message;
    }
    eventBus.fire(new HttpErrorEvent(code, message));
    return message;
  }
}

class EventBusUtil {
  static EventBus _eventBus;

  static EventBus getInstance() {
    if (_eventBus == null) {
      _eventBus = new EventBus();
    }
    return _eventBus;
  }

  /* *
   *  加载
   */
  static loading(){
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.cubeGrid;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: '请稍后...', dismissOnTap: false);
  }

  /* *
   * 通知
   */
  static notify(String message,{MessageStatus status}){
    switch(status){
      case MessageStatus.SUCCESS:
        EasyLoading.showSuccess(message);
        break;
      case MessageStatus.ERROR:
        EasyLoading.showError(message);
        break;
      case MessageStatus.WARING:
        EasyLoading.showInfo(message);
        break;
      default:
        EasyLoading.showToast(message);
        break;
    }

  }
  /* *
   * 结束加载
   */
  static done(){
    EasyLoading.dismiss(animation: false);
  }

}

class HttpConfig {
  static const String TOKEN_KEY = "token";

  static const String USER_BASIC_CODE = "Basic cGlnOnBpZw==";

  static const String LOGIN_STATUS = "login_status";

  static const String USER_INFO="user_info";

  static const bool DEBUG = true;
}

class HttpErrorEvent {
  final int code;
  final String message;

  HttpErrorEvent(this.code, this.message);
}
enum MessageStatus{
  ERROR,
  SUCCESS,
  WARING
}