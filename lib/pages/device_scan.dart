import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/pages/device_scan_list.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class DeviceScanPage extends BaseStatefulWidget {
  final Object? arguments;

  DeviceScanPage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _DeviceScanPageState();
}

class _DeviceScanPageState extends BaseState<DeviceScanPage> {
  bool isScanning = true;
  String textTitleIng = "正在搜索设备";
  String textDesc = "请确认设备已开启，并和手机在同一局域网内";
  String textTitleError = "搜索完成，未发现设备";

  void scan() async {
    try {
      setState(() {
        isScanning = true;
      });
      final devices = await scanNetworkByHttp();
      if (context.mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return DeviceScanListPage(
              devices: devices,
            );
          },
          settings: const RouteSettings(name: RouterPath.pathDeviceScanList),
        ));
      }
    } on Exception catch (e) {
      setState(() {
        isScanning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      scan();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        '我的设备',
      ),
      centerTitle: true,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      // extendBodyBehindAppBar: true,
      body: Container(
          padding: EdgeInsets.only(
              top: appBar.preferredSize.height +
                  MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom),
          color: ColorUtil.mainBgColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Lottie.asset('assets/lotties/device_scan.json')),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 32.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          isScanning ? textTitleIng : textTitleError,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: const Color(0xFF767676),
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        Text(
                          textDesc,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFFCCCCCC),
                            // fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 54.w,
                        ),
                        isScanning
                            ? const SizedBox.shrink()
                            : CustomButton(
                                titleStr: "扫码连接",
                                bgStyle: CustomButtonBG
                                    .customButtonSmallGreenButtonStyle,
                                onTap: () {},
                              ),
                        SizedBox(
                          height: 14.w,
                        ),
                        isScanning
                            ? const SizedBox.shrink()
                            : CustomButton(
                                titleStr: "重新搜索",
                                bgStyle: CustomButtonBG
                                    .customButtonSmallWhiteButtonStyle,
                                onTap: () {
                                  scan();
                                },
                              ),
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
