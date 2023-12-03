import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/models/device_info.dart';
import 'package:p2p_client/pages/device_scan_list.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class DeviceBindPage extends BaseStatefulWidget {
  final Object? arguments;
  final DeviceInfo device;

  DeviceBindPage({Key? key, required this.device, this.arguments})
      : super(key: key);

  @override
  State createState() => _DeviceBindPageState();
}

class _DeviceBindPageState extends BaseState<DeviceBindPage> {
  String textTitleFirst = "设备首次绑定，您将成为该设备的管理员";
  String textTitleOther = "设备绑定";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text(
        '绑定设备',
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 97.w),
                child: Image.asset(
                  'assets/images/device_bind_logo.png',
                  width: 171.w,
                  height: 161.w,
                ),
              ),
              SizedBox(
                height: 56.w,
              ),
              Text(
                textTitleFirst,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: const Color(0xFF767676),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 34.w,
              ),
              CustomButton(
                titleStr: "绑定设备",
                bgStyle: CustomButtonBG.customButtonSmallGreenButtonStyle,
                onTap: () {},
              )
            ],
          )),
    );
  }
}
