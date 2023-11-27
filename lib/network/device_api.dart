

import 'package:p2p_client/models/device_info.dart';

import 'device_base.dart';

class DeviceApi {

  static Future<DeviceInfo> getDeviceInfo(String token) async {
    final result = await HttpUtil.getHttpData('/GetDeviceInfo.php', {'token': token});
    return DeviceInfo.fromJson(result);
  }

}
