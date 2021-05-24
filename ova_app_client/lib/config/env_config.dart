import 'package:flutter/material.dart';

/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/18 13:59
 */
class EnvConfig{
  static Env env;
  static String codeUrl='/code';
  static String get apiHost {
    switch (env) {
      case Env.PRO:
        return "http://g9ixej.natappfree.cc";
      case Env.DEV:
        return "http://g9ixej.natappfree.cc";
      case Env.LOCAL:
      default:
        return "http://g9ixej.natappfree.cc";
    }
  }
}
enum Env {
  PRO,
  DEV,
  LOCAL,
}