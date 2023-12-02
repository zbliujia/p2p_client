
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/widgets/base_state.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class DeviceScanPage extends BaseStatefulWidget {
  final Object? arguments;

  DeviceScanPage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _DeviceScanPageState();
}

class _DeviceScanPageState extends BaseState<DeviceScanPage> {

  String text = "正在为你扫描设备";

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      // iconTheme: const IconThemeData(
      //   color: Colors.black, // 设置返回箭头颜色为白色
      // ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      // title: const Text(
      //   '',
      //   style: TextStyle(color: ColorUtil.navBlackTitleTextColor),
      // ),
      // centerTitle: true,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      // extendBodyBehindAppBar: true,
      body: Container(
          padding: EdgeInsets.only(
              top: appBar.preferredSize.height +
                  MediaQuery.of(context).padding.top),
          color: ColorUtil.mainBgColor,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: const Color(0xFF3D3D3D),
                  // fontWeight: FontWeight.w600,
                ),
              ),
              Lottie.asset('assets/lotties/device_scan.json'),
            ],
          )),
    );
  }
}
