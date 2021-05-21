import 'package:flutter/material.dart';
import 'dart:math';
/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/17 16:02
 */

/* *
 * 生成随机len位数字
 */
class Utils {
  static String getRandomLenNum(len, date) {
    String random = '';
    var rng = new Random();
    random = (rng.nextDouble() * 100000000000000)
        .round()
        .toString()
        .substring(0, len != null ? len : 4);
    if (date != null)
      random = random + DateTime.now().millisecondsSinceEpoch.toString();
    return random;
  }
}
