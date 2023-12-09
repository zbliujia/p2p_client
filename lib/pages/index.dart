import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/pages/device_scan.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class IndexPage extends BaseStatefulWidget {
  final Object? arguments;

  IndexPage({Key? key, this.arguments}) : super(key: key);

  @override
  State createState() => _IndexPageState();
}

class _IndexPageState extends BaseState<IndexPage> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("我的设备"),
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
                "添加新设备",
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return DeviceScanPage();
                    },
                    settings:
                        const RouteSettings(name: RouterPath.pathDeviceAdd),
                  ));
                },
              )
            ],
          )),
    );
  }
}
