import 'package:dio/dio.dart';
import 'package:p2p_client/models/device_info.dart';
import 'package:path/path.dart';
import 'device_base.dart';

class DeviceApi {
  static Future<DeviceInfo> getDeviceInfo(String token) async {
    final result =
        await HttpUtil.getHttpData('/GetDeviceInfo.php', {'token': token});
    return DeviceInfo.fromJson(result);
  }

  static Future<DeviceInfo> getFileList(String category) async {
    final result =
        await HttpUtil.getHttpData('/GetFileList.php', {'category': category});
    return DeviceInfo.fromJson(result);
  }

  static Future<void> uploadFile(String filePath) async {
    final result = await HttpUtil.postHttpBinaryData(
        '/AddFile.php',
        {
          'file_name': basename(filePath),
        },
        filePath);
    return result;
  }
}
