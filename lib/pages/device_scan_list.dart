import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_client/common/const.dart';
import 'package:p2p_client/common/find_devices.dart';
import 'package:p2p_client/models/device_info.dart';
import 'package:p2p_client/pages/device_scan.dart';
import 'package:p2p_client/widgets/base_state.dart';
import 'package:p2p_client/widgets/custom_button.dart';

import '../common/color_util.dart';
import '../widgets/base_stateful_widget.dart';

class DeviceScanListPage extends BaseStatefulWidget {
  final Object? arguments;
  final List<DeviceInfo> devices;

  DeviceScanListPage({Key? key, required this.devices, this.arguments})
      : super(key: key);

  @override
  State createState() => _DeviceScanListPageState();
}

class _DeviceScanListPageState extends BaseState<DeviceScanListPage> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: const Text("搜索结果"),
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
          padding: EdgeInsets.only(
              top: appBar.preferredSize.height +
                  MediaQuery.of(context).padding.top),
          color: ColorUtil.mainBgColor,
          width: double.infinity,
          height: double.infinity,
          child: ListView.separated(
            padding:
                EdgeInsets.only(top: 0, bottom: 0, left: 24.w, right: 24.w),
            itemCount: widget.devices.length,
            //列表项构造器
            itemBuilder: (BuildContext context, int index) {
              var device = widget.devices[index];
              return InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 14.w, right: 14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.w),
                  ),
                  height: 93.w,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/login_logo.png',
                        width: 62.w,
                        height: 55.w,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "型号：${device.brand}",
                                style: TextStyle(
                                    color: ColorUtil.blackTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "SN：${device.id}",
                                style: TextStyle(
                                    color: ColorUtil.greyTextColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        child: Text("绑定设备", style: TextStyle(
                                  color: ColorUtil.greenTextColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              );
            },
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 10.w,
              );
            },
          )),
    );
  }
}
