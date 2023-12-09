import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/models/device_info.dart';
import 'package:p2p_client/network/device_base.dart';
import 'package:p2p_client/pages/index.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class DeviceConnectPage extends BaseStatefulWidget {
  final Object? arguments;
  final DeviceInfo device;

  DeviceConnectPage({Key? key, required this.device, this.arguments})
      : super(key: key);

  @override
  State createState() => _DeviceConnectPageState();
}

class _DeviceConnectPageState extends BaseState<DeviceConnectPage> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("连接设备"),
      centerTitle: true,
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
                "连接设备",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0xFFCCCCCC),
                  // fontWeight: FontWeight.w600,
                ),
              ),
              CustomButton(
                titleStr: "+",
                width: 84.w,
                height: 40.w,
                style: null,
                onTap: () {
                  HttpUtil.host = "http://${widget.device.publicAddr}";
                  EasyLoading.showSuccess("连接成功");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) {
                      return IndexPage();
                    },
                    settings: const RouteSettings(name: RouterPath.pathIndex),
                  ));
                },
              )
            ],
          )),
    );
  }
}
