import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/user.dart';

class Global {

  static PackageInfo? packageInfo;
  static User? userInfo;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    packageInfo = await PackageInfo.fromPlatform();
  }
}