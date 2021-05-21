import 'package:flutter/material.dart';

/* *
 * @Author: JYF
 * @Description:    
 * @Date: create in 2021/5/21 13:36
 */
class GlobalStyleConfig{
  static ThemeData themeData=ThemeData(
     primarySwatch: Colors.blue,
     visualDensity: VisualDensity.adaptivePlatformDensity,
     // Define the default brightness and colors.
     brightness: Brightness.dark,
     primaryColor: Colors.lightBlue[800],
     accentColor: Colors.cyan[600],

     fontFamily: 'Montserrat',//全局字体风格

     textTheme: TextTheme(
       headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
       headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
       bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
     ),
   );
}