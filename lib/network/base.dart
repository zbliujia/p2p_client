import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import '../common/global.dart';

class HttpError implements Exception {
  HttpError({
    required this.errNo,
    required this.errMsg,
  });

  String errMsg;
  int errNo;

  String get message => errMsg;

  @override
  String toString() => errMsg;
}

class HttpUtil {
  static String get host {
    return "http://10.250.24.211:3000";
    // return "http://127.0.0.1:3000";
  }

  static String get session {
    return "";
  }

  static final dio = Dio(BaseOptions(
    //配置连接超时时间
    connectTimeout: const Duration(seconds: 5),
    //配置发送超时时间
    sendTimeout: const Duration(seconds: 30),
    //配置接收超时时间
    receiveTimeout: const Duration(seconds: 30),
  ));
  static CookieJar? cookieJar;

  static Future<void> init() async {
    if (cookieJar != null) {
      return;
    }
    Directory tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;
    cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage(tempPath),
    );
    dio.interceptors.add(CookieManager(cookieJar!));
  }

  static Future<void> clear() async {
    await cookieJar?.deleteAll();
  }

  static Future getHttpData(String url,
      [Map<String, dynamic> params = const {}]) async {
    await init();
    Options options = Options(
      headers: {
        'cookie':
            'version=${Global.packageInfo?.version};buildNumber=${Global.packageInfo?.buildNumber};',
      },
    );

    String requestUrl = url.startsWith('http') ? url : '$host$url';
    try {
      debugPrint(
          "requestUrl=>$requestUrl \n params=>$params \n options$options");
      final response =
          await dio.get(requestUrl, queryParameters: params, options: options);
      debugPrint("requestUrl=>$requestUrl\nresponse=>$response");
      if (response.statusCode != 200) {
        throw HttpError(errNo: -1, errMsg: 'code is $response.statusCode');
      }
      if (response.data['errNo'] != 0) {
        throw HttpError(
            errNo: response.data['errNo'], errMsg: response.data['errMsg']);
      }
      return response.data['data'];
    } on DioException catch (e) {
      String errMsg = "网络请求失败，请稍后重试";
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          errMsg = "网络请求超时，请稍后重试";
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.connectionError:
        case DioExceptionType.badResponse:
          errMsg = "服务响应异常，请稍后重试";
          break;
        case DioExceptionType.unknown:
          errMsg = "网络连接异常，请检查网络";
          break;
        case DioExceptionType.cancel:
          errMsg = "";
      }
      if (errMsg.isNotEmpty) {
        throw HttpError(errNo: -1, errMsg: errMsg);
      }
      return null;
    } catch (e) {
      throw HttpError(errNo: -1, errMsg: "网络请求失败，请稍后重试");
    }
  }

  static Future<dynamic> postHttpData(String url, Map<String, dynamic> params,
      {String contentType = 'application/json',
      bool showLoading = false}) async {
    await init();
    if (showLoading) {
      EasyLoading.show();
    }
    Options options = Options(
      headers: {
        'cookie':
            'version=${Global.packageInfo?.version};buildNumber=${Global.packageInfo?.buildNumber};',
      },
    );

    String requestUrl = url.startsWith('http') ? url : '$host$url';
    dynamic data = contentType != 'multipart/form-data'
        ? params
        : FormData.fromMap(params);
    try {
      debugPrint("requestUrl=>$requestUrl \n options=>$options \n data=>$data");
      final response = await dio.post(requestUrl, options: options, data: data);
      debugPrint("requestUrl=>$requestUrl\n response=>$response");
      if (response.statusCode != 200) {
        throw HttpError(errNo: -1, errMsg: 'code is $response.statusCode');
      }
      if (response.data['errNo'] != 0) {
        throw HttpError(
            errNo: response.data['errNo'], errMsg: response.data['errMsg']);
      }
      return response.data['data'];
    } on DioException catch (e) {
      String errMsg = "网络请求失败，请稍后重试";
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          errMsg = "网络请求超时，请稍后重试";
          break;
        case DioExceptionType.badCertificate:
        case DioExceptionType.connectionError:
        case DioExceptionType.badResponse:
          errMsg = "服务响应异常，请稍后重试";
          break;
        case DioExceptionType.unknown:
          errMsg = "网络连接异常，请检查网络";
          break;
        case DioExceptionType.cancel:
          errMsg = "";
      }
      if (errMsg.isNotEmpty) {
        throw HttpError(errNo: -1, errMsg: errMsg);
      }
      return null;
    } catch (e) {
      if (e is HttpError) {
        rethrow;
      }
      throw HttpError(errNo: -1, errMsg: "网络请求失败，请稍后重试");
    } finally {
      if (showLoading) {
        EasyLoading.dismiss();
      }
    }
  }
}
