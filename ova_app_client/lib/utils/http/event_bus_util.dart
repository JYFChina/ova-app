import 'package:event_bus/event_bus.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/26 9:44
 */
enum MessageStatus{
  ERROR,
  SUCCESS,
  WARING
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
