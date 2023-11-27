
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/pages/device_scan.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class DeviceAddPage extends BaseStatefulWidget {
  final Object? arguments;

  DeviceAddPage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _DeviceAddPageState();
}

class _DeviceAddPageState extends State<DeviceAddPage> {

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
                "暂无设备",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: const Color(0xFF3D3D3D),
                  // fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                child: const Text("去添加"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return DeviceScanPage();
                    },
                    settings: const RouteSettings(name: RouterPath.pathDeviceAdd),
                  ));
                },
              )
            ],
          )),
    );
  }
}
