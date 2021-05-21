import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ova_app_client/config/env_config.dart';
import 'package:ova_app_client/config/global_style_config.dart';
import 'package:ova_app_client/pages/account/login_page.dart';
import 'package:ova_app_client/utils/storage_manager.dart';
import 'package:provider/provider.dart';


void main() async{
  EnvConfig.env = Env.DEV;
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: GlobalStyleConfig.themeData,
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
