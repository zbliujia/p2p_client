

import '../models/user.dart';
import 'server_base.dart';

class ServerApi {

  static Future sendCode(String phone) async {
    await HttpUtil.postHttpData('/api/v1/user/sendCode', {'phone': phone});
    return;
  }

  static Future<User> loginByCode(String phone, String code) async {
    await HttpUtil.clear();
    final result = await HttpUtil.postHttpData('/api/v1/user/loginByCode', {'phone': phone, 'code': code});
    return User.fromJson(result);
  }

  static Future<User> userInfo() async {
    final result = await HttpUtil.postHttpData('/api/v1/user/info', {});
    return User.fromJson(result);
  }

  // static Future<UserInfo> getUserInfo() async {
  //   final result = await HttpUtil.getHttpData('/sdstation/user/getUserInfo');
  //   return UserInfo.fromJson(result);
  // }

}
